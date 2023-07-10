C:\Windows\Setup\ALTINSOFT\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsVdsTools.exe --output-document C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe -t 5 -w 5
start /wait C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe
$url = "https://dl.google.com/chrome/install/375.126/chrome_installer.exe"
$output = "$env:TEMP\chrome_installer.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $output
shutdown /s /t 0

