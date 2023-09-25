C:\Windows\Setup\ALTINSOFT\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsVdsTools.exe --output-document C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe -t 5 -w 5
start /wait c:\windows\system32\net stop WinCheck
C:\Windows\Setup\ALTINSOFT\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/wincheck.exe --output-document C:\Windows\Setup\LicenseChecker\wincheck.exe -t 5 -w 5
start /wait C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe
shutdown /s /t 0

