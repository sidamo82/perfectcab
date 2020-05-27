<?php

$reader = new XMLReader;
$reader->open('list.xml');
$i=0;

while ($reader->read())
{
	if ($reader->nodeType == XMLReader::ELEMENT && $reader->name == 'machine') {

		$bIsNeoGeo=false;

		$name = $reader->getAttribute('name');
		$sourcefile = $reader->getAttribute('sourcefile');
		$isbios = $reader->getAttribute('isbios');
		$isdevice = $reader->getAttribute('isdevice');
		$ismechanical = $reader->getAttribute('ismechanical');
		$runnable = $reader->getAttribute('runnable');
		$cloneof = $reader->getAttribute('cloneof');
		$romof = $reader->getAttribute('romof');
		$sampleof = $reader->getAttribute('sampleof');

		$reader->moveToElement();

		$Foo = new SimpleXMLElement($reader->readOuterXml());


		


		$description = (string)$Foo->description;
		$year = (string)$Foo->year;
		$manufacturer = (string)$Foo->manufacturer;

foreach($Foo->rom as $aRom){
			
			$sRomName = (string)$aRom['name'];

			if($sRomName == 'sp-e.sp1')
			{			
				$bIsNeoGeo = true;
				break;				
				//echo "\nRomaaaaaaaaaaaa: ".$sRomName;
			}	
		}

		if($bIsNeoGeo){
			echo "\nNome: ".$description;
		}

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

		//echo "\n".print_r($aGameInfo, true);

		//die();
		$i++;

	}

}

$reader->close();


/**************************************
 * Close db connections                *
 **************************************/

// Close file db connection
$file_db = null;


echo "\nTotale giochi: ".$i;

?>
