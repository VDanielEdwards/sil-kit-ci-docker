ARG DOCKERFILE_FROM_IMAGE="mcr.microsoft.com/windows/servercore:ltsc2022"
FROM ${DOCKERFILE_FROM_IMAGE}

# set VerbosePreference to Continue for debugging
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $VerbosePreference='SilentlyContinue';"]

COPY setup C:/Setup/

RUN C:/Setup/setup-import-certificates.ps1
RUN C:/Setup/setup-build-tools.ps1
RUN C:/Setup/setup-cmake.ps1
RUN C:/Setup/setup-ninja.ps1

RUN Remove-Item -Recurse -Force C:/Setup

COPY scripts C:/CI/Scripts

ENTRYPOINT ["powershell", "-Command", ". 'C:/CI/Scripts/entrypoint-prelude.ps1'; "]
