$url = "https://dl.google.com/chrome/install/375.126/chrome_installer.exe"
$output = "$env:TEMP\chrome_installer.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $output
