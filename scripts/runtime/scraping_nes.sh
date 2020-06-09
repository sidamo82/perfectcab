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
# - Name: scraping_nes.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to scrape nes games                     
#								    
#####################################################################

/usr/local/bin/Skyscraper -p nes -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/nes -s screenscraper --flags unattend,skipped,unpack,videos
/usr/local/bin/Skyscraper -p nes -a /usr/local/etc/skyscraper/artwork.xml -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/nes -g /media/perfectcab/skyscraper/nes -f attractmode -e /usr/local/share/attract/attract.cfg --flags unattend,skipped,nobrackets,videos
/bin/sed 's/attract/Nintendo\ Entertainment\ System/g' /media/perfectcab/skyscraper/nes/attract.txt > /usr/local/share/attract/romlists/Nintendo\ Entertainment\ System.txt
