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
# - Name: kill_emu.php			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to force closing of Emulators
#								    
#####################################################################

# Kill Kega Fusion
/usr/bin/killall Fusion
# Kill Kega bsnes
/usr/bin/killall bsnes
# Kill mame
/usr/bin/killall -9 mame
# Kill Mesen
/usr/bin/killall -9 cli
