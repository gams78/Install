@Echo off
@Echo Skripta za avtomatsko namestitev in posodobitev delovnih postaj
@Echo Copyright (c) by Boris Volaric, TRI-ING d.o.o.

@Echo Running PowerShell update script ...
Powershell.exe -executionpolicy remotesigned -File C:\Install\update.ps1
@Echo PowerShell script finished.
pause

@Echo Running PowerShell install script ...
Powershell.exe -executionpolicy remotesigned -File C:\Install\run.ps1
@Echo PowerShell script finished.
pause