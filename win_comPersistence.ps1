#COM Persistence Check
#WIP - If the SHA256 value is missing, the binary could not be found.
$ErrorActionPreference = 'SilentlyContinue'
$r = Get-ItemProperty -Path 'HKLM:\Software\Classes\CLSID\*\InprocServer32'
$u = Get-ItemProperty -Path 'Registry::HKEY_USERS\*_Classes\CLSID\*\InprocServer32'
Write-Output '> HKLM Entries'
ForEach ($entry in $r) {
    $rval = $entry.'(default)'
    $rhash = (Get-FileHash -Path $rval).Hash
    $rval = $entry.'(default)' | Out-String
    $rpath = $entry.PSPath -split 'Microsoft.PowerShell.Core\\Registry::' | Out-String
    "[HKLM COM Binary] {0}SHA256: {1}{2}" -f ($rval, $rhash, $rpath)
    }

Write-Output '> HKU Entries'
ForEach ($entry in $u) {
    $uval = $entry.'(default)'
    $uhash = (Get-FileHash -Path $uval).Hash
    $uval = $entry.'(default)' | Out-String
    $upath = $entry.PSPath -split 'Microsoft.PowerShell.Core\\Registry::' | Out-String
    "[HKU COM Binary] {0}SHA256: {1}{2}" -f ($uval, $uhash, $upath)
    }
