@Echo off
@Echo Skripta za brisanje neaktivnih uporabniskih profilov iz delovne postaje
@Echo Copyright (c) by Boris Volaric, TRI-ING d.o.o.
@Echo Verzija 1.0 (30. 4. 2024)

@Echo Running PowerShell script ...
Powershell.exe -executionpolicy remotesigned -File C:\Install\profiles.ps1
rem PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""profiles.ps1""' -Verb RunAs}"
@Echo PowerShell script finished.
pause