# Advanced Debugging
Perform the following steps in sequence.

### Init variables
```
$RGNAME = 'resourcegroup'
```

### Deploy template with a proper deployment name
```
New-AzResourceGroupDeployment -TemplateParameterFile .\main.parameters.json -TemplateFile .\main.json -Verbose -Mode Incremental -ResourceGroupName $RGNAME -DeploymentDebugLogLevel all -DeploymentName test
```

### Retrieve deployment data
```
$operations = Get-AzResourceGroupDeploymentOperation -DeploymentName test -ResourceGroupName $RGNAME
```

### Print requests and responses
```
foreach($operation in $operations)
 {
     Write-Host $operation.id
     Write-Host "Request:"
     $operation.Properties.Request | ConvertTo-Json -Depth 10
     Write-Host "Response:"
    $operation.Properties.Response | ConvertTo-Json -Depth 10
 }
```
