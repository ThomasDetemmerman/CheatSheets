# Status  
[![Build Status](https://dev.azure.com/ThomasDetemmerman/PrivateCloud/_apis/build/status/ThomasDetemmerman.CheatSheets?branchName=master)](https://dev.azure.com/ThomasDetemmerman/PrivateCloud/_build/latest?definitionId=23&branchName=master)

## Pipeline 2
[Image of pipeline](./img/pipeline.png)

- each stage is executed sequencially
- each job is parallel by default, unless you define a `dependsOn` *
- note that the powershell command is executed on an Ubuntu OS using powershell core.

* _The course says that jobs are executed sequencially unless you define dependsOn: none. From my test, that statements seems incorrect._
