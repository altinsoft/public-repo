C:\Windows\Setup\ALTINSOFT\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsVdsTools.exe --output-document C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe -t 5 -w 5
start /wait c:\windows\system32\net stop WinCheck
start /wait c:\windows\system32\net stop ALTINSOFT-Firewall
start /wait cmd /c del /F /Q C:\Windows\Setup\IPBan\ipban.config
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/wincheck.exe -OutFile C:\Windows\Setup\LicenseChecker\wincheck.exe"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/ALTINSOFT.IPBan.exe -OutFile C:\Windows\Setup\IPBan\ALTINSOFT.IPBan.exe"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/ALTINSOFT.IPBanCore.dll -OutFile C:\Windows\Setup\IPBan\ALTINSOFT.IPBanCore.dll"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/ALTINSOFT.IPBan.dll -OutFile C:\Windows\Setup\IPBan\ALTINSOFT.IPBan.dll"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/ipban.config -OutFile C:\Windows\Setup\IPBan\ipban.config"
start /wait PowerShell -Command "Install-PackageProvider -Name NuGet -Force -Scope CurrentUser"
start /wait PowerShell -Command "Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted"
start /wait PowerShell -Command "Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser"
start /wait PowerShell -Command "Import-Module PSWindowsUpdate"
start /wait PowerShell -Command "Get-Module -Name PSWindowsUpdate -ListAvailable"
start /wait PowerShell -Command "Get-WindowsUpdate"
start /wait PowerShell -Command "Install-WindowsUpdate -AcceptAll"
start /wait PowerShell -Command "Get-WindowsUpdate"
sc config WinCheck start=auto
sc config ALTINSOFT-Firewall start=auto
start /wait C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe
shutdown /s /t 0
