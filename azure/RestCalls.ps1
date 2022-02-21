
#https://community.powerbi.com/t5/Desktop/Azure-HTTP-POST-requests-for-an-access-token-from-Power-BI-power/td-p/968625
#https://docs.microsoft.com/en-us/graph/auth-v2-service
#https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow

$tenant          = '********'
$staname         = '********'
$container       = '********'
$filename        = '********'
$spnclientid     = '********'
$spnclientsecret = '********'
$baseurl         = "https://$staname.blob.core.windows.net" #for resources: https://management.azure.com
# get bearer token
$auturl =  "https://login.microsoftonline.com/$tenant/oauth2/token"
$method = 'POST'
$header = @{'Content-Type'= 'application/x-www-form-urlencoded'}
$body = @{
           "resource"     = $baseurl  #if not set: error invalid audience"
          "client_id"     = $spnclientid
          "grant_type"    = "client_credentials"
          "client_secret" = $spnclientsecret
}
$response = invoke-webrequest -Method $method -Uri $auturl -Headers $header -Body $body
$bearer = ($response.Content | convertfrom-json ).access_token
$bearer # paste the beaerer in this url to review https://www.jstoolset.com/jwt

#perform request
$header = @{
    'Content-Type'  = 'application/json'
    'Authorization' = "Bearer $bearer"
    'x-ms-version'  = '2018-03-28'              #api version
    'x-ms-date'     =  $(Get-Date -Format R)    #invalid date if not properly set
}


$urir = $baseurl  + $container + "?restype=container&comp=list"
$urir = $baseurl  + $container + $filename

$method = 'GET'
(invoke-webrequest -Method $method -Uri $urir -Headers $header).content
