@REM note: curl is pre-installed in nanoserver container-images

curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe

START /w vs_buildtools.exe ^
    --quiet --wait --norestart --nocache ^
    --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" ^
    --add Microsoft.VisualStudio.Component.VC.v141.x86.x64

IF "%ERRORLEVEL%"=="3010" EXIT 0

DEL /q vs_buildtools.exe

@REM --remove Microsoft.VisualStudio.Component.Windows10SDK.10240
@REM --remove Microsoft.VisualStudio.Component.Windows10SDK.10586
@REM --remove Microsoft.VisualStudio.Component.Windows10SDK.14393
