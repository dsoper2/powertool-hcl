# powertool-hcl
Example scripts to query systems and validate configurations with the HW Compatibility List (HCL) API.  Leveraged from PowerTool scripts originally created by https://github.com/FooBartn

#### Table of Contents

1. [Setup - The basics of getting started with PowerTool and the HCL](#setup)
1. [Usage - Configuration options and additional functionality](#usage)

## Setup

You will need to have Cisco UCS PowerTool installed and have a cisco.com login (CCO ID) that allows access to the HCL tool: http://ucshcltool.cloudapps.cisco.com/public/

## Usage

There are scripts for checking blade servers (Get-UcsSupportedDrivers.ps1) and rack servers (Get-UcsmRackSupportedDrivers.ps1).  The basic flow for using the script is given in the following example:

\#1.  Source the script

. .\Get-UcsSupportedDrivers.ps1

\#2.  Create your cisco.com CCO ID credential

$cred = Get-Credential

\#3.  Connect to a UCS domain

connect-ucs

\#4.  Create a name for the HW profile that will be created by the script

$Name = ‘c3s1-test’

\#5.  Run the script passing in the name from step 4, CCO cred from step 2, and other parameters for fw/os version and server physical location

Get-UcsSupportedDrivers -Name $Name -CCOCred $cred  -FwVersion '3.1(2c)' -OsVendorCode 4 -OsVersionCode 148 -Chassis 3 -SlotId 1

<FwVersion> is the UCSM bundle version to check for compatibility.  The script replaces the version queried from the system with this value.

Values for <OSVendorCode> can be retrieved with the Get-UcsOsVendor cmdlet, and <OSVersionCode> can be retrieved with the Get-UcsOperatingSystem cmdlet.

