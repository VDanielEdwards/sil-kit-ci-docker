ARG DOCKERFILE_FROM_IMAGE="mcr.microsoft.com/windows/servercore:ltsc2022"
FROM ${DOCKERFILE_FROM_IMAGE}

ARG ARCH
ARG VC_VERSION
ARG VISUAL_STUDIO_VERSION

# set VerbosePreference to Continue for debugging
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $VerbosePreference='SilentlyContinue';"]

COPY setup C:/Setup/

RUN C:/Setup/setup-import-certificates.ps1
RUN C:/Setup/setup-build-tools.ps1
RUN C:/Setup/setup-cmake.ps1

RUN Remove-Item -Recurse -Force C:/Setup

ENTRYPOINT ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $VerbosePreference='SilentlyContinue';"]
