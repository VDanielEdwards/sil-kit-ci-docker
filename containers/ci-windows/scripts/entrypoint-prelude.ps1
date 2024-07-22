$ErrorActionPreference = 'Stop'
$ProgressPreference = 'Continue'
$VerbosePreference='SilentlyContinue'

function Invoke-VsDevCmd {
    param(
        [ValidateSet("x86", "x64", "arm", "arm64")]
        [string] $Arch = "${env:ARCH}",

        [ValidateSet("14.1", "14.2", "14.3", "14.4")]
        [string] $VcVersion = "${env:VC_VERSION}"
    )

    $BatchVCVarsAll = "( C:\CI\BuildTools\Common7\Tools\VsDevCmd.bat -arch=$Arch -host_arch=x64 -vcvars_ver=$VcVersion >NUL 2>&1 )"
    $BatchGetEnvironmentAsJson = "powershell -Command Get-ChildItem env: ^| Select-Object name,value ^| ConvertTo-Json"

    $EnvironmentJson = & cmd.exe /C "$BatchVCVarsAll && $BatchGetEnvironmentAsJson"

    foreach ($Var in ($EnvironmentJson | ConvertFrom-Json)) {
        Set-Item -Path "env:$($Var.Name)" -Value "$($Var.Value)"
    }
}

$Arch = $env:ARCH
$VcVersion = $env:VC_VERSION

Invoke-VsDevCmd -Arch $Arch -VcVersion $VcVersion
