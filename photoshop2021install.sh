#!/bin/bash

#Photoshop 2021 on Linux through wine by yuichi.
#Everything is "pre-setup" so u just gotta run this .sh as root
#I removed the DRM bc its running a cracked version originally for windows (ew), so u don't gotta pay for it, but it does mean you can't login.
#To run the program after installing, run the /Adobe-Photoshop/drive_c/launcher.sh
#DONT STEAL MY SHIT YOU CUNTS
#Also hello linux weaboos
#I made this for debian/ubuntu so idk if Arch or others work

read -p $'You have to have wine64 installed, check online how to do so.\nIf you don\'t have wine64 then this script WILL NOT WORK [PLEASE CHECK BEFORE YOU MAKE AN ISSUE ON THE GITHUB]\nDo you understand?? (press y to continue)' -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

mkdir $1/Adobe-Photoshop

wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks

WINEPREFIX=$1/Adobe-Photoshop wineboot

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "10" >> $1/progress.mimifile

WINEPREFIX=$1/Adobe-Photoshop ./winetricks win10

curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/allredist.tar.xz" > allredist.tar.xz
mkdir allredist

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "20" >> $1/progress.mimifile

tar -xf allredist.tar.xz
rm -rf allredist.tar.xz

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "25" >> $1/progress.mimifile

curl -L "https://lulucloud.mywire.org/FileHosting/GithubProjects/AdobePhotoshop2021.tar.xz" > AdobePhotoshop2021.tar.xz

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "50" >> $1/progress.mimifile

tar -xf AdobePhotoshop2021.tar.xz
rm -rf AdobePhotoshop2021.tar.xz


rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "70" >> $1/progress.mimifile


WINEPREFIX=$1/Adobe-Photoshop ./winetricks fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk win10 vkd3d

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "80" >> $1/progress.mimifile


WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2010/vcredist_x64.exe /q /norestart
WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2010/vcredist_x86.exe /q /norestart

WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2012/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2012/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2013/vcredist_x86.exe /install /quiet /norestart
WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2013/vcredist_x64.exe /install /quiet /norestart

WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2019/VC_redist.x64.exe /install /quiet /norestart
WINEPREFIX=$1/Adobe-Photoshop wine allredist/redist/2019/VC_redist.x86.exe /install /quiet /norestart


rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "90" >> $1/progress.mimifile


mkdir $1/Adobe-Photoshop/drive_c/Program\ Files/Adobe
mv Adobe\ Photoshop\ 2021 $1/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021

touch $1/Adobe-Photoshop/drive_c/launcher.sh
echo '#!/usr/bin/env bash' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'SCR_PATH="pspath"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'CACHE_PATH="pscache"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'RESOURCES_PATH="$SCR_PATH/resources"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'WINE_PREFIX="$SCR_PATH/prefix"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'FILE_PATH=$(winepath -w "$1")' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'export WINEPREFIX="'$1'/Adobe-Photoshop"' >> $1/Adobe-Photoshop/drive_c/launcher.sh
echo 'WINEPREFIX='$1'/Adobe-Photoshop DXVK_LOG_PATH='$1'/Adobe-Photoshop DXVK_STATE_CACHE_PATH='$1'/Adobe-Photoshop wine64 ' $1'/Adobe-Photoshop/drive_c/Program\ Files/Adobe/Adobe\ Photoshop\ 2021/photoshop.exe $FILE_PATH' >> $1/Adobe-Photoshop/drive_c/launcher.sh

chmod +x $1/Adobe-Photoshop/drive_c/launcher.sh

WINEPREFIX=$1/Adobe-Photoshop winecfg -v win10


mv allredist/photoshop.png ~/.local/share/icons/photoshop.png


touch ~/.local/share/applications/photoshop.desktop
echo '[Desktop Entry]' >> ~/.local/share/applications/photoshop.desktop
echo 'Name=Photoshop CC 2021' >> ~/.local/share/applications/photoshop.desktop
echo 'Exec=bash -c "'$1'/Adobe-Photoshop/drive_c/launcher.sh %F"' >> ~/.local/share/applications/photoshop.desktop
echo 'Type=Application' >> ~/.local/share/applications/photoshop.desktop
echo 'Comment=Photoshop CC 2021 (Wine)' >> ~/.local/share/applications/photoshop.desktop
echo 'Categories=Graphics;' >> ~/.local/share/applications/photoshop.desktop
echo 'Icon=photoshop' >> ~/.local/share/applications/photoshop.desktop
echo 'StartupWMClass=photoshop.exe' >> ~/.local/share/applications/photoshop.desktop

rm -rf allredist
rm -rf winetricks

rm -rf $1/progress.mimifile
touch $1/progress.mimifile
echo "100" >> $1/progress.mimifile

sudo wget https://github.com/Jan64X/photoshop4linux/blob/main/setup.sh
./setup.sh
