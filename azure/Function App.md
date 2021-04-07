# Example to create a function app

## Init project
```
func init MyFunctionProj
cd MyFunctionProj
func new --name MyHttpTrigger --template "HttpTrigger"
```

## Test localy
```
func host start --build
```

## Setup Azure environment
```
az group create --name myResourceGroup --location westeurope
az storage account create --name <storage_name> --location westeurope --resource-group myResourceGroup --sku Standard_LRS
az functionapp create --resource-group myResourceGroup --consumption-plan-location westeurope \ --name <app_name> --storage-account  <storage_name> --runtime <language>
```

## Publish and test
```
func azure functionapp publish <FunctionAppName>
curl https://< app_name >.azurewebsites.net/api/MyHttpTrigger?name=< yourname >
```

## Network troubleshooting
List of executables
- nameresolver.exe
- tcpping.exe
- SET WEBSITE_DNS_
