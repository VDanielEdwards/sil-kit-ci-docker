ARG DOCKERFILE_FROM_IMAGE="mcr.microsoft.com/windows/servercore:ltsc2022"
FROM ${DOCKERFILE_FROM_IMAGE}

ARG MSVC_ARCH
ARG MSVC_VERSION
ARG VISUAL_STUDIO_VERSION

# set VerbosePreference to Continue for debugging
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $VerbosePreference='SilentlyContinue';"]

COPY setup C:/Setup/
COPY ci/scripts C:/CI/Scripts/

RUN C:/Setup/setup-import-certificates.ps1
RUN C:/Setup/setup-environment-variables.ps1
RUN C:/Setup/setup-build-tools.ps1
RUN C:/Setup/setup-cmake.ps1

RUN Remove-Item -Recurse -Force C:/Setup

ENTRYPOINT ["powershell", "-NoExit", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $VerbosePreference='SilentlyContinue'; . 'C:/Setup/private/invoke-vcvarsall.ps1' ; Invoke-VCVarsAll ;"]
