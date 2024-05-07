@Echo off
@Echo Skripta za nalaganje kode na github
@Echo Copyright (c) by Boris Volaric, TRI-ING d.o.o.

git status
pause

set /p message="Opis:"
git commit -a -m "%message%"
pause

git push -u origin master
@Echo Skripta koncana.
pause