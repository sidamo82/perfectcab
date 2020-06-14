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
# - Name: scraping_mame.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to start genesis Kega Fusion games                     
#								    
#####################################################################

input=$1

cp /home/user/.Kega\ Fusion/Fusion.smd.ini Fusion.ini

export DISPLAY=:0

# Get VideoCard name
VIDEOCARDNAME=`xrandr | grep -w connected | /usr/bin/awk '{print $1}'`

# Switch Res
echo "xrandr --output $VIDEOCARDNAME --mode 320x240" &> /tmp/kega_fusion_genesis_debug.txt
xrandr --output $VIDEOCARDNAME --mode 320x240 &>> /tmp/kega_fusion_genesis_debug.txt

# Change volume
#/usr/bin/amixer set Master 70%  &>> /tmp/kega_fusion_genesis_debug.txt
 

# Start Game
echo "/usr/games/kega-fusion -fullscreen \"${input}\"" &>> /tmp/kega_fusion_genesis_debug.txt
/usr/games/kega-fusion -fullscreen "${input}" &>> /tmp/kega_fusion_genesis_debug.txt
	

#/usr/bin/amixer set Master 100% &>> /tmp/kega_fusion_genesis_debug.txt
 
# Switch Res to Attract Mode
echo "xrandr --output $VIDEOCARD --mode 640x480" &>> /tmp/kega_fusion_genesis_debug.txt
xrandr --output $VIDEOCARD --mode 640x480 &>> /tmp/kega_fusion_genesis_debug.txt




