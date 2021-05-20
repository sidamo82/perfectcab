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

echo $PASSWORD | sudo -S apt-get install build-essential libgtk2.0-dev libpulse-dev mesa-common-dev libgtksourceview2.0-dev libcairo2-dev libsdl1.2-dev libxv-dev libao-dev libopenal-dev libudev-dev libasound-dev
cd /usr/local/src
echo $PASSWORD | sudo -S git clone https://github.com/byuu/bsnes.git
cd bsnes/
echo $PASSWORD | sudo -S git checkout tags/v115
cd bsnes/
echo $PASSWORD | sudo -S make

