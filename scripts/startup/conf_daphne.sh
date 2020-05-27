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
# - Name: conf_daphne.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Script for configure daphne under PerfectCab enviroment
#								    
# - Usage:							    
#								    
# symply run it: ./conf_daphne.sh				    
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

# Install Daphne
echo "---- INSTALL DAPHNE"
cd /usr/local/src
echo $PASSWORD | sudo -S git clone https://github.com/DavidGriffith/daphne
cd daphne/src/vldp2
echo $PASSWORD | sudo -S ./configure --disable-accel-detect
echo $PASSWORD | sudo -S make -f Makefile.linux_x64
cd ../game/singe
echo $PASSWORD | sudo -S make -f Makefile.linux_x64
cd ../..
echo $PASSWORD | sudo -S ln -s Makefile.vars.linux_x64 Makefile.vars
echo $PASSWORD | sudo -S make
echo $PASSWORD | sudo -S cp ../daphne.bin /usr/games/daphne
echo $PASSWORD | sudo -S cp -r ../pics /media/perfectcab/roms/daphne
echo $PASSWORD | sudo -S cp -r ../sound /media/perfectcab/roms/daphne
echo $PASSWORD | sudo -S mkdir /media/perfectcab/roms/daphne/roms
echo $PASSWORD | sudo -S mkdir /media/perfectcab/roms/daphne/framefile
echo $PASSWORD | sudo -S mkdir /media/perfectcab/roms/daphne/mpeg2
echo $PASSWORD | sudo -S chown -R user.user /media/perfectcab/roms/daphne