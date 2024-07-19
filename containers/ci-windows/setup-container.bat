CD C:\TEMP
IF %ERRORLEVEL% NEQ 0 EXIT %ERRORLEVEL%

@REM download the build-tools setup
@REM note: curl is pre-installed servercore container-images

curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe
IF %ERRORLEVEL% NEQ 0 EXIT %ERRORLEVEL%


@REM install build-tools components

@REM START /w vs_buildtools.exe ^
@REM     --quiet --wait --norestart --nocache ^
@REM     --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" ^
@REM     --add Microsoft.VisualStudio.Component.VC.v141.x86.x64

@REM IF %ERRORLEVEL% NEQ 0 IF %ERRORLEVEL% NEQ 3010 EXIT %ERRORLEVEL%


@REM cleanup if everything went well

DEL /q vs_buildtools.exe
