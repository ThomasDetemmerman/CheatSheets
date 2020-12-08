# How to create a module (for azure functions)
```
PSFunctionApp
 | - MyFirstFunction <--------------------------------------
 | | - run.ps1
 | | - function.json
 | - MySecondFunction
 | | - run.ps1
 | | - function.json
 | - Modules  <---------------------------------
 | | - myFirstHelperModule  <--------------------------------- Same name as its children
 | | | - myFirstHelperModule.psd1
 | | | - myFirstHelperModule.psm1
 | | - mySecondHelperModule
 | | | - mySecondHelperModule.psd1
 | | | - mySecondHelperModule.psm1
 | - local.settings.json
 | - host.json
 | - requirements.psd1
 | - profile.ps1
 | - extensions.csproj
 | - bin
```
1. Create a folder myFirstHelperModule
2. Create a file myFirstHelperModule.psm1 in that folder
```
function Test-IPRange {
    return $isValid
}
    
Export-ModuleMember -function Test-IPRange    
```

3. New-ModuleManifest -path ./helperFunctions.psd1 -moduleversion "1.0" -Author "my name"
 - Note: you created a psm1 file but here you write psd1!

4. Make sure to update this line
```
FunctionsToExport = @("Test-IPRange")
```
