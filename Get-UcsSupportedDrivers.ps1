function Get-UcsSupportedDrivers () {
    param(
        [string]
        $Name,

        [int]
        $Chassis,

        [int]
        $SlotId,

        [string]
        $FwVersion,

        [int]
        $OsVendorCode,

        [int]
        $OsVersionCode,

        $CCOCred
    )

    $BladeParams = @{
        Chassis = $Chassis
        SlotId = $SlotId
    }

    $HardwareParams = @{
        Name = $Name
        OsVendorCode = $OsVendorCode
        OsVersionCode = $OsVersionCode
    } 

    $LocalHwProfile = Get-UcsBlade @BladeParams | 
    New-UcsHardwareProfile @HardwareParams
    $LocalHwProfile.UcsServer.Management.Version = $FwVersion
    $LocalHwProfile | ConvertTo-Json -depth 100 | Out-File "$Name.json"
    $HclProfile = $LocalHwProfile | Add-UcsHardwareProfile -Credential $CCOCred

    Invoke-UcsHclUtility -HardwareProfile $HclProfile -Credential $CCOCred -Tree

}
