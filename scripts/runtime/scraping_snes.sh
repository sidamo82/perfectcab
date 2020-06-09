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
# - Name: scraping_snes.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to scrape snes games                     
#								    
#####################################################################

/usr/local/bin/Skyscraper -p snes -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/snes -s screenscraper --flags unattend,skipped,unpack,videos
/usr/local/bin/Skyscraper -p snes -a /usr/local/etc/skyscraper/artwork.xml -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/snes -g /media/perfectcab/skyscraper/snes -f attractmode -e /usr/local/share/attract/attract.cfg --flags unattend,skipped,nobrackets,videos
/bin/sed 's/attract/Super\ Nintendo\ Entertainment\ System/g' /media/perfectcab/skyscraper/snes/attract.txt > /usr/local/share/attract/romlists/Super\ Nintendo\ Entertainment\ System.txt
