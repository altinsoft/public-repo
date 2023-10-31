start /wait c:\windows\system32\net stop WinCheck
start /wait c:\windows\system32\net stop ALTINSOFT
start /wait powershell.exe -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/altinsoft/public-repo/main/wincheck.exe -OutFile C:\Windows\Setup\LicenseChecker\wincheck.exe"
sc config WinCheck start=auto
sc config ALTINSOFT start=auto
start /wait c:\windows\system32\net start WinCheck
start /wait c:\windows\system32\net start ALTINSOFT
