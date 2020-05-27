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
# - Name: scraping_daphne.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to scrape daphne games                     
#								    
#####################################################################

/usr/local/bin/Skyscraper -p daphne -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/daphne -s arcadedb --cache refresh --flags unattend,skipped,unpack,videos
/usr/local/bin/Skyscraper -p daphne -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/daphne -s screenscraper --cache refresh --flags unattend,skipped,unpack,videos
/usr/local/bin/Skyscraper -p daphne -a /usr/local/etc/skyscraper/artwork.xml -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/daphne -g /media/perfectcab/skyscraper/daphne -f attractmode -e /usr/local/share/attract/attract.cfg --flags unattend,skipped,nobrackets,videos
/bin/sed 's/attract/Daphne/g' /media/perfectcab/skyscraper/daphne/attract.txt > /usr/local/share/attract/romlists/Daphne.txt
