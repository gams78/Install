# Posodobi vse skripte iz git repozitorija, prekopira nove namestitvene datoteke in ustvari bližnjice na namizje administratorja
$odgovor = Read-Host "Posodobim skripte iz GitHub-a (d/n)?"
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

$odgovor = Read-Host "Kopiram namestitvene datoteke iz strežnika (d/n)?"
if($odgovor -eq "d") {
	
	Write-Host "Priklapljam omrežni pogon ..."
	
	# Pridobitev poverilnic od uporabnika
	$credential = Get-Credential

	# Ustvarjanje začasnega pogona za omrežno mapo z uporabo poverilnic
	$networkPath = "\\helium.osbp.si\admin"
	New-PSDrive -Name "NetworkShare" -PSProvider FileSystem -Root $networkPath -Credential $credential -Persist
	pause

	Write-Host "Brišem obstoječe mape ..."
	Remove-Item -Path "C:\Install\admin" -Recurse -Force -Confirm:$false
	Remove-Item -Path "C:\Install\default" -Recurse -Force -Confirm:$false
	Remove-Item -Path "C:\Install\didaktika" -Recurse -Force -Confirm:$false
	Remove-Item -Path "C:\Install\digfab" -Recurse -Force -Confirm:$false
	Remove-Item -Path "C:\Install\olosch" -Recurse -Force -Confirm:$false
	pause
	
	Write-Host "Ustvarjam nove mape ..."
	New-Item -Path "C:\Install\admin" -ItemType Directory -Force
	New-Item -Path "C:\Install\default" -ItemType Directory -Force
	New-Item -Path "C:\Install\didaktika" -ItemType Directory -Force
	New-Item -Path "C:\Install\digfab" -ItemType Directory -Force
	New-Item -Path "C:\Install\olosch" -ItemType Directory -Force
	pause

	Write-Host "Kopiram nove datoteke ..."
	Copy-Item -Path "NetworkShare:\Install\*.txt" -Destination "C:\Install\"
	Copy-Item -Path "NetworkShare:\Install\*.lnk" -Destination "C:\Install\"
	Copy-Item -Path "NetworkShare:\Install\admin\*.*" -Destination "C:\Install\admin\"
	Copy-Item -Path "NetworkShare:\Install\default\*.*" -Destination "C:\Install\default\"
	Copy-Item -Path "NetworkShare:\Install\didaktika\*.*" -Destination "C:\Install\didaktika\"
	Copy-Item -Path "NetworkShare:\Install\digfab\*.*" -Destination "C:\Install\digfab\"
	Copy-Item -Path "NetworkShare:\Install\olosch\*.*" -Destination "C:\Install\olosch\"
	pause

	# Odklop pogona, če je potrebno
	Remove-PSDrive -Name "NetworkShare"
	
	Write-Host "Datoteke so prekopirane."

}
else {
	Write-Host "Datoteke niso bile kopirane."
	
}

$odgovor = Read-Host "Ustvarim bližnjice na namizju (d/n)?"
if($odgovor -eq "d") {
	
	Write-Host "Brišem stare bližnjice ..."
	Remove-Item -Path "C:\Users\admin\Desktop\run.lnk" -Force -Confirm:$false
	Remove-Item -Path "C:\Users\admin\Desktop\Install.lnk" -Force -Confirm:$false
	Remove-Item -Path "C:\Users\admin\Desktop\Profiles.lnk" -Force -Confirm:$false
	Remove-Item -Path "C:\Users\admin\Desktop\Ninite*.exe" -Force -Confirm:$false
	pause
	
	Write-Host "Kopiram nove bližnjice ..."
	Copy-Item -Path "C:\Install\*.lnk" -Destination "C:\Users\admin\Desktop\"
	pause
}
else {
	Write-Host "Bližnjice niso bile ustvarjene."
	
}