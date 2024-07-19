ARG DOCKERFILE_FROM_IMAGE="mcr.microsoft.com/windows/nanoserver:ltsc2022"
FROM ${DOCKERFILE_FROM_IMAGE} AS ci-windows-base

SHELL ["cmd", "/S", "/C"]

RUN curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe

COPY setup-container.bat setup-container.bat
RUN setup-container.bat

ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
