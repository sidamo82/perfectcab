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
echo "---- INSTALL REDREAM"

cd /usr/local/src
wget https://redream.io/download/redream.x86_64-linux-v1.5.0.tar.gz
tar xzvf redream.x86_64-linux-v1.5.0.tar.gz
cp redream /usr/games/

#echo $PASSWORD | sudo -S dpkg --add-architecture i386

