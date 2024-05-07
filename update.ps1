# Posodobi vse skripte iz git repozitorija
$odgovor = Read-Host "Posodobim skripte (d/n)?"
if($odgovor -eq "d") {
	Try {
		Write-Host "Posodabljam skripte ..."
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/gams78/Install/master/run.bat" -OutFile "c:\Install\run.bat"
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/gams78/Install/master/profiles.bat" -OutFile "c:\Install\profiles.bat"
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/gams78/Install/master/run.ps1" -OutFile "c:\Install\run.ps1"
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/gams78/Install/master/profiles.ps1" -OutFile "c:\Install\profiles.ps1"
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/gams78/Install/master/update.ps1" -OutFile "c:\Install\update.ps1"
		Write-Host "Skripte so bile posodobljene."
	}
	Catch {
		Write-Host "Napaka pri posodabljanju skript" -ForegroundColor Red
	}
}
else {
	Write-Host "Skripte niso bile posodobljene."
	
}