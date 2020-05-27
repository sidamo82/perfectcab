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
#  Command to scrape mame games                     
#								    
#####################################################################

/usr/local/bin/Skyscraper -p mame-mame4all -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/mame -s arcadedb --cache refresh --flags unattend,skipped,unpack,videos
/usr/local/bin/Skyscraper -p mame-mame4all -a /usr/local/etc/skyscraper/artwork.xml -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/mame -g /media/perfectcab/skyscraper/mame -f attractmode -e /usr/local/share/attract/attract.cfg --flags unattend,skipped,nobrackets,videos
#/bin/sed 's/attract/Mame/g' /media/perfectcab/skyscraper/mame/attract.txt > /usr/local/share/attract/romlists/Mame.txt
/usr/local/bin/Skyscraper -p mame-mame4all -a /usr/local/etc/skyscraper/artwork.xml -c /usr/local/etc/skyscraper/config.ini -i /media/perfectcab/roms/mame -g /media/perfectcab/skyscraper/mame -f attractmode -e /usr/local/share/attract/attract.cfg --flags unattend,skipped,nobrackets,videos
/usr/bin/php create_attract_romlist_mame.php /media/perfectcab/roms/mame /media/perfectcab/db/mame.db > /usr/local/share/attract/romlists/Mame.txt
/usr/bin/php create_attract_romlist_neogeo.php /media/perfectcab/roms/mame /media/perfectcab/db/mame.db > /usr/local/share/attract/romlists/Neo\ Geo\ MVS.txt