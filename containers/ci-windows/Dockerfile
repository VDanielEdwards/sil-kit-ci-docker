ARG DOCKERFILE_FROM_IMAGE="mcr.microsoft.com/windows/servercore:ltsc2022"
FROM ${DOCKERFILE_FROM_IMAGE}

# set VerbosePreference to Continue for debugging
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue'; $VerbosePreference='SilentlyContinue';"]

COPY setup/private C:/Setup/private/

COPY setup/setup-cmake.ps1 C:/Setup/
RUN C:/Setup/setup-cmake.ps1

COPY setup/setup-build-tools.ps1 setup/vs_buildtools_wrapper.bat C:/Setup/
RUN C:/Setup/setup-build-tools.ps1

RUN Remove-Item -Recurse -Force C:/Setup

ENTRYPOINT ["powershell"]
