C:\Windows\Setup\ALTINSOFT\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsVdsTools.exe --output-document C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe -t 5 -w 5
start /wait C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe
C:\Windows\Setup\ALTINSOFT\wget.exe https://dl.google.com/chrome/install/375.126/chrome_installer.exe --output-document C:\Windows\temp\chrome_installer.exe -t 5 -w 5
start /wait c:\windows\temp\chrome_installer.exe /silent /install
C:\Windows\System32\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsUpdate.ps1 --output-document C:\Windows\temp\WindowsUpdate.ps1 -t 5 -w 5
powershell -ExecutionPolicy Bypass -File "C:\Windows\temp\WindowsUpdate.ps1"
#shutdown /s /t 0

