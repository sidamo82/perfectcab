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
# - Name: conf_kega.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Script for configure Kega Fusion under PerfectCab enviroment
#								    
# - Usage:							    
#								    
# symply run it: ./conf_kega.sh				    
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
echo "---- INSTALL SUPERMODEL3"

sudo apt-get install build-essential libsdl1.2-dev libglew1.5-dev zlib1g-dev
cd /usr/local/src
mkdir supermodel3
cd /usr/local/src/supermodel3
wget https://www.supermodel3.com/Files/Supermodel_0.2a_Src.zip
wget http://www.supermodel3.com/Files/Supermodel_0.1.2a_Src.zip
unzip Supermodel_0.1.2a_Src.zip
cd Supermodel_0.1.2a_Src/
ln -s Makefiles/Makefile.SDL.UNIX.GCC Makefile
make clean
make

#echo $PASSWORD | sudo -S dpkg --add-architecture i386

