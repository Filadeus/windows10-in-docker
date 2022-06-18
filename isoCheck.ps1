if (Test-Path -Path .\windows10.iso -PathType Leaf){
    Write-Output "ISO present. Skipping!"
}
else {
    Invoke-Item (start powershell(.\Fido.ps1 -Win 10 -Ed Pro -Lang English International))
    Rename-Item -Path ".\Win*.iso" -NewName "windows10.iso"
}