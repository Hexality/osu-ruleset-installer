# Yes, while this has all capacity to work on every single computer, it isn't what actually happens so keep in mind, if it doesn't work on your computer, please leave a issue showing the error so this way I can help fixing this messy shit of code that I made.

## Welcome to my codegore, here you'll have a shit coded but working installer and updater for all rulesets mentioned bellow.
## Instructions, please read carefully.

_Warn: some people may have problems with .NET and GIT enviroments, If that happens, pls run the script as Admin._

## **Installer and Updater**
> **1. Create a folder called ruleset_updater inside %appdata%\osu!lazer (Windows)**

> **2. Move the 5 files to that folder.**
>> _Remember to download the right version that you want to use, the main is the `Ruleset Installer/Updater [Build]`. If you want to see the build output, specify `-v on` after `-mode dev` in the Ruleset Updater shortcut to show logs._
>> ~~_Please note that the `Ruleset Installer/Updater [Downloader]` is only used if you don't want to build the rulesets but still want to have them updated (its incompatible with the build version.)_~~ Downloader not working yet, please follow the build instructions until I finish it.

> **3. Download and Install [.NET SDK](https://dotnet.microsoft.com/download) and [Git](https://git-scm.com/downloads)**

> **4. Specify your git account by setting you username and email:**
>> `git config --global user.name [your username]`

>> `git config --global user.email [your email]`

> **5. Run the .bat to set the execution policy to RemoteSigned and allow ps1 script to be run.**
>> _or run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned on Powershell [Admin]`_

> **6. Double-click the "Ruleset Installer" shortcut if it's your first time using the script.**

> **7. Use the Update shortcut when its needed.**

>> **You can delete the .bat after using it for the first time if u want :D**


### A list of osu!lazer rulesets: (Included on the script) [Dashed = borked]


> [Bosu](https://github.com/EVAST9919/bosu) ([EV4ST](https://github.com/EVAST9919)) - `git clone --recurse-submodules https://github.com/EVAST9919/bosu`

~~> [Cytosu]() ([GSculerlor](https://github.com/GSculerlor)) - `git clone --recurse-submodules https://github.com/GSculerlor/Cytosu`~~
>> [Cytosu](https://github.com/GSculerlor/Cytosu/tree/dev-rework) ([GSculerlor](https://github.com/GSculerlor)) [Rework] - `git clone --recurse-submodules --branch dev-rework https://github.com/GSculerlor/Cytosu`

> ~~[FlashVoltex](https://github.com/stupefaction02/FlashVoltex) ([StupeFaction](https://github.com/stupefaction02)) - `git clone --recurse-submodules https://github.com/stupefaction02/FlashVoltex`~~ (osu! update killed it, I'll leave it disabled here for now)

> [Gamebosu](https://github.com/Game4all/gamebosu) ([Game4all](https://github.com/Game4all)) - `git clone --recurse-submodules https://github.com/Game4all/gamebosu`

> ~~[osu!Guitar](https://github.com/klaviotarka/osu-gita) ([klaviotarka](https://github.com/klaviotarka)) - `git clone --recurse-submodules https://github.com/klaviotarka/osu-gita`~~

> [Hashigata](https://github.com/LumpBloom7/hishigata) ([LumpBloom7](https://github.com/LumpBloom7)) - `git clone --recurse-submodules https://github.com/LumpBloom7/hishigata`

> [Hitokori](https://github.com/Flutterish/Hitokori) ([Flutterish](https://github.com/Flutterish)) - `git clone --recurse-submodules https://github.com/Flutterish/Hitokori`

> [Karaoke](https://github.com/karaoke-dev/karaoke) ([Karaoke-dev](https://github.com/karaoke-dev)) - `git clone --recurse-submodules https://github.com/karaoke-dev/karaoke`

> [osu!lazer Music Visualizer](https://github.com/EVAST9919/lazer-m-vis) ([EV4ST](https://github.com/EVAST9919)) - `git clone --recurse-submodules https://github.com/EVAST9919/lazer-m-vis`

> [Swing](https://github.com/EVAST9919/lazer-swing) ([EV4ST](https://github.com/EVAST9919)) - `git clone --recurse-submodules https://github.com/EVAST9919/lazer-swing`

> [osu!lazer Project DIVA](https://github.com/Artemis-chan/osu-DIVA) ([Artemis](https://github.com/Artemis-chan)) - `git clone --recurse-submodules https://github.com/Artemis-chan/osu-DIVA`

> [Rush](https://github.com/swoolcock/rush) ([Swoolcock](https://github.com/swoolcock)) - `git clone --recurse-submodules https://github.com/swoolcock/rush`

> [Sentakki](https://github.com/LumpBloom7/sentakki) ([LumpBloom7](https://github.com/LumpBloom7)) - `git clone --recurse-submodules https://github.com/LumpBloom7/sentakki`

> ~~[Solosu](https://github.com/Coppertine/Solosu) ([Coppertine](https://github.com/Coppertine)) - `git clone --recurse-submodules https://github.com/Coppertine/Solosu`~~ (Still not working)
 
> [Soyokaze](https://github.com/goodtrailer/soyokaze) ([goodtrailer](https://github.com/goodtrailer)) - `git clone --recurse-submodules https://github.com/goodtrailer/soyokaze`

> [Tau](https://github.com/Altenhh/tau) ([Altenhh](https://github.com/Altenhh)) - `git clone --recurse-submodules https://github.com/Altenhh/tau`

> ~~[Theater](https://github.com/bdjeffyp/theater-osu) ([bdjeffyp](https://github.com/bdjeffyp)) - `git clone --recurse-submodules https://github.com/bdjeffyp/theater-osu`~~ (Still not working)

# old downloader version of this script here:
> [Ruleset Installer (Downloader) [Archived]](https://github.com/Hexality/osu-ruleset-installer)
