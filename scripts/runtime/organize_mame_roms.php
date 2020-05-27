<?php

$sRomsDirectory='/media/windows/Users/Nicola/Documents/roms/mame/roms';
$sDestinationDirectory='/media/windows/Users/Nicola/Documents/roms/mame/roms/sample';

// Set default timezone
date_default_timezone_set('UTC');

try {
	/**************************************
	 * Create databases and                *
	 * open connections                    *
	 **************************************/

	// Create (connect to) SQLite database in file
	$file_db = new PDO('sqlite:mame.sqlite3');

	// Set errormode to exceptions
	$file_db->setAttribute(PDO::ATTR_ERRMODE, 
			PDO::ERRMODE_EXCEPTION);


	$sql = "SELECT name FROM mameroms WHERE sampleof!=''";


	foreach($file_db->query($sql) as $row){

		$sFileName = "{$row['name']}.zip";
		echo "\n$sFileName";

		$sURLSource = $sRomsDirectory.'/'.$sFileName;
		$sURLDestination = $sDestinationDirectory.'/'.$sFileName;

		$bExist = false;

		if(file_exists($sURLSource)){
			echo "\n$sFileName: Esiste";
			$bExist = true;
		}
		else{
			echo "\n$sFileName: Non Esiste";
		}

		if($bExist){
			rename($sURLSource, $sURLDestination);	
		}
	}
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

?>
