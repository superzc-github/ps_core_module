#Requires -Version 7.0
#Requires -PSEdition Core

#verify the required cmdlets existing
Function cmdlet_validation(){
    param(
        [Parameter( Position = 0, ValueFromPipeline = $True )][String]$cmdlet_name
    )
    Get-Command "$cmdlet_name" -ErrorAction SilentlyContinue -ErrorVariable cmd_err
    if($cmd_err){
        Write-Error "The required cmdlet '$cmdlet_name' is missing, please try to install it first..."
        break
    }
}

Function Get-Service {
    [CmdletBinding()]
    Param(
      [Parameter( Position = 0, ValueFromPipeline = $True)][String]$Name,
      [Parameter( Position = 1, ValueFromPipeline = $True)][String]$Unit
    )
    #verify the required cmdlets in advance
    cmdlet_validation 'systemctl' | Out-Null
    if (($Name |out-string).trim() -notlike ''){
        if ($Unit) {
            write-error "These parameters are not allowed to exist at same time [-Name] [-Unit]"
            break
        }
        $Unit = $Name + ".service"
    }
    #verify OS type
    if($IsLinux){
        If ($Unit) {
            $services = & sudo systemctl list-units $Unit --type=service --no-legend --all --no-pager
        }else{
            $services = & sudo systemctl list-units --type=service --no-legend --all --no-pager
        }
        $services = $services | ForEach-Object {
            $service = $_ -Split '\s+' |Where-Object {$_ -notlike ''}
            [PSCustomObject]@{
                "Name"        = ($service[0]).replace(".service",'')
                "Unit"        = $service[0]
                "Load"       = $service[1]
                "State"      = $service[2]
                "SUB"      = $service[3]
                "Description" = ($service[4..$service.count] -Join " ")
            }
        }
    }else{
        Write-Error "The function only applicable for Linux systems"
        Break
    }
    return $services
}

Export-ModuleMember -Function Get-Service
