#https://www.jasonfritts.me/2021/07/20/automating-azure-privileged-identity-management-pim-with-powershell/
#https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/powershell-for-azure-ad-roles
#https://stackoverflow.com/questions/62422237/is-it-possible-to-use-azure-graph-api-to-change-notifications-in-pim

$keyvaultadmin = "00482a5a-887f-4fb3-b363-3b7fe8e74483"
$subidprod = *****
$tenant = ******

$subscriptionID = $subidprod
$roleDefinitionID = $keyvaultadmin


$settinga = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting
$settinga.RuleIdentifier = "NotificationRule"
#go to pim, configure the notifications and look in de debug console to "network" and check the data that is patched.
$settinga.Setting = '{"policies":[{"deliveryMechanism":"email","setting":[{"customreceivers":["mail@mail.be"],"isdefaultreceiverenabled":false,"notificationlevel":2,"recipienttype":2},{"customreceivers":null,"isdefaultreceiverenabled":true,"notificationlevel":2,"recipienttype":0},{"customreceivers":null,"isdefaultreceiverenabled":true,"notificationlevel":2,"recipienttype":1}]}]}'

$settingadmin = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting
$settingadmin.RuleIdentifier = "NotificationRule"
$settingadmin.Setting = '{"policies":[{"deliveryMechanism":"email","setting":[{"customreceivers":null,"isdefaultreceiverenabled":false,"notificationlevel":2,"recipienttype":2},{"customreceivers":null,"isdefaultreceiverenabled":false,"notificationlevel":2,"recipienttype":0},{"customreceivers":null,"isdefaultreceiverenabled":true,"notificationlevel":2,"recipienttype":1}]}]}'




foreach ($id in $((Get-AzResourceGroup).resourceId))
   {
       write-host "$id"

      # Convert IDs to PIM IDs
      $SubscriptionPIMID = (Get-AzureADMSPrivilegedResource -ProviderId 'AzureResources' -Filter "ExternalId eq '$id'").Id
      $RoleDefinitionPIMID = (Get-AzureADMSPrivilegedRoleDefinition -ProviderId 'AzureResources' -Filter "ExternalId eq '/subscriptions/$subscriptionID/providers/Microsoft.Authorization/roleDefinitions/$roleDefinitionID'" -ResourceId $subscriptionPIMID).Id

      $rolesettingid = (Get-AzureADMSPrivilegedRoleSetting -ProviderId 'AzureResources' -Filter "ResourceId eq '$SubscriptionPIMID' and RoleDefinitionId eq '$RoleDefinitionPIMID'").id





      Set-AzureADMSPrivilegedRoleSetting -ProviderId 'AzureResources' -Id $rolesettingid -ResourceId $SubscriptionPIMID -RoleDefinitionId $roleDefinitionID -UserMemberSettings $settinga  -AdminEligibleSettings $settingadmin

   }
