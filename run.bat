@Echo off
@Echo Skripta za avtomatsko namestitev in posodobitev delovnih postaj
@Echo Copyright (c) by Boris Volaric, TRI-ING d.o.o.
@Echo Verzija 1.0 (5. 3. 2024)

rem @Echo Updating scripts ...
rem md c:\Install
rem copy \\helium.osbp.si\Admin\Install\*.* c:\Install
rem copy c:\Install\Install.lnk C:\Users\admin\Desktop
rem pause

@Echo Running PowerShell script ...
Powershell.exe -executionpolicy remotesigned -File C:\Install\run.ps1
@Echo PowerShell script finished.
pause