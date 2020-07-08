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
# - Name: start_sms_kega.sh			                    		                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to start sms Kega Fusion games                     
#								    
#####################################################################

export DISPLAY=:0

input=$1

# Start xbindkeys
/usr/bin/xbindkeys -v -f /usr/local/etc/xbindkeysrc &

# Copy Kega Fusion Config
cp /home/user/.Kega\ Fusion/Fusion.sms.ini Fusion.ini

# Switch Res
echo "SWITCHRES: /usr/local/bin/switch_resolution.sh 320 240 60 polo" &> /tmp/kega_fusion_genesis_debug.txt
/usr/local/bin/switch_resolution.sh 320 240 60 polo &>> /tmp/kega_fusion_genesis_debug.txt

# Start Game
if [ "$input" = "snailmaze" ]; then
	/usr/games/kega-fusion -fullscreen 
else
	/usr/games/kega-fusion -fullscreen "${input}"  
	
fi

# kill xbindkeys
/usr/bin/killall -9 xbindkeys

# Switch Res to Attract Mode
echo "SWITCHRES: /usr/local/bin/switch_resolution.sh 640 480 60 polo" &>> /tmp/kega_fusion_genesis_debug.txt
/usr/local/bin/switch_resolution.sh 640 480 60 polo &>> /tmp/kega_fusion_genesis_debug.txt

