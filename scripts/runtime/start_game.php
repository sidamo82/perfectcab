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
# - Name: start_game.php			                    
# - Release under license: GPLv3	                            
#								    
# - Description: 				                    
#								    
#  Run game on Mame using it own native 15Khz resolution 	    
#  or in "640x480i" as fallback resolution			    
#								    
# - Usage:							    
#								    
# php start_game.php "namerom.zip"				    
#								    
#####################################################################

class StartGame {


	private $sXrandrExe = '/usr/bin/xrandr';
	private $sMameExe = '/usr/games/mame';
	private $sSwitchResExe = '/usr/local/bin/switch_resolution.sh';
	#private $sMameExe = '/usr/local/bin/mame64';

	private $bDebug = 'true';
	private $sVGAName = '';
	private $sMonitorType = '';
	public $sPathGameName = '';
	public $sFileGameName = '';
	public $sGameName = '';


	function __construct($sPathGameName, $sVGAName, $sMonitorType, $bDebug){	

		$this->sPathGameName = $sPathGameName;
		$this->sFileGameName = basename($this->sPathGameName);
		list($sTmp1, $sTmp2) = explode('.', $this->sFileGameName);
		$this->sGameName = $sTmp1;

		$this->sVGAName=$sVGAName;
		$this->sMonitorType=$sMonitorType;
		$this->bDebug=$bDebug;

		if($this->bDebug) {
			echo "\nPath: ".$this->sPathGameName;
			echo "\nBasename: ".$this->sFileGameName;
			echo "\nName: ".$this->sGameName;
			echo "\nVGAName: ".$this->sVGAName;
			echo "\nMonitorType: ".$this->sMonitorType;
		}
	}


	function changeResolution($sWidth, $sHeight, $sVertRefresh, $bVerticalGame=false){

		$sVerticalGame=0;

		if($bVerticalGame){
			$sVerticalGame=1;
		}
		$sCMDExec = $this->sSwitchResExe." ".$sWidth." ".$sHeight." ".$sVertRefresh." ".$this->sMonitorType." ".$sVerticalGame;

		$sOutput = '';
		$sReturnStatus = '';

		exec($sCMDExec, $sOutput, $sReturnStatus);

		if($this->bDebug) {
			echo "\nExec: ".$sCMDExec;
			echo "\nOutput: ".print_r($sOutput, true);
			echo "\nReturnStatus: ".$sReturnStatus;
		}

		if($sReturnStatus=='0')
			return true;
		else
			return false;
	}

	function startGame($sResolution){

		//$sCMDExec = $this->sMameExe." -switchres -resolution ".$sResolution."  -keepaspect -waitvsync -verbose -skip_gameinfo ".$this->sPathGameName;
		$sCMDExec = $this->sMameExe." -keepaspect -waitvsync -verbose -skip_gameinfo ".$this->sPathGameName;
		$sOutput = '';
		$sReturnStatus = '';

		exec($sCMDExec, $sOutput, $sReturnStatus);

		if($this->bDebug) {
			echo "\nExec: ".$sCMDExec;
			echo "\nOutput: ".print_r($sOutput, true);
			echo "\nReturnStatus: ".$sReturnStatus;
		}

		if($sReturnStatus=='0')
			return true;
		else
			return false;


	}
}

$sSqlLiteDB = '/media/perfectcab/db/mame.db';
$sVGAName = '';
$bDebug = true;


$sFallBackResolution = '640x480x60';
$sFallBackWidth = "640";
$sFallBackHeight = "480";
$sFallBackVertRefresh = "60";

$sAttractModeResolution = '640x480x60';
$sAttractModeWidth = "640";
$sAttractModeHeight = "480";
$sAttractModeVertRefresh = "60";

$sVGAName = $argv[1];
$sPathGameName = $argv[2];
$sMonitorType = $argv[3];

$oStartGame = new StartGame($sPathGameName, $sVGAName, $sMonitorType, $bDebug);

try {


	/**************************************
	 * Create databases and                *
	 * open connections                    *
	 **************************************/
	// Create (connect to) SQLite database in file
	$file_db = new PDO('sqlite:'.$sSqlLiteDB);
	// Set errormode to exceptions
	$file_db->setAttribute(PDO::ATTR_ERRMODE, 
			PDO::ERRMODE_EXCEPTION);


	$sql = "SELECT display_width, display_height, display_refresh, display_rotate 
		FROM mameroms 
		WHERE
		name=:name";


	$stmt = $file_db->prepare($sql);
	$stmt->bindParam(':name', $oStartGame->sGameName);


	if ($stmt->execute()) {
		while ($row = $stmt->fetch()) {
			
			$sResolution = $row['display_width']."x".$row['display_height'];
			
			$sWidth = $row['display_width'];
			$sHeight = $row['display_height'];
			$sVertRefresh = $row['display_refresh'];
			$sRotate = $row['display_rotate'];

			$bVerticalGame=false;

			if($sRotate!='0'){
				$bVerticalGame=true;
			}

			
			if($bDebug){
				echo "\Change Resolution To Game Native Resolution";			
			}

			/* Change CRT Resolution */
			if(!$oStartGame->changeResolution($sWidth, $sHeight, $sVertRefresh, $bVerticalGame))
			{	
				if($bDebug){
					echo "\nFailed To Change Resolution To Game Native Resolution - Try FallBack Resolution";			
				}

				$oStartGame->changeResolution($sFallBackWidth, $sFallBackHeight, $sFallBackVertRefresh);
			}
			
			sleep(2);

			if($bDebug){
				echo "\nSTART GAME...";			
			}				    

			$oStartGame->startGame($sResolution);

			if($bDebug){
				echo "\nEXIT GAME... COME BACK TO ATTRACT MODE RESOLUTION";			
			}	

			sleep(2);

			/* On game exit set AttractMode resolution */
			$oStartGame->changeResolution($sAttractModeWidth, $sAttractModeHeight, $sAttractModeVertRefresh);


		}
	} else {
		die('no record');	
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

if($bDebug){
	echo "\nEND\n";			
}

?>
