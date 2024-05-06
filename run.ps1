######################### Environmental variables #############################
$confirm = Read-Host "Set environmental variables (y/n)?"
if ($confirm -eq 'y') {
	echo "Creating temp folder ..."
	New-Item -Path "c:\Temp" -ItemType Directory -Force
	echo "Setting environmental variables ..."
	[Environment]::SetEnvironmentVariable('TEMP','c:\Temp', 'User')
	[Environment]::SetEnvironmentVariable('TMP','c:\Temp', 'User')
	[Environment]::SetEnvironmentVariable('TEMP','c:\Temp', 'Machine')
	[Environment]::SetEnvironmentVariable('TMP','c:\Temp', 'Machine')
}
else {
	echo "skipping environmental variables setup ..."
}

######################### Windows activation ##################################
$confirm = Read-Host "Activate Windows Eduaction licence (y/n)?"
if ($confirm -eq 'y') {
	echo "Reading activation key from file ..."
	$win10edu = Get-Content -Path "win10edu.txt"
	echo "Setting activation key ..."
	slmgr /ipk $win10edu
	pause
	echo "Activating ..."
	slmgr /ato
}
else {
	echo "skipping Windows activation ..."
}

######################### Windows update ######################################
$confirm = Read-Host "Update Windows (y/n)?"
if ($confirm -eq 'y') {
	echo "Installing windows update module ..."
	Install-Module -Name PSWindowsUpdate -Force
	Get-Package -Name PSWindowsUpdate
	echo "Checking for updates ..."
	Get-WindowsUpdate
	pause
	echo "Updating ..."
	Install-WindowsUpdate
}
else {
	echo "skipping Windows update ..."
}

######################### Ninite ##############################################
$confirm = Read-Host "Run Ninite (y/n)?"
if ($confirm -eq 'y') {
	echo "Running Ninte ..."
	Invoke-Expression -Command "c:\Install\Ninite.exe"
	pause
}
else {
	echo "skipping Ninite ..."
}

############################# Adobe Reader ####################################
$confirm = Read-Host "Install Adobe Reader (y/n)?"
if ($confirm -eq 'y') {
	echo "Copying Adobe Reader installation file ..."
	Copy-Item "c:\Install\Reader_si.exe" -Destination "c:\Install\Reader_si_install.exe"
	echo "Installing Adobe Reader ..."
	Invoke-Expression -Command "c:\Install\Reader_si_install.exe"
	pause
}
else {
	echo "skipping Adobe Reader installation ..."
}

############################# winget ##########################################
$confirm = Read-Host "Install winget (y/n)?"
if ($confirm -eq 'y') {
	<# ### v1.0 ###
	echo "setting winget download url ..."
	$URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
	$URL = (Invoke-WebRequest -Uri $URL -UseBasicParsing).Content | ConvertFrom-Json |
			Select-Object -ExpandProperty "assets" |
			Where-Object "browser_download_url" -Match '.msixbundle' |
			Select-Object -ExpandProperty "browser_download_url"

	echo "downloading winget ..."
	Invoke-WebRequest -Uri $URL -OutFile "Setup.msix" -UseBasicParsing

	echo "installing winget ..."
	Add-AppxPackage -Path "Setup.msix"

	echo "deleting winget installation file ..."
	Remove-Item "Setup.msix"
	pause
	### v 1.0 ### #>
	
	echo "getting winget install script ..."
	Install-Script -Name winget-install
	pause
	echo "running winget install script ..."
	winget-install.ps1
	
}
else {
	echo "skipping winget installation ..."
}

<#
############################### Office 365 Unistall ###########################
$confirm = Read-Host "Uninstall Office 365 (y/n)?"
if ($confirm -eq 'y') {
	
	echo "Uninstalling Office 365 ..."
	Get-Item HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration | Remove-Item -Force -Verbose
	
#	Get-AppxPackage -name "Microsoft.Office.Desktop" | Remove-AppxPackage
	winget uninstall "Programi Microsoft 365 za podjetja - sl-si"
}
else {
	echo "skipping Office 365 uninstallation ..."
}

############################# Office 2019 #####################################
$confirm = Read-Host "Install Office 2019 Pro Plus LTSC (y/n)?"
if ($confirm -eq 'y') {

	echo "Downloading Office 2019 Pro Plus LTSC ..."
	c:\install\olosch\setup.exe /download c:\install\olosch\InstallOffice2019ProPlusLTSC.xml
	pause

	echo "Installing Office 2019 Pro Plus LTSC ..."
	c:\install\olosch\setup.exe /configure c:\install\olosch\InstallOffice2019ProPlusLTSC.xml
	pause
}
else {
	echo "skipping Office 2019 Pro Plus LTSC installation ..."
}

############################# Office 2021 #####################################
$confirm = Read-Host "Install Office 2021 Pro Plus LTSC (y/n)?"
if ($confirm -eq 'y') {

	echo "Downloading Office 2021 Pro Plus LTSC ..."
	c:\odt\setup.exe /download c:\install\olosch\InstallOffice2021ProPlusLTSC.xml
	pause

	echo "Installing Office 2021 Pro Plus LTSC ..."
	c:\odt\setup.exe /configure c:\install\olosch\InstallOffice2021ProPlusLTSC.xml
	pause
}
else {
	echo "skipping Office 2021 Pro Plus LTSC installation ..."
}
#>

############################# Office 365 ######################################
$confirm = Read-Host "Install Office 365 (y/n)?"
if ($confirm -eq 'y') {

	echo "Installing Office 365 ..."
	winget install --id=Microsoft.Office  -e
	pause
}
else {
	echo "skipping Office 365 installation ..."
}

############################# MS Teams ########################################
$confirm = Read-Host "Install MS Teams for School and Work (y/n)?"
if ($confirm -eq 'y') {

	echo "Uninstalling MS Teams Classic ..."
	winget uninstall "Microsoft Teams classic"
	pause
	echo "Installing MS Teams for School and Work ..."
	winget install -e --id Microsoft.Teams
	pause
}
else {
	echo "skipping MS Teams installation ..."
}

############################# Smart Notebook ##################################
$confirm = Read-Host "Install Smart Notebook (y/n)?"
if ($confirm -eq 'y') {
	echo "Installing Smart Notebook ..."
	Invoke-Expression -Command "c:\Install\smart23-2web.exe"
	pause
}
else {
	echo "skipping Smart Notebook installation ..."
}

############################# Active Directory Users and Computers ############
$confirm = Read-Host "Install Active Directory Users and Computers (y/n)?"
if ($confirm -eq 'y') {
	echo "Installing Active Directory Users and Computers ..."
	Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"
	pause
}
else {
	echo "skipping Active Directory Users and Computers installation ..."
}

##################### Upgrade #################################################
$confirm = Read-Host "Upgrade all applications (y/n)?"
if ($confirm -eq 'y') {
	echo "Upgrading all applications ..."
	winget upgrade -h --all
	pause
}
else {
	echo "skipping Upgrade of all applications ..."
}

##################### Cleanup #################################################
$confirm = Read-Host "Cleanup temporary files (y/n)?"
if ($confirm -eq 'y') {
	
	echo "Cleaning up temporary files ..."
	Remove-Item c:\Temp\* -Recurse -Force -ErrorAction SilentlyContinue
	Remove-Item c:\Windows\Temp\* -Recurse -Force -ErrorAction SilentlyContinue
	pause
	
	echo "Cleaning up temporary folders ..."
	$mape = @("c:\_rpcs", 
		"c:\AMD", 
		"c:\HP", 
		"c:\SWSetup", 
		"c:\Config.msi", 
		"c:\Intel", 
		"c:\PerfLogs", 
		"c:\OneDriveTemp", 
		"c:\inetpub", 
		"c:\Ross-Tech", 
		"c:\Drivers")

	foreach ($mapa in $mape) {
		Try {
			# Poskusi izbrisati mapo z vsemi podmapami in datotekami brez potrditve
			Remove-Item -Path $mapa -Recurse -Force -ErrorAction Stop
			Write-Host "Folder '$mapa' successfully deleted."
		}
		Catch {
			# Preveri, če mapa ne obstaja
			if ($_.Exception -match 'Cannot find path') {
				Write-Host "Folder '$mapa' do not exist" -ForegroundColor Yellow
			}
			# Preveri, če je mapa zaklenjena ali nimamo dostopa
			elseif ($_.Exception -match 'cannot access the file') {
				Write-Host "Cannot access folder '$mapa'" -ForegroundColor Red
			}
			else {
				# Za vse druge vrste napak
				Write-Host "Error deleting folder '$mapa': $($_.Exception.Message)"
			}
		}
	}
	pause
}
else {
	echo "skipping temporary files cleanup ..."
}
