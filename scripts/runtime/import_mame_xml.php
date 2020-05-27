<?php

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
# - Name: import_mame_xml.php			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Import XML mame info into SQL Lite Database  
#  Need 2 files in input:
#  
#  - 1st file: xml extract from mame with command: /usr/games/mame -listxml > output.xml
#  - 2nd file: xml get from site http://r0man0.free.fr which contain genre categories
#                                    				    
# - Usage:							     
#								    
#  Create XML file from mame:					    
#								    
#   /usr/games/mame listxml > output.xml			    
#								    
#   Import XML into SQL Lite DB:				    
#								    
#   php import_mame_xml.php output.xml r0man0.xml mamedb.sqllite		    
#								    
#####################################################################

if($argc<3) {
	die("\specify input xml file and output sqllite database");
}

$sPathXMLMame = $argv[1];
$sPathXMLr0man0 = $argv[2];
$sPathDB = $argv[3];


// Set default timezone
date_default_timezone_set('UTC');

try {
	/**************************************
	 * Create databases and                *
	 * open connections                    *
	 **************************************/

	// Create (connect to) SQLite database in file
	$file_db = new PDO('sqlite:'.$sPathDB);

	// Set errormode to exceptions
	$file_db->setAttribute(PDO::ATTR_ERRMODE, 
			PDO::ERRMODE_EXCEPTION);



	/**************************************
	 * Create tables                       *
	 **************************************/



	// Create table messages
	$file_db->exec("CREATE TABLE IF NOT EXISTS mameroms (
		id INTEGER PRIMARY KEY, 
		   name TEXT,
		   sourcefile TEXT,
		   isbios TEXT,
		   isdevice TEXT,
		   ismechanical TEXT,
		   runnable TEXT,
		   cloneof TEXT,
		   romof TEXT,
		   sampleof TEXT,
		   description TEXT,
		   year TEXT,
		   manufacturer TEXT,
		   genre TEXT,
		   display_tag TEXT,
		   display_type TEXT,
		   display_rotate TEXT,
		   display_width  TEXT,
		   display_height TEXT,
		   display_refresh TEXT,
		   display_pixclock TEXT,
		   display_htotal TEXT,
		   display_hbend TEXT,
		   display_hbstart TEXT,
		   display_vtotal TEXT,
		   display_vbend TEXT,
		   display_vbstart TEXT,
		   input_players TEXT,
		   input_buttons TEXT,
		   input_coins TEXT,
		   driver_status TEXT,
		   driver_emulation TEXT,
		   driver_color TEXT,
		   driver_sound TEXT,
		   driver_graphic TEXT,
		   driver_savestate TEXT,
		   isneogeo TEXT
			   )");

	/* 
	   name
	   sourcefile
	   isbios
	   isdevice
	   ismechanical
	   runnable
	   cloneof
	   romof
	   sampleof
	   description
	   year
	   manufacturer
	   display_tag
	   display_type
	   display_rotate
	   display_width 
	   display_height
	   display_refresh
	   display_pixclock
	   display_htotal
	   display_hbend
	   display_hbstart
	   display_vtotal
	   display_vbend
	   display_vbstart
	   input_players
	   input_buttons
	   input_coins
	   driver_status
	   driver_emulation
	   driver_color
	   driver_sound
	   driver_graphic
	   driver_savestate
	   isneogeo
	 */


	// Prepare INSERT statement to SQLite3 file db
	$insert = "INSERT INTO mameroms (
		name,
		sourcefile,
		isbios,
		isdevice,
		ismechanical,
		runnable,
		cloneof,
		romof,
		sampleof,
		description,
		year,
		manufacturer,
		genre,
		display_tag,
		display_type,
		display_rotate,
		display_width,
		display_height,
		display_refresh,
		display_pixclock,
		display_htotal,
		display_hbend,
		display_hbstart,
		display_vtotal,
		display_vbend,
		display_vbstart,
		input_players,
		input_buttons,
		input_coins,
		driver_status,
		driver_emulation,
		driver_color,
		driver_sound,
		driver_graphic,
		driver_savestate,
		isneogeo
			) 
			VALUES (
					:name,
					:sourcefile,
					:isbios,
					:isdevice,
					:ismechanical,
					:runnable,
					:cloneof,
					:romof,
					:sampleof,
					:description,
					:year,
					:manufacturer,
					:genre,
					:display_tag,
					:display_type,
					:display_rotate,
					:display_width,
					:display_height,
					:display_refresh,
					:display_pixclock,
					:display_htotal,
					:display_hbend,
					:display_hbstart,
					:display_vtotal,
					:display_vbend,
					:display_vbstart,
					:input_players,
					:input_buttons,
					:input_coins,
					:driver_status,
					:driver_emulation,
					:driver_color,
					:driver_sound,
					:driver_graphic,
					:driver_savestate,
					:isneogeo

						)";
	$stmt = $file_db->prepare($insert);

	$name;
	$sourcefile;
	$isbios;
	$isdevice;
	$ismechanical;
	$runnable;
	$cloneof;
	$romof;
	$sampleof;
	$description;
	$year;
	$manufacturer;
	$genre;
	$display_tag;
	$display_type;
	$display_rotate;
	$display_width;
	$display_height;
	$display_refresh;
	$display_pixclock;
	$display_htotal;
	$display_hbend;
	$display_hbstart;
	$display_vtotal;
	$display_vbend;
	$display_vbstart;
	$input_players;
	$input_buttons;
	$input_coins;
	$driver_status;
	$driver_emulation;
	$driver_color;
	$driver_sound;
	$driver_graphic;
	$driver_savestate;
	$isneogeo;

	// Bind parameters to statement variables
	$stmt->bindParam(':name', $name);
	$stmt->bindParam(':sourcefile', $sourcefile);
	$stmt->bindParam(':isbios', $isbios);
	$stmt->bindParam(':isdevice', $isdevice);
	$stmt->bindParam(':ismechanical', $ismechanical);
	$stmt->bindParam(':runnable', $runnable);
	$stmt->bindParam(':cloneof', $cloneof);
	$stmt->bindParam(':romof', $romof);	
	$stmt->bindParam(':sampleof', $sampleof);
	$stmt->bindParam(':description', $description);
	$stmt->bindParam(':year', $year);
	$stmt->bindParam(':manufacturer', $manufacturer);
	$stmt->bindParam(':genre', $genre);
	$stmt->bindParam(':display_tag', $display_tag);
	$stmt->bindParam(':display_type', $display_type);
	$stmt->bindParam(':display_rotate', $display_rotate);
	$stmt->bindParam(':display_width', $display_width);
	$stmt->bindParam(':display_height', $display_height);
	$stmt->bindParam(':display_refresh', $display_refresh);
	$stmt->bindParam(':display_pixclock', $display_pixclock);
	$stmt->bindParam(':display_htotal', $display_htotal);
	$stmt->bindParam(':display_hbend', $display_hbend);
	$stmt->bindParam(':display_hbstart', $display_hbstart);
	$stmt->bindParam(':display_vtotal', $display_vtotal);
	$stmt->bindParam(':display_vbend', $display_vbend);
	$stmt->bindParam(':display_vbstart', $display_vbstart);
	$stmt->bindParam(':input_players', $input_players);
	$stmt->bindParam(':input_buttons', $input_buttons);
	$stmt->bindParam(':input_coins', $input_coins);
	$stmt->bindParam(':driver_status', $driver_status);
	$stmt->bindParam(':driver_emulation', $driver_emulation);
	$stmt->bindParam(':driver_color', $driver_color);
	$stmt->bindParam(':driver_sound', $driver_sound);
	$stmt->bindParam(':driver_graphic', $driver_graphic);
	$stmt->bindParam(':driver_savestate', $driver_savestate);
	$stmt->bindParam(':isneogeo', $isneogeo);


	$reader = new XMLReader;
	$reader->open($sPathXMLMame);
	$i=0;

	while ($reader->read())
	{

		if ($reader->nodeType == XMLReader::ELEMENT && $reader->name == 'machine') {

			$name = $reader->getAttribute('name');
			$sourcefile = $reader->getAttribute('sourcefile');
			$isbios = $reader->getAttribute('isbios');
			$isdevice = $reader->getAttribute('isdevice');
			$ismechanical = $reader->getAttribute('ismechanical');
			$runnable = $reader->getAttribute('runnable');
			$cloneof = $reader->getAttribute('cloneof');
			$romof = $reader->getAttribute('romof');
			$sampleof = $reader->getAttribute('sampleof');
			$genre ="";

			$reader->moveToElement();

			$Foo = new SimpleXMLElement($reader->readOuterXml());

			//echo "\n".print_r($Foo, true);

			$description = (string)$Foo->description;
			$year = (string)$Foo->year;
			$manufacturer = (string)$Foo->manufacturer;

			//echo "\n".print_r($Foo->input, true);
			//die();

			$display_tag = (string)$Foo->display['tag'];
			$display_type = (string)$Foo->display['type'];
			$display_rotate = (string)$Foo->display['rotate'];
			$display_width = (string)$Foo->display['width'];
			$display_height = (string)$Foo->display['height'];
			$display_refresh = (string)$Foo->display['refresh'];
			$display_pixclock = (string)$Foo->display['pixclock'];
			$display_htotal = (string)$Foo->display['htotal'];
			$display_hbend = (string)$Foo->display['hbend'];
			$display_hbstart = (string)$Foo->display['hbstart'];
			$display_vtotal = (string)$Foo->display['vtotal'];
			$display_vbend = (string)$Foo->display['vbend'];
			$display_vbstart = (string)$Foo->display['vbstart'];

			$input_players = (string)$Foo->input['players'];
			$input_buttons = (string)$Foo->input['buttons'];
			$input_coins = (string)$Foo->input['coins'];

			$driver_status = (string)$Foo->driver['status'];
			$driver_emulation = (string)$Foo->driver['emulation'];
			$driver_color = (string)$Foo->driver['color'];
			$driver_sound = (string)$Foo->driver['sound'];
			$driver_graphic = (string)$Foo->driver['graphic'];
			$driver_savestate = (string)$Foo->driver['savestate'];

		
			$isneogeo="no";
		
			foreach($Foo->rom as $aRom){
			
				$sRomName = (string)$aRom['name'];

				if($sRomName == 'sp-e.sp1')
				{			
					$isneogeo="yes";
					break;				
				}	
			}


			// Execute statement
			$stmt->execute();

			//echo "\n".print_r($aGameInfo, true);

			//die();
			$i++;

		}

	}

	$reader->close();

	// Prepare INSERT statement to SQLite3 file db
	$update = "UPDATE mameroms SET genre=:genre
		WHERE name=:name";
	$stmt = $file_db->prepare($update);

	$name;
	$genre;
	
	// Bind parameters to statement variables
	$stmt->bindParam(':name', $name);
	$stmt->bindParam(':genre', $genre);

    $reader = new XMLReader;
    $reader->open($sPathXMLr0man0);
	$i=0;

	while ($reader->read())
	{

        	if ($reader->nodeType == XMLReader::ELEMENT && $reader->name == 'game') {

			$name = $reader->getAttribute('name');
			$genre ="";

			$reader->moveToElement();

			$Foo = new SimpleXMLElement($reader->readOuterXml());

			$genre = (string)$Foo->genre;
			
			// Execute statement
			$stmt->execute();

			$i++;

		}

	}

	$reader->close();

}
catch(PDOException $e) {
	// Print PDOException message
	echo $e->getMessage();
}

/**************************************
 * Close db connections                *
 **************************************/

// Close file db connection
$file_db = null;


echo "\nTotale giochi: ".$i;

?>
