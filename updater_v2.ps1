param ($mode = "", $installer = "", $v = "", $solo = "")
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

if($mode -eq "") {
		Write-Host -ForegroundColor Yellow "Which mode do you want?"
		Write-Host -ForegroundColor Gray "0 - Use dev mode; `n1 - Use download mode."
		do
		{
			$key = [Console]::ReadKey($true)
			$value = $key.KeyChar

			switch($value) {
				0 { Write-Host -ForegroundColor Green "Dev mode enabled." ; $mode = Write-Output "dev"}
				1 { Write-Host -ForegroundColor Yellow "Continuing with downloader mode." ; continue }
			}
		}
	while ($value -notmatch '0|1')
}

if($v -eq "") {
		Write-Host -ForegroundColor Yellow "Enable verbose mode?"
		Write-Host -ForegroundColor Gray "0 - Enable verbosity; `n1 - Continue without verbose mode."
		do
		{
			$key = [Console]::ReadKey($true)
			$value = $key.KeyChar

			switch($value) {
				0 { $v = Write-Output "on"}
				1 { clear ; continue}
			}
		}
	while ($value -notmatch '0|1')
}

$PSVersionTest = Get-Host | Select-Object -Expand Version | Select-Object -ExpandProperty Major
if($PSVersionTest -lt "7") { Write-Host -ForegroundColor DarkRed "This script is not compatible with this version of powershell, please launch it using Powershell 7 (pwsh)" ; Write-Host -ForegroundColor Red "If you don't know how to do it, please execute AllowScriptRuntime.bat" }
if($PSVersionTest -ge "7") {
<# Create new Alias command #>
function Get-IniFile {  
    param(  [parameter(Mandatory = $true)] [string] $filePath  )  

    $anonymous = "NoSection"

    $ini = @{}  
    switch -regex -file $filePath  {  
		"^\[(.+)\]$" {  
			$section = $matches[1]  
			$ini[$section] = @{}  
			$CommentCount = 0  }  

        "^(;.*)$" {  
            if (!($section))  {  
                $section = $anonymous  
                $ini[$section] = @{}  }  
            $value = $matches[1]  
            $CommentCount = $CommentCount + 1  
            $name = "Comment" + $CommentCount  
            $ini[$section][$name] = $value  }   

        "(.+?)\s*=\s*(.*)" {  
            if (!($section))  {  
                $section = $anonymous  
                $ini[$section] = @{}  }  
            $name,$value = $matches[1..2]  
            $ini[$section][$name] = $value  }  }  

		return $ini  }  
<# ====================== #>

if($isWindows -eq $True){
	$PathTest = Test-Path $env:APPDATA/osu/storage.ini
	if($pathTest -eq $True) {
		$osuFilePath = Get-IniFile $env:APPDATA/osu/storage.ini
		$osuFilePath = $osuFilePath.NoSection.FullPath

		$pathTest = Test-Path $osuFilePath/ruleset_updater
		if($pathTest -eq $True) { 
			Set-Location $osuFilePath/ruleset_updater 
		}
		else {  
			mkdir $osuFilePath/ruleset_updater
			Set-Location $osuFilePath/ruleset_updater 
		} 
	}
	else {  
		$pathTest = Test-Path $env:APPDATA/osu/ruleset_updater
		if($pathTest -eq $True) { 
			Set-Location $env:APPDATA/osu/ruleset_updater 
		}
		else {
			mkdir $env:APPDATA/osu/ruleset_updater
			Set-Location $env:APPDATA/osu/ruleset_updater
		}
	}
}
elseif($isLinux -eq $True){
	$PathTest = Test-Path ~/.local/share/osu/storage.ini
	if($pathTest -eq $True) {
		$osuFilePath = Get-IniFile ~/.local/share/osu/storage.ini
		$osuFilePath = $osuFilePath.NoSection.FullPath

		$pathTest = Test-Path $osuFilePath/ruleset_updater
		if($pathTest -eq $True) { 
			Set-Location $osuFilePath/ruleset_updater 
		}
		else {  
			mkdir $osuFilePath/ruleset_updater
			Set-Location $osuFilePath/ruleset_updater 
		} 
	}
	else {  
		$pathTest = Test-Path ~/.local/share/osu/ruleset_updater
		if($pathTest -eq $True) { 
			Set-Location ~/.local/share/osu/ruleset_updater 
		}
		else {
			mkdir ~/.local/share/osu/ruleset_updater
			Set-Location ~/.local/share/osu/ruleset_updater
		}
	}
}

elseif($isMacOS -eq $True){Write-Output "OS still not supported, closing."}

if ($mode -like "dev") {
	$test_dotnet = dotnet --version -ErrorAction SilentlyContinue
			if ($test_dotnet -notlike "5.0*") {
				do {
				$dotnet_i_prompt = Read-Host -Prompt "Since you specified '-mode dev', I tried to find .NET 5.0 but couldn't find, do you want to install it? ( Y | N )"
				if ($dotnet_i_prompt -eq 'y') { 
					if($v -ne "on") {
						Clear-Host
					}
					Write-Host -ForegroundColor DarkYellow "Okay, then I'll be installing .NET for you, please wait a bit until I prompt you, since this can take a while. Thanks for your patience."
					if($isWindows -eq $True) {
					Invoke-WebRequest -Uri https://dotnet.microsoft.com/download/dotnet/thank-you/sdk-5.0.301-windows-x64-installer -OutFile $env:LOCALAPPDATA\Temp\sdk-dotnet.msi
					Start-Process $env:LOCALAPPDATA\Temp\sdk-dotnet.msi
					}
					elseif($isLinux -eq $True) {
						Write-Output "Linux support not finished."
						break
						<#$testPath = Get-ChildItem /bin/snap -ErrorAction SilentlyContinue | Select-Object -expand Name
						if($testPath -eq "snap") { 
							if($v -ne "on") {
								Clear-Host
							}
							Write-Host -ForegroundColor DarkYellow "Okay, then I'll be installing .NET for you, please wait a bit until I prompt you, since this can take a while. Thanks for your patience."
							sudo snap install dotnet-sdk --classic --channel=5.0
							alias dotnet="snap run dotnet-sdk.dotnet"
							
							Write-Output "Dotnet"
						}#>
					}
				} 
			elseif ($dotnet_i_prompt -eq 'n') { 
				if($v -ne "on") {
					Clear-Host
				}
				Write-Host -ForegroundColor Red "You specified '-mode dev' but you refused to install the compiler. If you want to use downloader mode, run it without specifing anything."
				Start-Sleep -s 5
				break
			}
		if($v -ne "on") {
			Clear-Host
		}
	}
    until($dotnet_i_prompt -ne 'n' -or 'y')
}
if ($dotnet_i_prompt -eq 'n') { break }
	$eon_test = Test-Path $osuFilePath/ruleset_updater/build 
	if ($eon_test -eq $False) { mkdir $osuFilePath/ruleset_updater/build } 
		Set-Location $osuFilePath/ruleset_updater/build
		Write-Output " " ;
		if ($null -eq (Get-Process -Name "osu!" -ErrorAction SilentlyContinue)) {} 
		else {	Write-Output "Closing osu!lazer" ; 
		Stop-Process -Name "osu!" -Force -ErrorAction SilentlyContinue -ErrorVariable processKilled ; }

		Start-Sleep -s 2 ;
		if ($v -eq "on") { Write-Host -ForegroundColor Red "Checking for updates, this may take a while. [Verbosity = True]" ; Write-Output " " ; }
					else { 
						Write-Host -ForegroundColor Green "Checking for updates, this may take a while." ; Write-Output " " ; }

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/bosu 
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/EVAST9919/bosu -q } 
			Set-Location $osuFilePath/ruleset_updater/build/bosu
				$updater_bosu = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build 

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/Cytosu
		if ($eon_test -eq $False) { git clone --recurse-submodules --branch dev-rework https://github.com/GSculerlor/Cytosu -q ; Write-Output " " } 
			Set-Location $osuFilePath/ruleset_updater/build/cytosu ;
				$updater_cytosu = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/osu-DIVA
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/Artemis-chan/osu-DIVA -q ; Write-Output " " } 
			Set-Location $osuFilePath/ruleset_updater/build/osu-DIVA ;
				$updater_diva = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/gamebosu 
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/Game4all/gamebosu -q ; Write-Output " " } 
			Set-Location $osuFilePath/ruleset_updater/build/gamebosu ;
				$updater_gamebosu = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/hishigata
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/LumpBloom7/hishigata -q ; Write-Output " " }
			Set-Location $osuFilePath/ruleset_updater/build/hishigata ;
				$updater_hishigata = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/lazer-m-vis 
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/EVAST9919/lazer-m-vis -q ; Write-Output " " } 
			Set-Location $osuFilePath/ruleset_updater/build/lazer-m-vis ;
				$updater_mvis = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/rush
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/swoolcock/rush -q ; Write-Output " " }
			Set-Location $osuFilePath/ruleset_updater/build/rush ;
				$updater_rush = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/lazer-sandbox
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/EVAST9919/lazer-sandbox -q ; Write-Output " " }
			Set-Location $osuFilePath/ruleset_updater/build/lazer-sandbox ;
				$updater_sandbox = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/sentakki
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/LumpBloom7/sentakki -q ; Write-Output " " }
			Set-Location $osuFilePath/ruleset_updater/build/sentakki ;
				$updater_sentakki = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/lazer-swing
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/EVAST9919/lazer-swing -q ; Write-Output " " } 
			Set-Location $osuFilePath/ruleset_updater/build/lazer-swing ;
				$updater_swing = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/soyokaze 
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/goodtrailer/soyokaze -q ; Write-Output " " }
			Set-Location $osuFilePath/ruleset_updater/build/soyokaze ;
				$updater_soyokaze = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/tau
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/Altenhh/tau -q ; Write-Output " " }
			Set-Location $osuFilePath/ruleset_updater/build/tau ;
				$updater_tau = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

		$eon_test = Test-Path $osuFilePath/ruleset_updater/build/touhosu
		if ($eon_test -eq $False) { git clone --recurse-submodules https://github.com/EVAST9919/touhosu -q ; Write-Output " " }
			Set-Location $osuFilePath/ruleset_updater/build/touhosu ;
				$updater_touhosu = git pull --recurse-submodules ;
			Set-Location $osuFilePath/ruleset_updater/build

<# Bosu #>
	if (($updater_bosu -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "bosu")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Bosu ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Bosu.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/bosu
				Write-Output "Compiling bosu" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/Bosu/osu.Game.Rulesets.Bosu/bin/Release/*/osu.Game.Rulesets.Bosu.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location $osuFilePath/ruleset_updater/build }
	else { Write-Host -ForegroundColor Blue "Bosu is already up to date." ; Write-Output " " }

	<# Cytosu #>
	if (($updater_cytosu -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "cytosu")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Cytosu ====-" ;
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Cytosu.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/Cytosu
				Write-Output "Compiling cytosu" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder" ;
					Move-Item "$osuFilePath/ruleset_updater/build/Cytosu/osu.Game.Rulesets.Cytosu/bin/Release/*/osu.Game.Rulesets.Cytosu.dll" $osuFilePath/rulesets/ -Force ;
				Write-Output "Ruleset updated." ;
				Write-Output " " ;
			Start-Sleep -s 2 ;
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Cytosu is already up to date." ; Write-Output " " }

	<# osu!Diva #>
	if (($updater_diva -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "diva")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating osu!Diva ====-" ;
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Diva.dll $osuFilePath/ruleset_updater/Backup/ -Force ; }
			Set-Location $osuFilePath/ruleset_updater/build/osu-Diva
				Write-Output "Compiling osu!diva" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
					else { 
						dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder" ;
					Move-Item "$osuFilePath/ruleset_updater/build/osu-Diva/osu.Game.Rulesets.Diva/bin/Release/*/osu.Game.Rulesets.Diva.dll" $osuFilePath/rulesets/ -Force ;
				Write-Output "Ruleset updated." ;
				Write-Output " " ;
			Start-Sleep -s 2 ;
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "osu!Diva is already up to date." ; Write-Output " " }

	<# Gamebosu #>
	if (($updater_gamebosu -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "gamebosu")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Gamebosu ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Gamebosu.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/gamebosu
				Write-Output "Compiling gamebosu" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/Gamebosu/osu.Game.Rulesets.Gamebosu/bin/Release/*/osu.Game.Rulesets.Gamebosu.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Gamebosu is already up to date." ; Write-Output " " }

	<# Hishigata #>
	if (($updater_hishigata -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "hishigata")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Hishigata ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Hishigata.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/hishigata
				Write-Output "Compiling hishigata" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/hishigata/osu.Game.Rulesets.Hishigata/bin/Release/*/osu.Game.Rulesets.Hishigata.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Hishigata is already up to date." ; Write-Output " " }

	$eon_test = Test-Path $osuFilePath/ruleset_updater/downloader
		if ($eon_test -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader ; Set-Location $osuFilePath/ruleset_updater/downloader }
		else { Set-Location $osuFilePath/ruleset_updater/downloader }

	<# Hitokori #>
	$hitokoriLatest = Invoke-WebRequest https://github.com/Flutterish/Hitokori/releases/latest -Headers @{"Accept"="application/json"} ;
	$hitokoriLatest = $hitokoriLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$hitokoriCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/hitokori/version.txt -ErrorAction SilentlyContinue
	if ($hitokoriLatest -eq $hitokoriCurrent) { Write-Host -ForegroundColor Blue "Hitokori is already up to date." ; Write-Output " "}
		else {
			Write-Host -ForegroundColor Blue "-==== Downloading Hitokori ====-" ;
				Invoke-WebRequest -Uri https://github.com/Flutterish/Hitokori/releases/latest/download/osu.Game.Rulesets.Hitokori.dll -OutFile $osuFilePath/ruleset_updater/downloader/hitokori/osu.Game.Rulesets.Hitokori.dll ;
					$hitokoriLatest > $osuFilePath/ruleset_updater/downloader/hitokori/version.txt
				Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Hitokori.dll $osuFilePath/ruleset_updater/Backup/ -Force -ErrorAction SilentlyContinue
			Write-Output "Moving updated dll to Rulesets folder" ;
				Move-Item $osuFilePath/ruleset_updater/downloader/hitokori/osu.Game.Rulesets.Hitokori.dll $osuFilePath/rulesets/ -Force ;
			Write-Output "Ruleset updated." ;
			Write-Output " " ;
			Start-Sleep -s 2 ; }
	<#==========#>

	<# Karaoke #>
	$karaokeLatest = Invoke-WebRequest https://github.com/karaoke-dev/karaoke/releases/latest -Headers @{"Accept"="application/json"} ;
	$karaokeLatest = $karaokeLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$karaokeCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/karaoke/version.txt -ErrorAction SilentlyContinue
	if ($karaokeLatest -eq $karaokeCurrent) { Write-Host -ForegroundColor Blue "Karaoke is already up to date." ; Write-Output " " }
		else {
			Write-Host -ForegroundColor Blue "-==== Downloading Karaoke ====-" ;
				Invoke-WebRequest -Uri https://github.com/karaoke-dev/karaoke/releases/latest/download/osu.Game.Rulesets.Karaoke.dll -OutFile $osuFilePath/ruleset_updater/downloader/karaoke/osu.Game.Rulesets.Karaoke.dll ;
					$karaokeLatest > $osuFilePath/ruleset_updater/downloader/karaoke/version.txt
				Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Karaoke.dll $osuFilePath/ruleset_updater/Backup/ -Force -ErrorAction SilentlyContinue
			Write-Output "Moving updated dll to Rulesets folder" ;
				Move-Item $osuFilePath/ruleset_updater/downloader/karaoke/osu.Game.Rulesets.Karaoke.dll $osuFilePath/rulesets/ -Force ;
			Write-Output "Ruleset updated." ;
			Write-Output " " ;
			Start-Sleep -s 2 ; }
			Set-Location $osuFilePath/ruleset_updater/build
	<#==========#>

	<# Mvis #>
	if (($updater_mvis -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "mvis")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Mvis ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Mvis.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/lazer-m-vis
				Write-Output "Compiling mvis" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/lazer-m-vis/osu.Game.Rulesets.Mvis/bin/Release/*/osu.Game.Rulesets.Mvis.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Mvis is already up to date." ; Write-Output " " }

	<# Rush #>
	if (($updater_rush -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "rush")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Rush ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Rush-dev.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/rush
				Write-Output "Compiling rush" ;
					if ($v -eq "on") { dotnet publish -c Development -v n }
						else { 
							dotnet publish -c Development --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/rush/osu.Game.Rulesets.Rush/bin/Development/*/osu.Game.Rulesets.Rush-dev.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Rush is already up to date." ; Write-Output " " }

	<# Sandbox #>
	if (($updater_sandbox -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "sandbox")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Sandbox ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Sandbox.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/lazer-sandbox
				Write-Output "Compiling sandbox" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/lazer-sandbox/osu.Game.Rulesets.Sandbox/bin/Release/*/osu.Game.Rulesets.Sandbox.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Sandbox is already up to date." ; Write-Output " " }

	<# Sentakki #>
	if (($updater_sentakki -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "sentakki")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Sentakki ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Sentakki.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/sentakki
				Write-Output "Compiling sentakki" ;
					if ($v -eq "on") { dotnet publish -c Debug -v n }
						else { 
							dotnet publish -c Debug --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/sentakki/osu.Game.Rulesets.Sentakki/bin/Debug/*/osu.Game.Rulesets.Sentakki.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Sentakki is already up to date." ; Write-Output " " }

	<# Soyokaze #>
	if (($updater_soyokaze -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "soyokaze")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Soyokaze ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Soyokaze.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/soyokaze
				Write-Output "Compiling soyokaze" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/soyokaze/osu.Game.Rulesets.Soyokaze/bin/Release/*/osu.Game.Rulesets.Soyokaze.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Soyokaze is already up to date." ; Write-Output " " }

	<# Swing #>
	if (($updater_swing -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "swing")) {
			if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Swing ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Swing.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/lazer-swing
				Write-Output "Compiling swing" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/lazer-swing/osu.Game.Rulesets.Swing/bin/Release/*/osu.Game.Rulesets.Swing.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Swing is already up to date." ; Write-Output " " }

	<# Tau #>
	if (($updater_tau -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "tau")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Tau ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Tau.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/tau
				Write-Output "Compiling tau" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/tau/osu.Game.Rulesets.Tau/bin/Release/*/osu.Game.Rulesets.Tau.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Tau is already up to date." ; Write-Output " " }

	<# Touhosu #>
	if (($updater_touhosu -notlike 'Already up*') -or ($installer -like "yep") -or ($solo -like "touhosu")) {
		if ($installer -notlike "yep") {
			Write-Host -ForegroundColor Blue "-==== Updating Touhosu ====-"
				Write-Output "Making a backup of the ruleset..."
					Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Touhosu.dll $osuFilePath/ruleset_updater/Backup/ -Force }
			Set-Location $osuFilePath/ruleset_updater/build/touhosu
				Write-Output "Compiling touhosu" ;
					if ($v -eq "on") { dotnet publish -c Release -v n }
						else { 
							dotnet publish -c Release --nologo --verbosity quiet }
					Write-Output "Moving updated dll to Rulesets folder"
					Move-Item "$osuFilePath/ruleset_updater/build/touhosu/osu.Game.Rulesets.Touhosu/bin/Release/*/osu.Game.Rulesets.Touhosu.dll" $osuFilePath/rulesets/ -Force
				Write-Output "Ruleset updated."
				Write-Output " "
			Start-Sleep -s 2 
		Set-Location .. }
	else { Write-Host -ForegroundColor Blue "Touhosu is already up to date." ; Write-Output " " }

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
	$updater_touhosu = Write-Output "" ;
	<#==================#>
}
	<# ======================= Downloader ======================= #>
else {

	$eon_test = Test-Path $osuFilePath/ruleset_updater/downloader
		if ($eon_test -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader ; Set-Location $osuFilePath/ruleset_updater/downloader }
		else { Set-Location $osuFilePath/ruleset_updater/downloader }

	<# Bosu #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/bosu) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/bosu }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/bosu/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/bosu/version.txt }
	$bosuLatest = Invoke-WebRequest https://github.com/EVAST9919/bosu/releases/latest -Headers @{"Accept"="application/json"}
	$bosuJson = $bosuLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$bosuLatest = $bosuJson
	$bosuCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/bosu/version.txt
	if ($bosuLatest -eq $bosuCurrent) { Write-Host -ForegroundColor Blue "bosu is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/Flutterish/Hitokori/releases/download/$bosuLatest/osu.Game.Rulesets.Bosu.dll" -OutFile $osuFilePath/ruleset_updater/downloader/bosu/osu.Game.Rulesets.Bosu.dll
			$bosuLatest > $osuFilePath/ruleset_updater/downloader/bosu/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Bosu.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/hitokori/osu.Game.Rulesets.Bosu.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		}

	<# Cytosu #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/Cytosu) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/Cytosu }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/Cytosu/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/Cytosu/version.txt }
	$cytosuLatest = Invoke-WebRequest https://api.github.com/repos/GSculerlor/Cytosu/releases -Headers @{"Accept"="application/json"}
	$cytosuJson = $cytosuLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$cytosuLatest = $cytosuJson.Trim(" ")
	$cytosuCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/Cytosu/version.txt
	if ($cytosuLatest -eq $cytosuCurrent) { Write-Host -ForegroundColor Blue "Cytosu is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri https://github.com/GSculerlor/Cytosu/releases/download/$CytosuLatest/osu.Game.Rulesets.Cytosu.dll -OutFile $osuFilePath/ruleset_updater/downloader/Cytosu/osu.Game.Rulesets.Cytosu.dll
			$cytosuLatest > $osuFilePath/ruleset_updater/downloader/Cytosu/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Cytosu.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/Cytosu/osu.Game.Rulesets.Cytosu.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		}

	<# Diva #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/osu-DIVA) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/osu-DIVA }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/osu-DIVA/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/osu-DIVA/version.txt }
	$divaLatest = Invoke-WebRequest https://github.com//releases/latest -Headers @{"Accept"="application/json"}
	$divaLatest = $divaLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$divaCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/osu-DIVA/version.txt -ErrorAction SilentlyContinue
	if ($divaLatest -eq $divaCurrent) { Write-Host -ForegroundColor Blue "osu!DIVA is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com//releases/download/$divaLatest/osu.Game.Rulesets.Diva.dll" -OutFile $osuFilePath/ruleset_updater/downloader/osu-DIVA/osu.Game.Rulesets.Diva.dll
			$divaLatest > $osuFilePath/ruleset_updater/downloader/osu-DIVA/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Diva.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/osu-DIVA/osu.Game.Rulesets.Diva.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		} 

	<# Gamebosu #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/gamebosu) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/gamebosu }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/gamebosu/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/gamebosu/version.txt }
	$gamebosuLatest = Invoke-WebRequest https://github.com/Game4all/gamebosu/releases/latest -Headers @{"Accept"="application/json"}
	$gamebosuLatest = $gamebosuLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$gamebosuCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/hitokori/version.txt -ErrorAction SilentlyContinue
	if ($gamebosuLatest -eq $gamebosuCurrent) { Write-Host -ForegroundColor Blue "Gamebosu is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/Game4all/gamebosu/releases/download/$gamebosuLatest/osu.Game.Rulesets.Gamebosu.dll" -OutFile $osuFilePath/ruleset_updater/downloader/gamebosu/osu.Game.Rulesets.Gamebosu.dll
			$gamebosuLatest > $osuFilePath/ruleset_updater/downloader/gamebosu/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Gamebosu.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/gamebosu/osu.Game.Rulesets.Gamebosu.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		}
		
	<# Hishigata #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/hishigata) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/hishigata }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/hishigata/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/hishigata/version.txt }
	$hishigataLatest = Invoke-WebRequest https://github.com/LumpBloom7/hishigata/releases/latest -Headers @{"Accept"="application/json"}
	$hishigataLatest = $hishigataLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$hishigataCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/hishigata/version.txt -ErrorAction SilentlyContinue
	if ($hishigataLatest -eq $hishigataCurrent) { Write-Host -ForegroundColor Blue "Hishigata is already up to date." }
		else {
			Write-Output "Downloading ruleset" ;
			Invoke-WebRequest -Uri "https://github.com/LumpBloom7/hishigata/releases/download/$hishigataLatest/osu.Game.Rulesets.Hishigata.dll" -OutFile $osuFilePath/ruleset_updater/downloader/hishigata/osu.Game.Rulesets.Hishigata.dll
			$hishigataLatest > $osuFilePath/ruleset_updater/downloader/hishigata/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Hishigata.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/hishigata/osu.Game.Rulesets.Hishigata.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		}

	<# Hitokori #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/hitokori) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/hitokori }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/hitokori/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/hitokori/version.txt }
	$hitokoriLatest = Invoke-WebRequest https://github.com/Flutterish/Hitokori/releases/latest -Headers @{"Accept"="application/json"}
	$hitokoriLatest = $hitokoriLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$hitokoriCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/hitokori/version.txt -ErrorAction SilentlyContinue
	if ($hitokoriLatest -eq $hitokoriCurrent) { Write-Host -ForegroundColor Blue "Hitokori is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/Flutterish/Hitokori/releases/download/$hitokoriLatest/osu.Game.Rulesets.Hitokori.dll" -OutFile $osuFilePath/ruleset_updater/downloader/hitokori/osu.Game.Rulesets.Hitokori.dll
			$hitokoriLatest > $osuFilePath/ruleset_updater/downloader/hitokori/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Hitokori.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/hitokori/osu.Game.Rulesets.Hitokori.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		}

	<# Karaoke #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/karaoke) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/karaoke }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/karaoke/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/karaoke/version.txt }
	$karaokeLatest = Invoke-WebRequest hhttps://github.com/karaoke-dev/karaoke/releases/latest -Headers @{"Accept"="application/json"}
	$karaokeLatest = $karaokeLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$karaokeCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/karaoke/version.txt -ErrorAction SilentlyContinue
	if ($karaokeLatest -eq $karaokeCurrent) { Write-Host -ForegroundColor Blue "Karaoke is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/karaoke-dev/karaoke/releases/download/$karaokeLatest/osu.Game.Rulesets.Karaoke.dll" -OutFile $osuFilePath/ruleset_updater/downloader/karaoke/osu.Game.Rulesets.Karaoke.dll
			$karaokeLatest > $osuFilePath/ruleset_updater/downloader/karaoke/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Karaoke.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/karaoke/osu.Game.Rulesets.Karaoke.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		}

	<# Rush #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/rush) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/rush }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/rush/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/rush/version.txt }
	$rushLatest = Invoke-WebRequest https://github.com/Beamographic/rush/releases/latest -Headers @{"Accept"="application/json"} ;
	$rushLatest = $rushLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$rushCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/rush/version.txt -ErrorAction SilentlyContinue
	if ($rushLatest -eq $rushCurrent) { Write-Host -ForegroundColor Blue " is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/Beamographic/rush/releases/download/$Latest/osu.Game.Rulesets..dll" -OutFile $osuFilePath/ruleset_updater/downloader/rush/osu.Game.Rulesets..dll
			$rushLatest > $osuFilePath/ruleset_updater/downloader/rush/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Rush.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/rush/osu.Game.Rulesets.Rush.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		} 

	<# Sandbox #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/lazer-sandbox) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/lazer-sandbox }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/lazer-sandbox/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/lazer-sandbox/version.txt }
	$sandboxLatest = Invoke-WebRequest https://github.com/EVAST9919/lazer-sandbox/releases/latest -Headers @{"Accept"="application/json"}
	$sandboxLatest = $sandboxLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$sandboxCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/lazer-sandbox/version.txt -ErrorAction SilentlyContinue
	if ($sandboxLatest -eq $sandboxCurrent) { Write-Host -ForegroundColor Blue "Sandbox is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/lazer-sandbox/releases/download/$sandboxLatest/osu.Game.Rulesets.Sandbox.dll" -OutFile $osuFilePath/ruleset_updater/downloader/lazer-sandbox/osu.Game.Rulesets.Sandbox.dll
			$sandboxLatest > $osuFilePath/ruleset_updater/downloader/lazer-sandbox/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Sandbox.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/lazer-sandbox/osu.Game.Rulesets.Sandbox.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		} 

	<# Sentakki #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/sentakki) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/sentakki }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/sentakki/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/sentakki/version.txt }
	$sentakkiLatest = Invoke-WebRequest https://github.com/LumpBloom7/sentakki/releases/latest -Headers @{"Accept"="application/json"}
	$sentakkiLatest = $sentakkiLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$sentakkiCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/sentakki/version.txt -ErrorAction SilentlyContinue
	if ($sentakkiLatest -eq $sentakkiCurrent) { Write-Host -ForegroundColor Blue "Sentakki is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/LumpBloom7/sentakki/releases/download/$Latest/osu.Game.Rulesets.Sentakki.dll" -OutFile $osuFilePath/ruleset_updater/downloader/sentakki/osu.Game.Rulesets.Sentakki.dll
			$sentakkiLatest > $osuFilePath/ruleset_updater/downloader/sentakki/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Sentakki.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/sentakki/osu.Game.Rulesets.Sentakki.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		} 

	<# Soyokaze #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/soyokaze) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/soyokaze }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/soyokaze/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/soyokaze/version.txt }
	$soyokazeLatest = Invoke-WebRequest https://github.com/goodtrailer/soyokaze/releases/latest -Headers @{"Accept"="application/json"}
	$soyokazeLatest = $soyokazeLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$soyokazeCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/soyokaze/version.txt -ErrorAction SilentlyContinue
	if ($soyokazeLatest -eq $soyokazeCurrent) { Write-Host -ForegroundColor Blue "Soyokaze is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/goodtrailer/soyokaze/releases/download/$Latest/osu.Game.Rulesets.Soyokaze.dll" -OutFile $osuFilePath/ruleset_updater/downloader/soyokaze/osu.Game.Rulesets.Soyokaze.dll
			$soyokazeLatest > $osuFilePath/ruleset_updater/downloader/soyokaze/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Soyokaze.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/soyokaze/osu.Game.Rulesets.Soyokaze.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		} 

	<# Swing #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/lazer-swing) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/lazer-swing }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/lazer-swing/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/lazer-swing/version.txt }
	$swingLatest = Invoke-WebRequest https://github.com/EVAST9919/lazer-swing/releases/latest -Headers @{"Accept"="application/json"}
	$swingLatest = $swingLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$swingCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/lazer-swing/version.txt -ErrorAction SilentlyContinue
	if ($swingLatest -eq $swingCurrent) { Write-Host -ForegroundColor Blue "Swing is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/EVAST9919/lazer-swing/releases/download/$Latest/osu.Game.Rulesets.Swing.dll" -OutFile $osuFilePath/ruleset_updater/downloader/lazer-swing/osu.Game.Rulesets.Swing.dll
			$swingLatest > $osuFilePath/ruleset_updater/downloader/lazer-swing/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Swing.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/lazer-swing/osu.Game.Rulesets.Swing.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		} 

	<# Tau #>
	if((Test-Path $osuFilePath/ruleset_updater/downloader/tau) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/tau }
	if((Test-Path $osuFilePath/ruleset_updater/downloader/tau/version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader/tau/version.txt }
	$tauLatest = Invoke-WebRequest https://github.com/naoei/tau/releases/latest -Headers @{"Accept"="application/json"}
	$tauLatest = $tauLatest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$tauCurrent = Get-Content $osuFilePath/ruleset_updater/downloader/tau/version.txt -ErrorAction SilentlyContinue
	if ($tauLatest -eq $tauCurrent) { Write-Host -ForegroundColor Blue "Tau is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com/naoei/tau/releases/download/$Latest/osu.Game.Rulesets.Tau.dll" -OutFile $osuFilePath/ruleset_updater/downloader/tau/osu.Game.Rulesets.Tau.dll
			$tauLatest > $osuFilePath/ruleset_updater/downloader/tau/version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets.Tau.dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader/tau/osu.Game.Rulesets.Tau.dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		}

	<#
	if((Test-Path $osuFilePath/ruleset_updater/downloader/) -eq $False) { mkdir $osuFilePath/ruleset_updater/downloader/ }
	if((Test-Path $osuFilePath/ruleset_updater/downloader//version.txt) -eq $False) { Write-Output "" > $osuFilePath/ruleset_updater/downloader//version.txt }
	$Latest = Invoke-WebRequest https://github.com//releases/latest -Headers @{"Accept"="application/json"}
	$Latest = $Latest.Content | ConvertFrom-Json | Select-Object -expand tag_name
	$Current = Get-Content $osuFilePath/ruleset_updater/downloader//version.txt -ErrorAction SilentlyContinue
	if ($Latest -eq $Current) { Write-Host -ForegroundColor Blue " is already up to date." }
		else {
			Write-Output "Downloading ruleset"
			Invoke-WebRequest -Uri "https://github.com//releases/download/$Latest/osu.Game.Rulesets..dll" -OutFile $osuFilePath/ruleset_updater/downloader//osu.Game.Rulesets..dll
			$Latest > $osuFilePath/ruleset_updater/downloader//version.txt
			Move-Item $osuFilePath/rulesets/osu.Game.Rulesets..dll $osuFilePath/ruleset_updater/Backup -Force
			Write-Output "Moving updated dll to Rulesets folder"
			Move-Item $osuFilePath/ruleset_updater/downloader//osu.Game.Rulesets..dll $osuFilePath/rulesets/ -Force
			Write-Output "Ruleset updated."
			Write-Output " "
			Start-Sleep -s 2
		} #>

}

if($v -ne "on") {	Clear-Host	}

Write-Host -ForegroundColor Green "Finished updating rulesets, want me to open osu! for you?"
Write-Host -ForegroundColor Gray " y - Open the game; `n n - Close powershell and nothing else."
do
		{
			$key = [Console]::ReadKey($true)
			$value = $key.KeyChar

			switch($value) {
				y { Start-Process -FilePath $env:USERPROFILE/AppData/Local/osulazer/osu!.exe ; }
				n { break }
			}
		}
	while ($value -notmatch 'y|n')
	
<# $response = Read-Host -Prompt "Finished updating rulesets, want me to open osu! for you? ( Y | Yes | N | No )"
    if ($response -like 'y*') 		{	Start-Process -FilePath $env:USERPROFILE/AppData/Local/osulazer/osu!.exe ; 	}
	elseif ($response -like 'n*')	{	Write-Output "Done." } #>

}
elseif($isWindows -eq $True) { 	Write-Output "Unsupported version of powershell detected, updating..."
			$psTag = Invoke-WebRequest https://github.com/PowerShell/PowerShell/releases/latest/ -Headers @{"Accept"="application/json"} ;
			$psTag = $psTag.Content | ConvertFrom-Json | Select-Object -expand tag_name ; $psTag = $psTag.Trim('v')
			Invoke-WebRequest -Uri 	"https://github.com/PowerShell/PowerShell/releases/download/latest/PowerShell-$psTag-win-x64.msi" -OutFile $env:LOCALAPPDATA/Temp/PowerShell-$psTag.msi
			Write-Output "Please complete the installation manually."
			msiexec /i $env:LOCALAPPDATA/Temp/PowerShell-$psTag.msi /norestart	} 
else { break }

<# else { Write-Output "Downloader version not yet finished. Please specify -mode 'dev' to run the devel verion (builder¹)" ;  Write-Host -ForegroundColor DarkRed "¹ Please be aware that you have no warranty when using this mode, self-building is not supported by the ruleset developers." ; Write-Output " " ; Start-Sleep -s 5 } #>
