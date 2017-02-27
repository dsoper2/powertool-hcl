function Get-UcsmRackSupportedDrivers () {
    param(
        [string]
        $Name,

        [int]
        $Id,

        [string]
        $FwVersion,

        [int]
        $OsVendorCode,

        [int]
        $OsVersionCode,

        $CCOCred
    )

    $HardwareParams = @{
        Name = $Name
        OsVendorCode = $OsVendorCode
        OsVersionCode = $OsVersionCode
    } 

    $LocalHwProfile = Get-UcsRackUnit -Id $Id | 
    New-UcsHardwareProfile @HardwareParams
    $LocalHwProfile.UcsServer.Management.Version = $FwVersion
    $LocalHwProfile | ConvertTo-Json -depth 100 | Out-File "$Name.json"
    $HclProfile = $LocalHwProfile | Add-UcsHardwareProfile -Credential $CCOCred

    Invoke-UcsHclUtility -HardwareProfile $HclProfile -Credential $CCOCred -Tree

}
