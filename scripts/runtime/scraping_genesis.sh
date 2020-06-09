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
# - Name: scraping_genesis.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to scrape genesis games                     
#								    
#####################################################################

/usr/local/bin/Skyscraper -p genesis -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/genesis -s screenscraper --flags unattend,skipped,unpack,videos
/usr/local/bin/Skyscraper -p genesis -a /usr/local/etc/skyscraper/artwork.xml -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/genesis -g /media/perfectcab/skyscraper/genesis -f attractmode -e /usr/local/share/attract/attract.cfg --flags unattend,skipped,nobrackets,videos
/bin/sed 's/attract/Sega\ Genesis/g' /media/perfectcab/skyscraper/genesis/attract.txt > /usr/local/share/attract/romlists/Sega\ Genesis.txt
