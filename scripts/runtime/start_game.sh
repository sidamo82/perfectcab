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
#  Command to start mame games with resolution autoswitch
#								    
#####################################################################

export DISPLAY=:0

VIDEOCARDNAME=`xrandr | grep -w connected | /usr/bin/awk '{print $1}'`

/usr/bin/php /usr/local/bin/start_game.php $VIDEOCARDNAME $1 &> /tmp/mame_debug.txt