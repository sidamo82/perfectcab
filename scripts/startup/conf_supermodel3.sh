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

echo $PASSWORD | sudo -S add-apt-repository -y ppa:jonathonf/gcc-9.0
echo $PASSWORD | sudo -S sudo apt-get -y update
echo $PASSWORD | sudo -S sudo apt-get -y install gcc-9 g++-9
echo $PASSWORD | sudo -S update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 1
echo $PASSWORD | sudo -S update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 1

echo $PASSWORD | sudo -S apt-get install -y build-essential libsdl1.2-dev libglew1.5-dev zlib1g-dev


cd /usr/local/src
echo $PASSWORD | sudo -S git clone https://github.com/DSkywalk/supermodel3-custom.git
cd supermodel3-custom/
echo $PASSWORD | sudo -S ln -s Makefiles/Makefile.UNIX Makefile
echo $PASSWORD | sudo -S make clean
echo $PASSWORD | sudo -S make
cd bin/
echo $PASSWORD | sudo -S cp bin/supermodel /usr/games/