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
# - Name: start_nes.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to start nes games                     
#								    
#####################################################################

export DISPLAY=:0;

input=$1

# Start xbindkeys
/usr/bin/xbindkeys -v -f /usr/local/etc/xbindkeysrc &

# Switch Res
/usr/local/bin/switch_resolution.sh 256 240 60 polo &> /tmp/mesen_debug.txt 

sleep 1;

# Start Game
echo "/usr/games/Mesen.exe \"${input}\" --fullscreen --DoNotSaveSettings --VideoScale=1 --AspectRatio=NoStretching --VerticalSync=true --UseHdPacks=false --IntegerFpsMode=true" &>> /tmp/mesen_debug.txt
/usr/games/Mesen.exe "${input}" --fullscreen --DoNotSaveSettings --VideoScale=1 --AspectRatio=NoStretching --VerticalSync=true --UseHdPacks=false --IntegerFpsMode=true  &>> /tmp/mesen_debug.txt

# kill xbindkeys
/usr/bin/killall -9 xbindkeys

/usr/local/bin/switch_resolution.sh 640 480 60 polo &>> /tmp/mesen_debug.txt
