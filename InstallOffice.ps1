############################### Office 365 Unistall ###########################
$confirm = Read-Host "Uninstall Office 365 (y/n)?"
if ($confirm -eq 'y') {
	
	echo "Uninstalling Office 365 ..."
	Get-Item HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration | Remove-Item -Force -Verbose
	
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