
function Invoke-VCVarsAll {
    $VCVarsAll = "C:\CI\BuildTools\VC\Auxiliary\Build\vcvarsall.bat"
    $GetEnvironmentAsJson = "powershell -Command Get-ChildItem env: ^| Select-Object name,value ^| ConvertTo-Json"

    $EnvironmentJson = & cmd.exe /C "${VCVarsAll} ${env:MSVC_ARCH} -vcvars_ver=${MSVC_TOOLSET} >NUL 2>&1 && $GetEnvironmentAsJson"

    foreach ($Var in ($EnvironmentJson | ConvertFrom-Json)) {
        Set-Item "env:$($Var.Name)" "$($Var.Value)"
    }
}
