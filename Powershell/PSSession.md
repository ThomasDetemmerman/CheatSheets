## Create new pssessions
```
New-PSSessionConfigurationfile -path ./a.pssc -VisibleCmdlets Get-*
Register-PSSessionConfiguration -name a -path .\a.pssc

New-PSSessionConfigurationfile -path ./b.pssc -VisibleCmdlets Get-*, new-aduser
Register-PSSessionConfiguration -name b -path .\b.pssc -ShowSecurityDescriptorUI -RunAsCredential domain/admin
```
## Het aanpassen van een pssessionconfiguration
```
Set-PSSessionConfiguration -name a
```
example: change rights to the configurationfile
```
Set-PSSessionConfiguration -name a -ShowSecurityDescriptorUI
```
example: change the run as
```
Set-PSSessionConfiguration -name a -RunAsCredential domain\user
```
## Connect to specific configuration
```
Invoke-PSSession -computerName <ip> -credential (get-credential) -ConfigurationName a
```
