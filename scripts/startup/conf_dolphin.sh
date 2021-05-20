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


echo $PASSWORD | sudo -S update-alternatives --remove-all gcc
echo $PASSWORD | sudo -S update-alternatives --remove-all g++
echo $PASSWORD | sudo -S update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 1
echo $PASSWORD | sudo -S update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 1


echo $PASSWORD | sudo -S apt install -y --no-install-recommends ca-certificates qtbase5-dev qtbase5-private-dev git cmake make gcc g++ pkg-config libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libxi-dev libxrandr-dev libudev-dev libevdev-dev libsfml-dev libminiupnpc-dev libmbedtls-dev libcurl4-openssl-dev libhidapi-dev libsystemd-dev libbluetooth-dev libasound2-dev libpulse-dev libpugixml-dev libbz2-dev libzstd-dev liblzo2-dev libpng-dev libusb-1.0-0-dev gettext
cd /usr/local/src
echo $PASSWORD | sudo -S git clone https://github.com/dolphin-emu/dolphin.git dolphin-emu
cd dolphin-emu/
echo $PASSWORD | sudo -S git checkout tags/5.0
echo $PASSWORD | sudo -S mkdir Build && cd Build
echo $PASSWORD | sudo -S cmake .. -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7
echo $PASSWORD | sudo -S make