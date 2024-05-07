# Install

Skripte za namestitev, posodobitev in vzdrževanje Windows delovnih postaj.

## Uporaba

- Vse skripte naj bodo vedno nameščene na **C:\Install**
- Batch skripte se vedno zaganja z lokalnim uporabnikom **admin** z administratorskimi pravicami
- PowerShell skripte se vedno zaganja preko Batch skript

## Zagon

- **run.bat** (namestitev in konfiguracija celotnega sistema ter clean-up na koncu)
- **profiles.bat** (pregled in brisanje uporabniških profilov - na začetku pozorno sledimo navodilom za nastavitev parametrov brisanja)

## Vsebina

- **run.ps1** (namestitev in konfiguracija celotnega sistema ter clean-up na koncu)
- **profiles.ps1** (pregled in brisanje uporabniških profilov - na začetku pozorno sledimo navodilom za nastavitev parametrov brisanja)
- **update.ps1** (posodobi vse skripte iz GutHub-a in prenese namestitvene datoteke iz strežnika)
- **InstallOffice.ps1** (odstrani Office 365 in namesti Office LTSC)

## Avtor

Boris Volarič
TRI-ING d.o.o.