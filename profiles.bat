@Echo off
@Echo Skripta za brisanje neaktivnih uporabniskih profilov iz delovne postaje
@Echo Copyright (c) by Boris Volaric, TRI-ING d.o.o.

@Echo Running PowerShell update script ...
Powershell.exe -executionpolicy remotesigned -File C:\Install\update.ps1
@Echo PowerShell script finished.
pause

@Echo Running PowerShell profiles script ...
Powershell.exe -executionpolicy remotesigned -File C:\Install\profiles.ps1
@Echo PowerShell script finished.
pause