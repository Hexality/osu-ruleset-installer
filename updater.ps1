echo "Closing osu!lazer" ;
echo "If u get an error, it's safe to ignore it if osu! was already closed." ;
	Stop-Process -Name "osu!" -Force ;
	Start-Sleep -s 2 ;
echo "Checking for updates, this may take a while." ;
	cd bosu ;
		git pull --recurse-submodules > $updater_bosu ;
		cd .. ;
		continue ;
	cd cytosu ;
		git pull --recurse-submodules > $updater_cytosu ;
		cd .. ;
		continue ;
	cd osu-DIVA ;
		git pull --recurse-submodules > $updater_diva ;
		cd .. ;
		continue ;
	cd gamebosu ;
		git pull --recurse-submodules > $updater_gamebosu ;
		cd .. ;
		continue ;
	cd hishigata ;
		git pull --recurse-submodules > $updater_hishigata ;
		cd .. ;
		continue ;
	cd lazer-m-vis ;
		git pull --recurse-submodules > $updater_mvis ;
		cd .. ;
		continue ;
	cd lazer-swing ;
		git pull --recurse-submodules > $updater_swing ;
		cd .. ;
		continue ;
	cd rush ;
		git pull --recurse-submodules > $updater_rush ;
		cd .. ;
		continue ;
	cd tau ;
		git pull --recurse-submodules > $updater_tau ;
		cd .. ;
		continue ;
	cd sentakki ;
		git pull --recurse-submodules > $updater_sentaki ;
		cd .. ;
		continue ;
	cd soyokaze ;
		git pull --recurse-submodules > $updater_soyokaze ;
		cd .. ;
		continue ;
		
if ($updater_bosu = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Bosu ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Bosu.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\bosu\osu.Game.Rulesets.Bosu\bin\Release\*\osu.Game.Rulesets.Bosu.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_cytosu = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Cytosu ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Cytosu.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\Cytosu\osu.Game.Rulesets.Cytosu\bin\Release\*\osu.Game.Rulesets.Cytosu.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_diva = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating osu-DIVA ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Diva.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\osu-DIVA\osu.Game.Rulesets.Diva\bin\Release\*\osu.Game.Rulesets.Diva.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_gamebosu = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Gamebosu ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Gamebosu.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\gamebosu\osu.Game.Rulesets.Gamebosu\bin\Release\*\osu.Game.Rulesets.Gamebosu.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_hishigata = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Hishigata ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Hishigata.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\hishigata\osu.Game.Rulesets.Hishigata\bin\Release\*\osu.Game.Rulesets.Hishigata.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_mvis = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Mvis ====-" ;		
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Mvis.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\lazer-m-vis\osu.Game.Rulesets.Mvis\bin\Release\*\osu.Game.Rulesets.Mvis.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_rush = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Rush ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Rush.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\rush\osu.Game.Rulesets.Rush\bin\Release\*\osu.Game.Rulesets.Rush.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_sentakki = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Sentakki ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Sentakki.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\sentakki\osu.Game.Rulesets.Sentakki\bin\Release\*\osu.Game.Rulesets.Sentakki.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_tau = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Tau ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Tau.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\tau\osu.Game.Rulesets.Tau\bin\Release\*\osu.Game.Rulesets.Tau.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

if ($updater_swing = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Swing ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Swing.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\lazer-swing\osu.Game.Rulesets.Swing\bin\Release\*\osu.Game.Rulesets.Swing.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}
	
if ($updater_soyokaze = "Already up to date.") {
	continue ;
}
	else {
		echo "-==== Updating Soyokaze ====-" ;
		echo "Making a backup of the ruleset..."
			mv ..\rulesets\osu.Game.Rulesets.Soyokaze.dll .\Backup -force ;
		echo "Compiling ruleset" ;
			dotnet publish -c Release --nologo --verbosity quiet ;
		echo "Moving updated dll to Rulesets folder" ;
			mv ".\soyokaze\osu.Game.Rulesets.Soyokaze\bin\Release\*\osu.Game.Rulesets.Soyokaze.dll" ..\rulesets\ -force ;
		echo "Ruleset updated." ;
		echo " " ;
		Start-Sleep -s 2 ;
		continue ;
}

"" > $updater_bosu ;
"" > $updater_cytosu ;
"" > $updater_diva ;
"" > $updater_hishigata ;
"" > $updater_gamebosu ;
"" > $updater_mvis ;
"" > $updater_rush ;
"" > $updater_sentakki ;
"" > $updater_swing ;
"" > $updater_tau ;
"" > $updater_soyokaze ;
	
echo "Finished updating rulesets, Exiting.";
Start-Sleep -s 5
	
<# Backup
echo "-==== Updating FlashVoltex ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd FlashVoltex ;
echo "Checking for Updates" ;
	git pull --recurse-submodules -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.FlashVoltex\bin\Release\*\osu.Game.Rulesets.FlashVoltex.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;
#>
<#
echo "-==== Updating Hitokori ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd Hitokori ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\Hitokori\bin\Release\*\osu.Game.Rulesets.Hitokori.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;
#>
<#
echo "-==== Updating Solosu ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd Solosu ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Solosu\bin\Release\*\osu.Game.Rulesets.Solosu.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;
#>
<# echo "-==== Updating Theater ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd theater-osu ;
echo "Checking for Updates" ;
	git pull --recurse-submodules -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Theater\bin\Release\*\osu.Game.Rulesets.Theater.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
	cd .. ;
echo " " ;
	Start-Sleep -s 2 ;
#>