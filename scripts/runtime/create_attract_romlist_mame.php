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
# - Name: create_attract_romlist_mame.php			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Create "AttractMode" gamelist from mame roms installed (neogeo excluded)
#								    
#####################################################################

#Name;Title;Emulator;CloneOf;Year;Manufacturer;Category;Players;Rotation;Control;Status;DisplayCount;DisplayType;AltRomname;AltTitle;Extra;Buttons

if($argc<3) {
	die("\nparam1: rompath - param2: mame.db path - param3 (optional):'enablemature'/'full-list'");
}

$bFullDB = false;
$sScanOption = '';
$sRomPath = rtrim($argv[1], '/');
$sPathDB = $argv[2];

if(isset($argv[3])){
	$sScanOption = $argv[3];
}


$aArrayHeader = array(
		"#Name",
		"Title",
		"Emulator",
		"CloneOf",
		"Year",
		"Rating",
		"Manufacturer",
		"Category",
		"Players",
		"Rotation",
		"Control",
		"Status",
		"DisplayCount",
		"DisplayType",
		"Resolution",
		"AltRomname",
		"AltTitle",
		"Extra",
		"DriverStatus",
		"DriverEmulation",
		"DriverColor",
		"DriverSound",
		"DriverGraphic"
);

$sString = implode($aArrayHeader, ';');
echo $sString."\n";

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

	if($sScanOption=='full-list') {
		$sql = "SELECT * 
			FROM mameroms
			ORDER BY description
			";
	}
	else {
		$genreexclusion = '';

		if($sScanOption=='enablemature'){
			$genreexclusion = ' genre NOT IN(\'Fruit Machines\', \'Mahjong\', \'Mini-Games\',\'Quiz\') ';
		}
		else {
			$genreexclusion = ' genre NOT IN(\'Fruit Machines\', \'Mahjong\', \'Mini-Games\',\'Quiz\', \'Mature\') ';
		}

		$sql = "SELECT * 
				FROM mameroms 
			WHERE
			isneogeo='no'		
			AND
			".$genreexclusion."
			AND driver_status NOT IN ('preliminary')
			AND ismechanical='no'
			AND isdevice='no'
			AND isbios='no'
			AND runnable='yes'
			ORDER BY description
			";
	}

	foreach($file_db->query($sql) as $row){

		/* Check if rom exist in your romset */
		$bRomExist = false;

		if(file_exists($sRomPath.'/'.trim($row['name']).'.zip')){
			$bRomExist = true;
		}
		
		if(file_exists($sRomPath.'/'.trim($row['name']).'.7z')){
			$bRomExist = true;
		}

		if($bRomExist){

			$aArrayRecord = array(
						$row['name'],
						$row['description'],
						"Mame",
						$row['cloneof'],
						$row['year'],
						"",
						$row['manufacturer'],
						$row['genre'],
						$row['input_players'],
						$row['display_rotate'],
						$row['input_buttons'],
						"",
						"",
						$row['display_type'],
						$row['display_width'].'x'.$row['display_height'],
						"",
						"",
						"",
						$row['driver_status'],
						$row['driver_emulation'],
						$row['driver_color'],
						$row['driver_sound'],
						$row['driver_graphic']
					);

				$sString = implode($aArrayRecord, ';');
				echo $sString."\n";
		}
	}
} catch(PDOException $e) {
	// Print PDOException message
	echo $e->getMessage();
}

/**************************************
 * Close db connections                *
 **************************************/

// Close file db connection
$file_db = null;

?>
