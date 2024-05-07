@Echo off
@Echo Skripta za avtomatsko namestitev in posodobitev delovnih postaj
@Echo Copyright (c) by Boris Volaric, TRI-ING d.o.o.

rem @Echo Updating scripts ...
rem md c:\Install
rem copy \\helium.osbp.si\Admin\Install\*.* c:\Install
rem copy c:\Install\Install.lnk C:\Users\admin\Desktop
rem pause

@Echo Running PowerShell update script ...
Powershell.exe -executionpolicy remotesigned -File C:\Install\update.ps1
@Echo PowerShell script finished.
pause

@Echo Running PowerShell install script ...
Powershell.exe -executionpolicy remotesigned -File C:\Install\run.ps1
@Echo PowerShell script finished.
pause