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
#  Command to start sms Kega Fusion games                     
#								    
#####################################################################

input=$1;

echo $input;

xrandr --output VGA-0 --mode 320x240

cp /home/user/.Kega\ Fusion/Fusion.sms.ini Fusion.ini

/usr/bin/amixer set Master 0%

sleep 1

if [ "$input" = "snailmaze" ]; then
	/usr/games/kega-fusion -fullscreen 
else
	/usr/games/kega-fusion -fullscreen "${input}"  
	
fi
/usr/bin/amixer set Master 0%

sleep 1

xrandr --output VGA-0 --mode default

