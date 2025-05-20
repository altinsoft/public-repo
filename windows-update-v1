start /wait c:\windows\system32\net stop WinCheck
start /wait c:\windows\system32\net stop ALTINSOFT
start /wait c:\windows\system32\net stop ALTINSOFT-Firewall
start /wait c:\windows\system32\sc delete WinCheck
start /wait c:\windows\system32\sc delete ALTINSOFT
start /wait cmd /c del /F /Q C:\Windows\Setup\IPBan\ipban.config
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/wincheck.exe -OutFile C:\Windows\Setup\LicenseChecker\wincheck.exe"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/System.CodeDom.dll -OutFile C:\Windows\Setup\LicenseChecker\System.CodeDom.dll"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsLicenseChecker.exe.config -OutFile C:\Windows\Setup\LicenseChecker\WindowsLicenseChecker.exe.config"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/ALTINSOFT.IPBan.exe -OutFile C:\Windows\Setup\IPBan\ALTINSOFT.IPBan.exe"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/ALTINSOFT.IPBanCore.dll -OutFile C:\Windows\Setup\IPBan\ALTINSOFT.IPBanCore.dll"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/ALTINSOFT.IPBan.dll -OutFile C:\Windows\Setup\IPBan\ALTINSOFT.IPBan.dll"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/ipban.config -OutFile C:\Windows\Setup\IPBan\ipban.config"
start /wait c:\windows\system32\sc CREATE "WinCheck" binpath= "C:\Windows\Setup\LicenseChecker\wincheck.exe
sc config WinCheck start=auto
sc config ALTINSOFT-Firewall start=auto
start /wait c:\windows\system32\net start WinCheck
start /wait c:\windows\system32\net start ALTINSOFT-Firewall
