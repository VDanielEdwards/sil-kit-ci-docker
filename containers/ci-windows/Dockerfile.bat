ARG DOCKERFILE_FROM_IMAGE="mcr.microsoft.com/windows/servercore:ltsc2022"
FROM ${DOCKERFILE_FROM_IMAGE}

SHELL ["cmd", "/S", "/C"]

COPY Vector_Root_2.0.crt "C:\\TEMP\\ca.crt"
RUN ["certutil.exe", "-addstore", "root", "C:\\TEMP\\ca.crt"]

COPY setup-container.bat "C:\\TEMP\\SETUP.BAT"
RUN ["C:\\TEMP\\SETUP.BAT"]

ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
