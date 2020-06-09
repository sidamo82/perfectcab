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
# - Name: scraping_sms.sh			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Command to scrape sms games                     
#								    
#####################################################################

/usr/local/bin/Skyscraper -p mastersystem -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/sms -s screenscraper --flags unattend,skipped,unpack,videos
/usr/local/bin/Skyscraper -p mastersystem -a /usr/local/etc/skyscraper/artwork.xml -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/sms -g /media/perfectcab/skyscraper/sms -f attractmode -e /usr/local/share/attract/attract.cfg --flags unattend,skipped,nobrackets,videos
/bin/sed 's/attract/Sega\ Master\ System/g' /media/perfectcab/skyscraper/sms/attract.txt > /usr/local/share/attract/romlists/Sega\ Master\ System.txt
