[void] [System.Reflection.Assembly]::LoadWithPartialName("'System.Windows.Forms")

#global variables
$IURL= #URL
$name = #Username (from XML file)

#get random string permutation
Function Get-RandomAlphanumericString {
  $set = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()
  $size =  Get-Random -Minimum 5 -maximum 12
  For ($i=0; $i -le $size; $i++) {
      $result += $set | Get-Random
    }
  return $result	
}

#launch internet explorer
$ie = New-Object -com "InternetExplorer.Application"
$ie.visible = $true
$ie.silent = $true
$ie.Navigate($IURL)

#generate random value
$Password = Get-RandomAlphanumericString

 
#wait untill loaded
while ($ie.Busy) { Start-Sleep 1 }

#complete form
($ie.Document.IHTMLDocument3_getElementsByName("name")|select -first 1).value = $name
($ie.Document.IHTMLDocument3_getElementsByName("password")|select -first 1).value = $Password

#submit
Start-Sleep 1
($ie.document.getElementsByClassName("submit") | select -first 1).click()

#check for succes confirmation
$result = ($ie.document.getElementsByClassName("PostSubmitMessage") | select -first 1).innerText
if ([string]::IsNullOrEmpty($result)){$result = "error"}
Write-Host "Submitted user $name$domain with password $Password (return status: $result)"

#close browser
$ie.quit()


