@{
    GUID = "{0a3a9322-c178-4aef-96a5-03b5ab30cbd5}"
    Author = "Zhao Chen"
    HelpInfoUri = "https://github.com/superzc-github/ps_core_module"
    ModuleVersion = "1.0.0.0"
    PowerShellVersion = "7.0"

    NestedModules = @(
        "Get-Service",
        "Start-Service",
        "Stop-Service"
        )

    FormatsToProcess = @()
    TypesToProcess = @()

    FunctionsToExport = @(
        "Get-Service",
        "Start-Service",
        "Stop-Service"
        )

    AliasesToExport = @()

    CmdletsToExport = @()
}
