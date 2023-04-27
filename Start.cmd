reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\winlogon" /v AutoAdminLogon /f
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\winlogon" /v DefaultUserName /f
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\winlogon" /v DefaultPassword /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v ALTINSOFT /f
del /q /s /f C:\Users\Administrator\AppData\Local\Google\Chrome
rd /s /q C:\Users\Administrator\AppData\Local\Google\Chrome
C:\Windows\Setup\ALTINSOFT\WindowsVdsTools.exe
del /F /Q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*
del /F /Q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*
del /F /Q %APPDATA%\Microsoft\Windows\Recent\*
wevtutil cl Application
wevtutil cl Security
wevtutil cl Setup
wevtutil cl System
