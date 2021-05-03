param ($mode = "")
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
Import-Module posh-git
if ($mode -like "dev") { 
	$eon_test = Test-Path build
	if ($eon_test -eq $False) { mkdir build }
	Set-Location build

	if ($null -eq (Get-Process -Name "osu!" -ErrorAction SilentlyContinue)) {} 
		else {	Write-Output "Closing osu!lazer" 
		Stop-Process -Name "osu!" -Force -ErrorAction SilentlyContinue -ErrorVariable processKilled }
	Start-Sleep -s 2
	
	Write-Output "Starting Git"
	$eon_test = Test-Path bosu
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading bosu ====-"
			git clone --recurse-submodules https://github.com/EVAST9919/bosu -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping bosu, repository already downloaded."
	}
	
	$eon_test = Test-Path Cytosu
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Cytosu ====-"
			git clone --recurse-submodules --branch dev-rework https://github.com/GSculerlor/Cytosu -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Cytosu, repository already downloaded."
	}

	$eon_test = Test-Path osu-DIVA
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading DIVA ====-"
			git clone --recurse-submodules https://github.com/Artemis-chan/osu-DIVA -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping osu-DIVA, repository already downloaded."
	}
	
	$eon_test = Test-Path gamebosu
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Gamebosu ====-"
			git clone --recurse-submodules https://github.com/Game4all/gamebosu -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Gamebosu, repository already downloaded."
	}
	
	$eon_test = Test-Path hishigata
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Hishigata ====-"
			git clone --recurse-submodules https://github.com/LumpBloom7/hishigata -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Hishigata, repository already downloaded."
	}
	
	$eon_test = Test-Path ../downloader
	if ($eon_test -eq $False) {
		mkdir ../downloader
	}

	$eon_test = Test-Path ../downloader/hitokori
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Hitokori ====-"
			mkdir ../downloader/hitokori
		Write-Output " "
	}
	else {
		Write-Output " Skipping Hitokori, path already exists."
	}
	
	$eon_test = Test-Path ../downloader/karaoke
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Karaoke ====-"
			mkdir ../downloader/karaoke
		Write-Output " "
	}
	else {
		Write-Output " Skipping Karaoke, path already exists."
	}
	
	$eon_test = Test-Path lazer-m-vis
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Mvis ====-"
			git clone --recurse-submodules https://github.com/EVAST9919/lazer-m-vis -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Mvis, repository already downloaded."
	}
	
	$eon_test = Test-Path rush
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Rush ====-"
			git clone --recurse-submodules https://github.com/swoolcock/rush -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Rush, repository already downloaded."
	}
	
	$eon_test = Test-Path sentakki
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Sentakki ====-"
			git clone --recurse-submodules https://github.com/LumpBloom7/sentakki -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Sentakki, repository already downloaded."
	}
	
	$eon_test = Test-Path soyokaze
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Soyokaze ====-"
			git clone --recurse-submodules https://github.com/goodtrailer/soyokaze -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Soyokaze, repository already downloaded."
	}
	
	$eon_test = Test-Path lazer-swing
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Swing ====-"
			git clone --recurse-submodules https://github.com/EVAST9919/lazer-swing -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Swing, repository already downloaded."
	}
	
	$eon_test = Test-Path tau
	if ($eon_test -eq $False) { 
		Write-Output "-==== Downloading Tau ====-"
			git clone --recurse-submodules https://github.com/Altenhh/tau -q
		Write-Output " "
	}
	else {
		Write-Output " Skipping Tau, repository already downloaded."
	}

	Set-Location ..
}

else { 
	$eon_test = Test-Path downloader
	if ($eon_test -eq $False) {
		mkdir downloader 
		Set-Location downloader
	}

	if ($null -eq (Get-Process -Name "osu!" -ErrorAction SilentlyContinue)) {} 
		else {	Write-Output "Closing osu!lazer" 
		Stop-Process -Name "osu!" -Force -ErrorAction SilentlyContinue -ErrorVariable processKilled }
	Start-Sleep -s 2
	
	Write-Output " "
	Write-Output "Creating folders"
	
	mkdir Cytosu
	Write-Output " "

	<#
		mkdir FlashVoltex
	Write-Output " "
	#>
	
		mkdir gamebosu
	Write-Output " "
	
		mkdir hishigata
	Write-Output " "
	
	
		mkdir Hitokori
	Write-Output " "
	
		mkdir karaoke
	Write-Output " "
	
		mkdir lazer-m-vis
	Write-Output " "
	
		mkdir lazer-swing
	Write-Output " "
	
		mkdir osu-DIVA
	Write-Output " "
	
		mkdir rush
	Write-Output " "
	
		mkdir sentakki
	Write-Output " "
	
	<#
		mkdir Solosu
	Write-Output " "
	#>
	
		mkdir tau
	Write-Output " "

		mkdir soyokaze
	Write-Output " "

	Set-Location ..
}

$eon_test = Test-Path Backup
if ($eon_test -eq $False) { mkdir Backup }
else { Write-Output "path 'Backup' already exists, skipping."}


powershell -Command "./updater_v2.ps1 $mode -installer 'yep'" -verb runAs

Write-Output " "
Write-Output "Installation Finished,"
Write-Output "Now you can simply run the updater by double-clicking the Updater shortcut."
	Start-Sleep -s 10