# Funkcija za brisanje profila
function BrisiProfil {
    param(
        [string]$sid
    )
	
	try {
		(Get-WmiObject -Class Win32_UserProfile | Where-Object {$_.SID -eq $sid}).Delete()
		$akcija = "IZBRISAN"
	}
	catch {
	    $akcija = "NAPAKA"
	}

    # Vrnitev niza
    return $akcija
}

# Prebere akcije
$odgovor = Read-Host "Izbrisem profile neznanih uporabnikov (d/n)?"
if($odgovor -eq "d") {
	$izbrisiNeznane = $true
}
else {
	$izbrisiNeznane = $false	
}

$odgovor = Read-Host "Izbrisem zastarele profile ucencev (d/n)?"
if($odgovor -eq "d") {
	$izbrisiZastareleUcence = $true
}
else {
	$izbrisiZastareleUcence = $false	
}
$odgovor = Read-Host "Izbrisem zastarele profile uciteljev (d/n)?"
if($odgovor -eq "d") {
	$izbrisiZastareleUcitelje = $true
}
else {
	$izbrisiZastareleUcitelje = $false	
}

# Pridobi seznam vseh uporabniških profilov na sistemu
$uporabniskiProfili = Get-WmiObject -Class Win32_UserProfile

# Izpiše naslovno vrstico
$vrsticaTabele = "|{0,-20}|{1,-15}|{2,-25}|{3,-15}|{4,-25}|{5,-12}|"
$crtaTabele = '+' + ('-'*20) + '+' + ('-'*15) + '+' + ('-'*25) + '+' + ('-'*15) + '+' + ('-'*25) + '+' + ('-'*12) + '+'
$barvaTabele = "Green";
Write-Host $crtaTabele -ForegroundColor $barvaTabele
Write-Host ($vrsticaTabele -f "uporabniskoIme", "vrstaProfila", "potDoMape", "velikostMape", "datumZadnjeSpremembe", "akcija") -ForegroundColor $barvaTabele
Write-Host $crtaTabele -ForegroundColor $barvaTabele

# Zanka čez vsak profil
foreach ($profil in $uporabniskiProfili) {
	
    # Preskoči sistemske profile
    if ($profil.Special -or $profil.LocalPath -eq $null) {
        continue
    }

	# Pridobi pot do mape z datotekami
	$potDoMape = $profil.LocalPath
	
	# Pridobi datum zadnje spremembe mape z datotekami
	$datumZadnjeSpremembe = (Get-ChildItem -Path $potDoMape -Recurse | Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime
	
	# Pridobi današnji datum
	$trenutniDatum = Get-Date
	
	# Če je profil bil spremenjen pred več kot letom dni
	if ($datumZadnjeSpremembe -lt $trenutniDatum.AddYears(-1)) {
		$barvaTabele = "Yellow";
	} else {
		$barvaTabele = "Green";
	}

    # Pridobi SID uporabnika
    $sid = $profil.SID
	
    # Poskusi pridobiti uporabniško ime iz SID
    try {
        $uporabniskoIme = (New-Object System.Security.Principal.SecurityIdentifier($sid)).Translate([System.Security.Principal.NTAccount]).Value
    } catch {
        $uporabniskoIme = "neznan uporabnik"
		$barvaTabele = "Red";
    }

	# Pridobi vrsto profila, lokalni ali roaming
	$vrstaProfila = if ($profil.RoamingConfigured) { "roaming" } else { "lokalni" }
	
	# Pridobi velikost mape
	#Read more: https://www.sharepointdiary.com/2021/07/get-folder-size-in-powershell.html#ixzz8UYMWowSZ    
	$velikostMape = (Get-ChildItem -Path $potDoMape -Force -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property "Length" -Sum).Sum / 1MB
	$velikostMape = [Math]::Round($velikostMape, 2)

	# Opravi akcijo
	if($barvaTabele -eq "Green") {
		$akcija = "OK"
	}
	elseif($barvaTabele -eq "Yellow") {
		if($vrstaProfila -eq "roaming") {
			if($izbrisiZastareleUcitelje) {
				$akcija = BrisiProfil -sid $sid
			}
			else {
				$akcija = "Pr.zas.uci."
			}
		}
		else {
			if($izbrisiZastareleUcence) {
				$akcija = BrisiProfil -sid $sid
			}
			else {
				$akcija = "Pr.zas.uce."
			}
		}
	}
	elseif($barvaTabele -eq "Red") {
		if($izbrisiNeznane) {
			$akcija = BrisiProfil -sid $sid
		}
		else {
			$akcija = "Presk.nezn."			
		}
	}
	else {
		$akcija = "Nedef."
	}

	# Izpiše vrstico
	Write-Host ($vrsticaTabele -f $uporabniskoIme, $vrstaProfila, $potDoMape, $velikostMape, $datumZadnjeSpremembe, $akcija) -ForegroundColor $barvaTabele

}

$barvaTabele = "Green";
Write-Host $crtaTabele -ForegroundColor $barvaTabele

pause