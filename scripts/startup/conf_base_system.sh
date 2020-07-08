#!/bin/bash
#####################################################################
#
# ______          __          _   _____       _     
# | ___ \        / _|        | | /  __ \     | |    
# | |_/ /__ _ __| |_ ___  ___| |_| /  \/ __ _| |__  
# |  __/ _ \ '__|  _/ _ \/ __| __| |    / _` | '_ \ 
# | | |  __/ |  | ||  __/ (__| |_| \__/\ (_| | |_) |
# \_|  \___|_|  |_| \___|\___|\__|\____/\__,_|_.__/ 
#								    
#								    
# - Author: Nicola Damonti			                    
# - Name: conf_base_system.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Script for configure PerfectCab enviroment
#								    
# - Usage:							    
#								    
# symply run it: ./conf_base_system.sh				    
#								    
#####################################################################

# SHASUM FOR COSMO THEMES CHECK
SHASUM1="d9eb762824f8a187496c88966ef757099dc5e72e"
SHASUM2="6044e5569cd7e4a8bea441eb1f84ba428b345b90"
CHECKCOSMODOWNLOAD=false

### INSERT SUDO PASSWORD
export HISTIGNORE='*sudo -S*'
echo "Insert your password: ";
read -s PASSWORD

if echo $PASSWORD | sudo -k -S true 2>/dev/null; then
    echo "I got sudo"
else
    echo "WRONG PASSWORD: please retry"
    exit 1;
fi

# Install prerequirements
echo "---- INSTALL ALL REQUIREMENTS"
echo $PASSWORD | sudo -S apt update
echo $PASSWORD | sudo -S apt -y install xorg xterm build-essential git libsfml-dev libopenal-dev libavformat-dev libfontconfig1-dev libfreetype6-dev libswscale-dev libavresample-dev libarchive-dev libjpeg-dev  libglu1-mesa-dev software-properties-common unzip qt5-default libsdl-dev libglew-dev libvorbis-dev libsdl-image1.2-dev libsdl-ttf2.0-dev cmake pkg-config git libao-dev libasound2-dev libavcodec-dev libavformat-dev libbluetooth-dev libenet-dev libgtk2.0-dev liblzo2-dev libminiupnpc-dev libopenal-dev libpulse-dev libreadline-dev libsfml-dev libsoil-dev libsoundtouch-dev libswscale-dev libusb-1.0-0-dev libwxbase3.0-dev libwxgtk3.0-dev libxext-dev  libxrandr-dev portaudio19-dev zlib1g-dev libudev-dev libevdev-dev libmbedtls-dev libcurl4-openssl-dev libegl1-mesa-dev libpng-dev qtbase5-private-dev php-cli php-sqlite3 php-xml p7zip-full ubuntu-drivers-common unrar-free vim cifs-utils libxml2-dev hashrat openbox screen htop xdotool xbindkeys

# Configure directories
echo "---- CONFIGURE DIRECTORIES"
cd /media
echo $PASSWORD | sudo -S mkdir perfectcab
echo $PASSWORD | sudo -S chown user.user perfectcab
cd perfectcab/
mkdir db/ roms/ skyscraper/ bios/
cd roms/
mkdir mame/ sms/ genesis/ 32x/ nes/ snes/ segaarcade/ daphne/
cd ../bios/
mkdir sms/ genesis/ 32x/ nes/ snes/ daphne/

# Install PerfectCab runtime scripts
echo "---- INSTALL PERFECT CAB RUNTIME SCRIPTS"
cd /usr/local/src/perfectcab
echo $PASSWORD | sudo -S chmod +x -R scripts/
echo $PASSWORD | sudo -S cp scripts/runtime/* /usr/local/bin/

# Install PerfectCab Mame DB
echo "---- INSTALL MAMEDB"
cd /usr/local/src/perfectcab
echo $PASSWORD | sudo -S cp db/mame.db /media/perfectcab/db

# Download Cosmo Themes
echo "---- DOWNLOAD COSMO THEMES"
cd /tmp
echo $PASSWORD | sudo -S rm -rf /tmp/*
wget "https://perfectcab.org/packages/cosmo theme v.1.1.rar"
wget "https://perfectcab.org/packages/system snaps.rar"
SHASUMCHECK1=`/usr/bin/shasum /tmp/cosmo\ theme\ v.1.1.rar | /usr/bin/awk '{print $1}'`
SHASUMCHECK2=`/usr/bin/shasum /tmp/system\ snaps.rar | /usr/bin/awk '{print $1}'`

if [ "$SHASUMCHECK1" == "$SHASUM1" ] && [ "$SHASUMCHECK2" == "$SHASUM2" ]
then
	echo "DOWNLOAD OK"
else
	echo "DOWNLOAD KO"
    echo "SCRIPT ERROR: INCORRECT COSMO THEMES DOWNLOAD"
fi



# Install SkyScraper
echo "---- INSTALL SKYSCRAPER"
cd /usr/local/src
echo $PASSWORD | sudo -S rm -rf /usr/local/src/skysource
echo $PASSWORD | sudo -S mkdir skysource
cd skysource
echo $PASSWORD | sudo -S wget -q -O - https://raw.githubusercontent.com/muldjord/skyscraper/master/update_skyscraper.sh | sudo bash
echo $PASSWORD | sudo -S cp /usr/local/src/perfectcab/conf/etc/skyscraper/* /usr/local/etc/skyscraper/

# Install Attract Mode
echo "---- INSTALL ATTRACTMODE"
cd /usr/local/src
echo $PASSWORD | sudo -S rm -rf /usr/local/src/attract
echo $PASSWORD | sudo -S rm -rf /usr/local/share/attract
echo $PASSWORD | sudo -S git clone http://github.com/mickelson/attract attract
cd attract/
echo $PASSWORD | sudo -S make -j $(cat /proc/cpuinfo | grep -c processor)
echo $PASSWORD | sudo -S make install
echo $PASSWORD | sudo -S mkdir /usr/local/share/attract/romlists/
echo $PASSWORD | sudo -S chown -R user.user /usr/local/share/attract/

# Install Cosmo Themes
echo "---- INSTALL COSMO THEMES"
cd /tmp
unrar -x cosmo\ theme\ v.1.1.rar
unrar -x system\ snaps.rar
echo $PASSWORD | sudo -S chmod -R 777 layouts/ menu-art/
cd layouts/
echo $PASSWORD | sudo -S cp -R * /usr/local/share/attract/layouts/
cd ../menu-art/
echo $PASSWORD | sudo -S cp -R snap/ /usr/local/share/attract/menu-art/
cd /usr/local/src/perfectcab/conf/attract-configuration
echo $PASSWORD | sudo -S cp -r attract.* emulators/ intro/ romlists/ screensaver/ layouts/ plugins/ /usr/local/share/attract/
echo $PASSWORD | sudo -S chown -R user.user /usr/local/share/attract/

# Install Mame
echo "---- INSTALL MAME"
echo $PASSWORD | sudo -S add-apt-repository ppa:c.falco/mame -y
echo $PASSWORD | sudo -S apt-get update
echo $PASSWORD | sudo -S apt-get -y install mame
cd /usr/local/src/perfectcab
echo $PASSWORD | sudo -S cp -f conf/mame/mame.ini /etc/mame/
echo $PASSWORD | sudo -S cp -f conf/mame/uismall.bdf /etc/mame/

# Install lrmc
echo "---- INSTALL LRMC"
echo $PASSWORD | sudo chown -R user.user /usr/local/src/perfectcab/software
tar -C /usr/local/src/perfectcab/software -xzvf /usr/local/src/perfectcab/software/lrmc-0.9.2.tar.gz
cd /usr/local/src/perfectcab/software/lrmc-0.9.2
./configure --prefix=/usr/local
/usr/bin/make -C /usr/local/src/perfectcab/software/lrmc-0.9.2
echo $PASSWORD | sudo -S /usr/bin/make -C /usr/local/src/perfectcab/software/lrmc-0.9.2 install
echo $PASSWORD | sudo -S rm -rf /usr/local/src/perfectcab/software/lrmc-0.9.2/

# Copy StartUp scripts
echo "---- COPY STARTUP SCRIPTS"
cd /usr/local/src/perfectcab/conf
echo $PASSWORD | sudo -S chmod +x rc.local
echo $PASSWORD | sudo -S rm -f /etc/rc.local
echo $PASSWORD | sudo -S cp rc.local /etc/rc.local
echo $PASSWORD | sudo -S rm -f /usr/local/etc/xinitrc
echo $PASSWORD | sudo -S cp xinitrc_step1 /usr/local/etc/xinitrc
echo $PASSWORD | sudo -S chown user.user /usr/local/etc/xinitrc
echo $PASSWORD | sudo -S cp -f openbox/autostart /etc/xdg/openbox
echo $PASSWORD | sudo -S cp -f openbox/rc.xml /etc/xdg/openbox
echo $PASSWORD | sudo -S cp -f xbindkey/xbindkeysrc /usr/local/etc

echo "---- COPY SAMBA CREDENTIALS FILE"
cd /usr/local/src/perfectcab/conf/etc/samba
echo $PASSWORD | sudo -S cp -f credentials.txt /etc/samba
echo $PASSWORD | sudo -S chown user.user /etc/samba/credentials.txt

echo "---- FINISH"