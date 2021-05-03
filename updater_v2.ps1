param ($mode = "", $installer = "", $v = "")
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
if ($mode -like "dev") {
	$eon_test = Test-Path build 
	if ($eon_test -eq $False) { mkdir build } 
		Set-Location build
		Write-Output " " ;
		if ($null -eq (Get-Process -Name "osu!" -ErrorAction SilentlyContinue)) {} 
		else {	Write-Output "Closing osu!lazer" ; 
		Stop-Process -Name "osu!" -Force -ErrorAction SilentlyContinue -ErrorVariable processKilled ; }
		Start-Sleep -s 2 ;
		if ($v -eq "on") { Write-Host -ForegroundColor Red "Checking for updates, this may take a while. [Verbosity = True]" ; Write-Output " " ; }
					else { 
						Write-Host -ForegroundColor Green "Checking for updates, this may take a while." ; Write-Output " " ; }

		$eon_test = Test-Path bosu 
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/EVAST9919/bosu -q } 
			Set-Location bosu
				$updater_bosu = git pull --recurse-submodules ;
			Set-Location .. 

		$eon_test = Test-Path Cytosu
		if ($eon_test -eq $False) { git clone --recurse-submodules --branch dev-rework https://github.com/GSculerlor/Cytosu -q ; Write-Output " " } 
			Set-Location cytosu ;
				$updater_cytosu = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path osu-DIVA
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/Artemis-chan/osu-DIVA -q ; Write-Output " " } 
			Set-Location osu-DIVA ;
				$updater_diva = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path gamebosu 
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/Game4all/gamebosu -q ; Write-Output " " } 
			Set-Location gamebosu ;
				$updater_gamebosu = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path hishigata
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/LumpBloom7/hishigata -q ; Write-Output " " }
			Set-Location hishigata ;
				$updater_hishigata = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path lazer-m-vis 
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/EVAST9919/lazer-m-vis -q ; Write-Output " " } 
			Set-Location lazer-m-vis ;
				$updater_mvis = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path lazer-swing
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/EVAST9919/lazer-swing -q ; Write-Output " " } 
			Set-Location lazer-swing ;
				$updater_swing = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path rush
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/swoolcock/rush -q ; Write-Output " " }
			Set-Location rush ;
				$updater_rush = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path tau
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/Altenhh/tau -q ; Write-Output " " }
			Set-Location tau ;
				$updater_tau = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path sentakki
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/LumpBloom7/sentakki -q ; Write-Output " " }
			Set-Location sentakki ;
				$updater_sentakki = git pull --recurse-submodules ;
			Set-Location .. ;

		$eon_test = Test-Path soyokaze 
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/goodtrailer/soyokaze -q ; Write-Output " " }
			Set-Location soyokaze ;
				$updater_soyokaze = git pull --recurse-submodules ;
			Set-Location .. ;

<# Bosu #>
	if (($updater_bosu -notlike 'Already up*') -or ($installer -like "yep")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Bosu ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Bosu.dll ../Backup/ -Force }
			Set-Location bosu
				Write-Output "Compiling bosu" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Bosu/bin/Release/*/osu.Game.Rulesets.Bosu.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Bosu is already up to date." ; Write-Output " " }

	<# Cytosu #>
	if (($updater_cytosu -notlike 'Already up*') -or ($installer -like "yep")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Cytosu ====-" ;
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Cytosu.dll ../Backup/ -Force }
			Set-Location Cytosu
				Write-Output "Compiling cytosu" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder" ;
					Move-Item "./osu.Game.Rulesets.Cytosu/bin/Release/*/osu.Game.Rulesets.Cytosu.dll" ../../../rulesets/ -Force ;
				Write-Output "Ruleset updated." ;
				Write-Output " " ;
			Start-Sleep -s 2 ;
		Set-Location .. }
	else { Write-Output "Cytosu is already up to date." ; Write-Output " " }

	<# osu!Diva #>
	if (($updater_diva -notlike 'Already up*') -or ($installer -like "yep")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating osu!Diva ====-" ;
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Diva.dll ../Backup/ -Force ; }
			Set-Location "osu-Diva"
				Write-Output "Compiling osu!diva" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
					else { 
						dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder" ;
					Move-Item "./osu.Game.Rulesets.Diva/bin/Release/*/osu.Game.Rulesets.Diva.dll" ../../../rulesets/ -Force ;
				Write-Output "Ruleset updated." ;
				Write-Output " " ;
			Start-Sleep -s 2 ;
		Set-Location .. }
	else { Write-Output "osu!Diva is already up to date." ; Write-Output " " }

	<# Gamebosu #>
	if (($updater_gamebosu -notlike 'Already up*') -or ($installer -like "yep")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Gamebosu ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Gamebosu.dll ../Backup/ -Force }
			Set-Location gamebosu
				Write-Output "Compiling gamebosu" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Gamebosu/bin/Release/*/osu.Game.Rulesets.Gamebosu.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Gamebosu is already up to date." ; Write-Output " " }

	<# Hishigata #>
	if (($updater_hishigata -notlike 'Already up*') -or ($installer -like "yep")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Hishigata ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Hishigata.dll ../Backup/ -Force }
			Set-Location hishigata
				Write-Output "Compiling hishigata" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Hishigata/bin/Release/*/osu.Game.Rulesets.Hishigata.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Hishigata is already up to date." ; Write-Output " " }

	$eon_test = Test-Path ../downloader
		if ($eon_test -eq $False) { mkdir ../downloader ; Set-Location ../downloader }
		else { Set-Location ../downloader }

	<# Hitokori #>
	$hitokoriLatest = Invoke-WebRequest https://github.com/Flutterish/Hitokori/releases/latest -Headers @{"Accept"="application/json"} ;
	$hitokoriLatest = $hitokoriLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$hitokoriCurrent = Get-Content "./hitokori/version.txt" -ErrorAction SilentlyContinue
	if ($hitokoriLatest -eq $hitokoriCurrent) { Write-Output "Hitokori is already up to date." ; Write-Output " "}
		else {
			Write-Host -ForegroundColor Blue "-==== Downloading Hitokori ====-" ;
				Invoke-WebRequest -Uri https://github.com/Flutterish/Hitokori/releases/latest/download/osu.Game.Rulesets.Hitokori.dll -OutFile "./hitokori/osu.Game.Rulesets.Hitokori.dll" ;
					$hitokoriLatest > "./hitokori/version.txt"
				Move-Item ../../rulesets/osu.Game.Rulesets.Hitokori.dll ../Backup/ -Force -ErrorAction SilentlyContinue
			Write-Output "Moving updated dll to Rulesets folder" ;
				Move-Item "./hitokori/osu.Game.Rulesets.Hitokori.dll" ../../rulesets/ -Force ;
			Write-Output "Ruleset updated." ;
			Write-Output " " ;
			Start-Sleep -s 2 ; }
	<#==========#>

	<# Karaoke #>
	$karaokeLatest = Invoke-WebRequest https://github.com/karaoke-dev/karaoke/releases/latest -Headers @{"Accept"="application/json"} ;
	$karaokeLatest = $karaokeLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$karaokeCurrent = Get-Content "./karaoke/version.txt" -ErrorAction SilentlyContinue
	if ($karaokeLatest -eq $karaokeCurrent) { Write-Output "Karaoke is already up to date." ; Write-Output " " }
		else {
			Write-Host -ForegroundColor Blue "-==== Downloading Karaoke ====-" ;
				Invoke-WebRequest -Uri https://github.com/karaoke-dev/karaoke/releases/latest/download/osu.Game.Rulesets.Karaoke.dll -OutFile "./karaoke/osu.Game.Rulesets.Karaoke.dll" ;
					$karaokeLatest > "./karaoke/version.txt"
				Move-Item ../../rulesets/osu.Game.Rulesets.Karaoke.dll ../Backup/ -Force -ErrorAction SilentlyContinue
			Write-Output "Moving updated dll to Rulesets folder" ;
				Move-Item "./karaoke/osu.Game.Rulesets.Karaoke.dll" ../../rulesets/ -Force ;
			Write-Output "Ruleset updated." ;
			Write-Output " " ;
			Start-Sleep -s 2 ; }
			Set-Location ../build
	<#==========#>

	<# Mvis #>
	if (($updater_mvis -notlike 'Already up*') -or ($installer -like "yep")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Mvis ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Mvis.dll ../Backup/ -Force }
			Set-Location lazer-m-vis
				Write-Output "Compiling mvis" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Mvis/bin/Release/*/osu.Game.Rulesets.Mvis.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Mvis is already up to date." ; Write-Output " " }

	<# Rush #>
	if (($updater_rush -notlike 'Already up*') -or ($installer -like "yep")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Rush ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Rush.dll ../Backup/ -Force }
			Set-Location rush
				Write-Output "Compiling rush" ;
					if ($v -eq "on") { dotnet publish -c Development -v n }
						else { 
							dotnet publish -c Development --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Rush/bin/Release/*/osu.Game.Rulesets.Rush.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Rush is already up to date." ; Write-Output " " }

	<# Sentakki #>
	if (($updater_sentakki -notlike 'Already up*') -or ($installer -like "yep")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Sentakki ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Sentakki.dll ../Backup/ -Force }
			Set-Location sentakki
				Write-Output "Compiling sentakki" ;
					if ($v -eq "on") { dotnet publish -c Development -v n }
						else { 
							dotnet publish -c Development --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Sentakki/bin/Release/*/osu.Game.Rulesets.Sentakki.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Sentakki is already up to date." ; Write-Output " " }

	<# Tau #>
	if (($updater_tau -notlike 'Already up*') -or ($installer -like "yep")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Tau ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Tau.dll ../Backup/ -Force }
			Set-Location tau
				Write-Output "Compiling tau" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Tau/bin/Release/*/osu.Game.Rulesets.Tau.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Tau is already up to date." ; Write-Output " " }

	<# Swing #>
	if (($updater_swing -notlike 'Already up*') -or ($installer -like "yep")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Swing ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Swing.dll ../Backup/ -Force }
			Set-Location lazer-swing
				Write-Output "Compiling swing" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Swing/bin/Release/*/osu.Game.Rulesets.Swing.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Swing is already up to date." ; Write-Output " " }

	<# Soyokaze #>
	if (($updater_soyokaze -notlike 'Already up*') -or ($installer -like "yep")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Soyokaze ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item ../../rulesets/osu.Game.Rulesets.Soyokaze.dll ../Backup/ -Force }
			Set-Location soyokaze
				Write-Output "Compiling soyokaze" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "./osu.Game.Rulesets.Soyokaze/bin/Release/*/osu.Game.Rulesets.Soyokaze.dll" ../../../rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Output "Soyokaze is already up to date." ; Write-Output " " }

	<# Clearing variables#>
	$updater_bosu = Write-Output "" ;
	$updater_cytosu = Write-Output "" ;
	$updater_diva = Write-Output "" ;
	$updater_hishigata = Write-Output "" ;
	$updater_gamebosu = Write-Output "" ;
	$updater_mvis = Write-Output "" ;
	$updater_rush = Write-Output "" ;
	$updater_sentakki = Write-Output "" ;
	$updater_swing = Write-Output "" ;
	$updater_tau = Write-Output "" ;
	$updater_soyokaze = Write-Output "" ;
	<#==================#>
	}
	else { Write-Output "Downloader version not yet finished. Please specify -mode 'dev' to run the devel verion (builder¹)" ;  Write-Host -ForegroundColor DarkRed "¹ Please be aware that you have no warranty when using this mode, self-building is not supported by the ruleset developers." ; Write-Output " " }

<#  else {
	Set-Location ./downloader #>
	<# Bosu
	$bosuLatest = Invoke-WebRequest https://github.com/EVAST9919/bosu/releases/latest -Headers @{"Accept"="application/json"} ;
	$bosuJson = $bosuLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$bosuLatest = $bosuJson
	$bosuCurrent = Get-Content ./bosu/version.txt
	if ($bosuLatest -eq $bosuCurrent) { Write-Output "bosu is already up to date." }
		else {
			Write-Output "Downloading ruleset" ;
			Invoke-WebRequest -Uri "https://github.com/Flutterish/Hitokori/releases/download/$bosuLatest/osu.Game.Rulesets.Bosu.dll" -OutFile "./bosu/osu.Game.Rulesets.Bosu.dll" ;
			$bosuLatest > ./bosu/version.txt
			Move-Item ../../rulesets/osu.Game.Rulesets.Bosu.dll ./Backup -Force
			Write-Output "Moving updated dll to Rulesets folder" ;
			Move-Item "./hitokori/osu.Game.Rulesets.Bosu.dll" ../../rulesets/ -Force ;
			Write-Output "Ruleset updated." ;
			Write-Output " " ;
			Start-Sleep -s 2 ;
		}#>

	<# Cytosu
	$cytosuLatest = Invoke-WebRequest https://api.github.com/repos/GSculerlor/Cytosu/releases -Headers @{"Accept"="application/json"} ;
	$cytosuJson = $cytosuLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$cytosuLatest = $cytosuJson.Trim(" ")
	$cytosuCurrent = Get-Content ./Cytosu/version.txt
	if ($cytosuLatest -eq $cytosuCurrent) { Write-Output "Cytosu is already up to date." }
		else {
			Write-Output "Downloading ruleset" ;
			Invoke-WebRequest -Uri https://github.com/GSculerlor/Cytosu/releases/download/$CytosuLatest/osu.Game.Rulesets.Cytosu.dll -OutFile "./Cytosu/osu.Game.Rulesets.Cytosu.dll" ;
			$cytosuLatest > ./Cytosu/version.txt
			Move-Item ../../rulesets/osu.Game.Rulesets.Cytosu.dll ./Backup -Force
			Write-Output "Moving updated dll to Rulesets folder" ;
			Move-Item "./Cytosu/osu.Game.Rulesets.Cytosu.dll" ../../rulesets/ -Force ;
			Write-Output "Ruleset updated." ;
			Write-Output " " ;
			Start-Sleep -s 2 ;
		}#>

	<# Hitokori
	$hitokoriLatest = Invoke-WebRequest https://github.com/Flutterish/Hitokori/releases/latest -Headers @{"Accept"="application/json"} ;
	$hitokoriLatest = $hitokoriLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$hitokoriCurrent = Get-Content "./hitokori/version.txt" -ErrorAction SilentlyContinue
	if ($hitokoriLatest -eq $hitokoriCurrent) { Write-Output "Hitokori is already up to date." }
		else {
			Write-Output "Downloading ruleset" ;
			Invoke-WebRequest -Uri "https://github.com/Flutterish/Hitokori/releases/download/$hitokoriLatest/osu.Game.Rulesets.Hitokori.dll" -OutFile "./hitokori/osu.Game.Rulesets.Hitokori.dll" ;
			$hitokoriLatest > "./hitokori/version.txt"
			Move-Item ../../rulesets/osu.Game.Rulesets.Hitokori.dll ./Backup -Force
			Write-Output "Moving updated dll to Rulesets folder" ;
			Move-Item "./hitokori/osu.Game.Rulesets.Hitokori.dll" ../../rulesets/ -Force ;
			Write-Output "Ruleset updated." ;
			Write-Output " " ;
			Start-Sleep -s 2 ;
		}
}#>

$response = Read-Host -Prompt "Finished updating rulesets, want me to open osu! for you? ( Y | Yes | N | No )"
    if ($response -like 'y*') {
		Start-Process -FilePath "C:/Users/*/AppData/Local/osulazer/osu!.exe" ;
    }
	elseif ($response -like 'n*'){
		Write-Output "Done."
}