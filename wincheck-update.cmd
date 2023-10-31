start /wait c:\windows\system32\net stop WinCheck
C:\Windows\system32\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/wincheck.exe --output-document C:\Windows\Setup\LicenseChecker\wincheck.exe -t 5 -w 5
sc config WinCheck start=auto
start /wait c:\windows\system32\net start WinCheck
