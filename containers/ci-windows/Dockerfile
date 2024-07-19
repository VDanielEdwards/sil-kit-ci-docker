# escape=`

ARG DOCKERFILE_FROM_IMAGE="mcr.microsoft.com/windows/servercore:ltsc2022"
FROM ${DOCKERFILE_FROM_IMAGE} AS ci-windows-base

SHELL ["cmd", "/S", "/C"]

# Download the Build Tools bootstrapper
RUN curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe

# Install Build Tools with the Microsoft.VisualStudio.Workload.AzureBuildTools workload, excluding workloads and components with known issues.
RUN start /w vs_buildtools.exe --quiet --wait --norestart --nocache `
        --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" `
        --add Microsoft.VisualStudio.Component.VC.v141.x86.x64 `
        || IF "%ERRORLEVEL%"=="3010" EXIT 0

        #--add Microsoft.VisualStudio.Workload.AzureBuildTools `
        #--remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `
        #--remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `
        #--remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `
        #--remove Microsoft.VisualStudio.Component.Windows81SDK `

# Cleanup
RUN del /q vs_buildtools.exe


FROM scratch
COPY --from=ci-windows-base / /

SHELL ["cmd", "/S", "/C"]

ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
