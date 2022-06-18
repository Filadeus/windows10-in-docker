if (Test-Path -Path .\windows10.iso -PathType Leaf){
    Write-Output "ISO present. Skipping!"
}
else {
    Invoke-Item (start powershell(.\Fido.ps1 -Win 10 -Ed Pro -Lang English International))
    bash find . -type f -name "Win10*.iso" -exec \'sh -c x="{}"; mv "$x" "windows10.iso" \' \\;
}