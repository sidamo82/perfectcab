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
# - Name: conf_bsnes.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Script for configure BSNES under PerfectCab enviroment
#								    
# - Usage:							    
#								    
# symply run it: ./conf_bsnes.sh				    
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

sudo apt-get install build-essential libgtk2.0-dev libsdl1.2-dev libopenal-dev libasound-dev libao-dev libxv-dev
sudo apt-get install build-essential libgtk2.0-dev libpulse-dev mesa-common-dev libgtksourceview2.0-dev libcairo2-dev libsdl1.2-dev libxv-dev libao-dev libopenal-dev libudev-dev
git clone https://github.com/byuu/bsnes.git
cd bsnes/
git checkout tags/v115
cd bsnes/
make bsnes
# Install Daphne
echo "---- INSTALL KEGA"
echo $PASSWORD | sudo -S dpkg --add-architecture i386
echo $PASSWORD | sudo -S sudo apt-get update
echo $PASSWORD | sudo -S sudo apt -y install libglu1-mesa:i386 libsm6:i386 libgtk2.0-0:i386 libasound2:i386 libasound2-plugins:i386 libmpg123-0:i386 gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386
cd /usr/local/src/perfectcab/software
echo $PASSWORD | sudo -S sudo dpkg -i kega-fusion_3.63-2_i386.deb


