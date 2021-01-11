echo "Closing osu!lazer" ;
echo "If u get an error, it's safe to ignore it if osu! was already closed." ;
	Stop-Process -Name "osu!" -Force ;
	Start-Sleep -s 2 ;

echo "Starting Git" ;
	Start-Sleep -s 2 ;
echo "-==== Downloading bosu ====-" ;
	git clone --recurse-submodules https://github.com/EVAST9919/bosu -q ;
echo " " ;

<#
echo "-==== Downloading Cytosu ====-" ;
	git clone --recurse-submodules https://github.com/GSculerlor/Cytosu -q ;
echo " " ;
#>

echo "-==== Downloading FlashVoltex ====-" ;
	git clone --recurse-submodules https://github.com/stupefaction02/FlashVoltex -q ;
echo " " ;

echo "-==== Downloading Gamebosu ====-" ;
	git clone --recurse-submodules https://github.com/Game4all/gamebosu -q ;
echo " " ;

echo "-==== Downloading Hishigata ====-" ;
	git clone --recurse-submodules https://github.com/LumpBloom7/hishigata -q ;
echo " " ;

<#
echo "-==== Downloading Hitokori ====-" ;
	git clone --recurse-submodules https://github.com/Flutterish/Hitokori -q ;
echo " " ;
#>

echo "-==== Downloading Hitokori ====-" ;
	mkdir Hitokori ;
echo " " ;

<#
echo "-==== Downloading Karaoke ====-" ;
	git clone --recurse-submodules https://github.com/karaoke-dev/karaoke -q ;
echo " " ;
#>

echo "-==== Downloading Hitokori ====-" ;
	mkdir Karaoke ;
echo " " ;

echo "-==== Downloading Mvis ====-" ;
	git clone --recurse-submodules https://github.com/EVAST9919/lazer-m-vis -q ;
echo " " ;

echo "-==== Downloading Swing ====-" ;
	git clone --recurse-submodules https://github.com/EVAST9919/lazer-swing -q ;
echo " " ;

echo "-==== Downloading DIVA ====-" ;
	git clone --recurse-submodules https://github.com/Artemis-chan/osu-DIVA -q ;
echo " " ;

echo "-==== Downloading Rush ====-" ;
	git clone --recurse-submodules https://github.com/swoolcock/rush -q ;
echo " " ;

echo "-==== Downloading Sentakki ====-" ;
	git clone --recurse-submodules https://github.com/LumpBloom7/sentakki -q ;
echo " " ;

<#
echo "-==== Downloading Solosu ====-" ;
	git clone --recurse-submodules https://github.com/Coppertine/Solosu -q ;
echo " " ;
#>

echo "-==== Downloading Tau ====-" ;
	git clone --recurse-submodules https://github.com/Altenhh/tau -q ;
echo " " ;

mkdir Backup ;

    powershell .\update.ps1

echo " " ;
echo "Installation Finished,"
echo "Now you can run the update script by double-clicking the Updater shortcut."
echo "If you want, you can delete the Installer.ps1 and its shortcut."
	Start-Sleep -s 10