if (Test-Path -Path .\windows10.iso -PathType Leaf){
    Write-Output "[$(Get-Date)] ISO present. Skipping!"
}
else {
    Write-Output "[$(Get-Date)] ISO wasn't found. Downloading..."
    & .\Fido.ps1 -Win 10 -Ed Pro -Lang English International
    Write-Output "[$(Get-Date)] ISO downloaded."
    Rename-Item -Path ".\Win*.iso" -NewName "windows10.iso"
    Write-Output "[$(Get-Date)] Done."
}