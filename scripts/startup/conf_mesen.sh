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
# - Name: conf_mesen.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Script for configure MESEN under PerfectCab enviroment
#								    
# - Usage:							    
#								    
# symply run it: ./conf_mesen.sh				    
#								    
#####################################################################

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

# Install Requirements
echo $PASSWORD | sudo -S apt -y install libsdl2-2.0 gnome-themes-standard

# Install Mono
echo $PASSWORD | sudo -S apt -y install gnupg ca-certificates
echo $PASSWORD | sudo -S apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo $PASSWORD | sudo -S cp /usr/local/src/perfectcab/conf/mesen/mono-official-stable.list /etc/apt/sources.list.d/
echo $PASSWORD | sudo -S apt update
echo $PASSWORD | sudo -S apt -y install mono-complete

# Install MESEN
echo "---- INSTALL MESEN"
cd /tmp
echo $PASSWORD | sudo -S wget https://www.mesen.ca/download.php
echo $PASSWORD | sudo -S mv /tmp/download.php /tmp/Mesen.zip
echo $PASSWORD | sudo -S unzip /tmp/Mesen.zip
echo $PASSWORD | sudo -S mv /tmp/Mesen.exe /usr/games/
echo $PASSWORD | sudo -S chmod ugo+x /usr/games/Mesen.exe


