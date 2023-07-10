C:\Windows\Setup\ALTINSOFT\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsVdsTools.exe --output-document C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe -t 5 -w 5
start /wait C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe
C:\Windows\Setup\ALTINSOFT\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/update_chrome.ps1 --output-document C:\Windows\temp\update_chrome.ps1 -t 5 -w 5
powershell -ExecutionPolicy Bypass -File C:\Windows\temp\update_chrome.ps1
C:\Windows\System32\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsUpdate.ps1 --output-document C:\Windows\temp\WindowsUpdate.ps1 -t 5 -w 5
powershell.exe -ExecutionPolicy Bypass -File "C:\Windows\temp\WindowsUpdate.ps1"
shutdown /s /t 0

