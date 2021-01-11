echo "Closing osu!lazer" ;
echo "If u get an error, it's safe to ignore it if osu! was already closed."
	Stop-Process -Name "osu!" -Force
	Start-Sleep -s 2
cd Backup ;
echo "Creating a backup"
	mv ..\..\rulesets\* .\ -force ;
echo "Backup finished, Update started."
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating bosu ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd bosu ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Bosu\bin\Release\netcoreapp3.1\osu.Game.Rulesets.Bosu.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Cytosu ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd Cytosu ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet  ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Cytosu\bin\Release\netstandard2.1\osu.Game.Rulesets.Cytosu.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating FlashVoltex ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd FlashVoltex ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.FlashVoltex\bin\Release\netstandard2.1\osu.Game.Rulesets.FlashVoltex.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Gamebosu ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd gamebosu ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Gamebosu\bin\Release\netstandard2.1\osu.Game.Rulesets.Gamebosu.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Hishigata ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd hishigata ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Hishigata\bin\Release\netstandard2.1\osu.Game.Rulesets.Hishigata.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Hitokori ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd Hitokori ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\Hitokori\bin\Release\netstandard2.1\osu.Game.Rulesets.Hitokori.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Karaoke ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd Karaoke ;
echo "Checking for Updates" ;
	Start-Sleep -s 1
echo "Downloading ruleset" ;
	Invoke-WebRequest -Uri https://github.com/karaoke-dev/karaoke/releases/latest/download/osu.Game.Rulesets.Karaoke.dll -OutFile ".\osu.Game.Rulesets.Karaoke.dll" ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Karaoke.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Mvis ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd lazer-m-vis ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Mvis\bin\Release\netcoreapp3.1\osu.Game.Rulesets.Mvis.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Swing ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd lazer-swing ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Swing\bin\Release\netcoreapp3.1\osu.Game.Rulesets.Swing.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating DIVA ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd osu-DIVA ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Diva\bin\Release\netcoreapp3.1\osu.Game.Rulesets.Diva.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Rush ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd rush ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Rush\bin\Release\netstandard2.1\osu.Game.Rulesets.Rush.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Sentakki ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd sentakki ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Sentakki\bin\Release\netstandard2.1\osu.Game.Rulesets.Sentakki.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Solosu ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd Solosu ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Solosu\bin\Release\netstandard2.1\osu.Game.Rulesets.Solosu.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
echo " " ;
	Start-Sleep -s 2 ;

echo "-==== Updating Tau ====-";
	Start-Sleep -s 1 ;
	cd .. ;
	cd tau ;
echo "Checking for Updates" ;
	git pull -q ;
echo "Compiling ruleset" ;
	dotnet publish -c Release --nologo --verbosity quiet ;
echo "Moving updated dll to Rulesets folder" ;
	mv ".\osu.Game.Rulesets.Tau\bin\Release\netstandard2.1\osu.Game.Rulesets.Tau.dll" ..\..\rulesets\ -force ;
echo "Ruleset updated." ;
	cd .. ;
echo " " ;
	Start-Sleep -s 2 ;

echo "Finished updating all rulesets, Exiting.";
	Start-Sleep -s 5