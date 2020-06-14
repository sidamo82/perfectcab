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
# - Name: scraping_32x.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to scrape 32x games                     
#								    
#####################################################################

/usr/local/bin/Skyscraper -p sega32x -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/32x -s screenscraper --flags unattend,skipped,unpack,videos
/usr/local/bin/Skyscraper -p sega32x -a /usr/local/etc/skyscraper/artwork.xml -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/32x -g /media/perfectcab/skyscraper/32x -f attractmode -e /usr/local/share/attract/attract.cfg --flags unattend,skipped,nobrackets,videos
/bin/sed 's/attract/32x/g' /media/perfectcab/skyscraper/32x/attract.txt > /usr/local/share/attract/romlists/32x.txt
