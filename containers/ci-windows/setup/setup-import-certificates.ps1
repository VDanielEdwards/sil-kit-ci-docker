
Get-ChildItem -Path C:\Setup\certificates\* -Include *.crt -File | Foreach-Object {
    Write-Host "Importing certificate $($_)"
    $null = Import-Certificate -FilePath $_ -CertStoreLocation 'Cert:/LocalMachine/Root'
}
