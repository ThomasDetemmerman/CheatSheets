# How to understand/write/change this script.
# Use the following documentation: https://docs.microsoft.com/en-us/powershell/module/azuread/set-azureadmsprivilegedrolesetting?view=azureadps-2.0-preview
# You'll see that the parameters expect a list of AzureADMSPrivilegedRuleSetting. When only one AzureADMSPrivilegedRuleSetting needs to be configured, there is no need for a list and you can directly parse the AzureADMSPrivilegedRuleSetting as a parameter.
# The JSON is generated as follows. You go to pim and go to the settings of the permissions that you want to edit. Configure the settings and look in de debug console to "network" and check the data that is patched in the section "Request"
#
# Additional links
# https://www.jasonfritts.me/2021/07/20/automating-azure-privileged-identity-management-pim-with-powershell/
# https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/powershell-for-azure-ad-roles
# https://stackoverflow.com/questions/62422237/is-it-possible-to-use-azure-graph-api-to-change-notifications-in-pim

function set-PIMRoleAssignmentsettings {
    param (
        $RoleDefinitionName,
        $subscriptionID,
        $ResourceGroupName

    )
    
    $ResourceGroupID = "/subscriptions/$subscriptionID/resourceGroups/$ResourceGroupName"
    
    $UserMemberSettings = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting
    $UserMemberSettings.RuleIdentifier = "NotificationRule"   
    $UserMemberSettings.Setting = '{"policies":[{"deliveryMechanism":"email","setting":[{"customreceivers":["mail@mail.be"],"isdefaultreceiverenabled":false,"notificationlevel":2,"recipienttype":2},{"customreceivers":null,"isdefaultreceiverenabled":true,"notificationlevel":2,"recipienttype":0},{"customreceivers":null,"isdefaultreceiverenabled":true,"notificationlevel":2,"recipienttype":1}]}]}'

    $AdminEligibleSettings_notification = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting
    $AdminEligibleSettings_notification.RuleIdentifier = "NotificationRule"
    $AdminEligibleSettings_notification.Setting = '{"policies":[{"deliveryMechanism":"email","setting":[{"customreceivers":null,"isdefaultreceiverenabled":false,"notificationlevel":2,"recipienttype":2},{"customreceivers":null,"isdefaultreceiverenabled":false,"notificationlevel":2,"recipienttype":0},{"customreceivers":null,"isdefaultreceiverenabled":true,"notificationlevel":2,"recipienttype":1}]}]}'
    
    $AdminEligibleSettings_expiration = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting
    $AdminEligibleSettings_expiration.RuleIdentifier = "ExpirationRule"
    $AdminEligibleSettings_expiration.Setting = '{"permanentAssignment":true,"maximumGrantPeriodInMinutes":259200}'

    $AdminEligibleSettings = New-Object System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedRuleSetting]
    $AdminEligibleSettings.Add($AdminEligibleSettings_expiration)
    $AdminEligibleSettings.Add($AdminEligibleSettings_notification)

    $roleDefinitionID = $(Get-AzRoleDefinition -Name $RoleDefinitionName).Id
    $SubscriptionPIMID = (Get-AzureADMSPrivilegedResource -ProviderId 'AzureResources' -Filter "ExternalId eq '$ResourceGroupID'").Id
    $RoleDefinitionPIMID = (Get-AzureADMSPrivilegedRoleDefinition -ProviderId 'AzureResources' -Filter "ExternalId eq '/subscriptions/$subscriptionID/providers/Microsoft.Authorization/roleDefinitions/$roleDefinitionID'" -ResourceId $subscriptionPIMID).Id
    $rolesettingid = (Get-AzureADMSPrivilegedRoleSetting -ProviderId 'AzureResources' -Filter "ResourceId eq '$SubscriptionPIMID' and RoleDefinitionId eq '$RoleDefinitionPIMID'").id
    Set-AzureADMSPrivilegedRoleSetting -ProviderId 'AzureResources' -Id $rolesettingid -ResourceId $SubscriptionPIMID -RoleDefinitionId $roleDefinitionID -UserMemberSettings $UserMemberSettings  -AdminEligibleSettings $AdminEligibleSettings
    
}


function set-PIMRoleAssignment {
    param (
        $RoleDefinitionName,
        $subscriptionID,
        $ResourceGroupName

    )

    $schedule = New-Object Microsoft.Open.MSGraph.Model.AzureADMSPrivilegedSchedule
    $schedule.Type = "Once"
    $schedule.StartDateTime = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")

    $roleDefinitionID = $(Get-AzRoleDefinition -Name $RoleDefinitionName).Id
    $ResourceGroupID = "/subscriptions/$subscriptionID/resourceGroups/$ResourceGroupName"
    Open-AzureADMSPrivilegedRoleAssignmentRequest -ProviderId 'AzureResources' -ResourceId $ResourceGroupPIMResourceID -RoleDefinitionId $roleDefinitionID -SubjectId $subjectid -Type 'adminAdd' -AssignmentState 'Eligible' -schedule $schedule

}

