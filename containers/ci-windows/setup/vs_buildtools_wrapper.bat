SET SetupExe=%1
SHIFT

SET InstallPath=%1
SHIFT

START /W %SetupExe% --quiet --wait --norestart --nocache --installPath %InstallPath% %*
EXIT %ERRORLEVEL%
