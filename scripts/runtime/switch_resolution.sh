#!/bin/bash

export DISPLAY=:0


switchres='/usr/local/bin/switchres';
xrandr='/usr/bin/xrandr';
horizontalres=$1;
verticalres=$2;
verticalrefresh=$3;
monitor=$4;
rotate=$5;


RESOLUTIONNAME="${horizontalres}x${verticalres}x${verticalrefresh}";

echo "RESOLUTION NAME: $RESOLUTIONNAME";

# DETECT VIDEOCARD NAME
VIDEOCARDNAME=`$xrandr | grep -w connected | /usr/bin/awk '{print $1}'`


#Calculate modeline
SWITCHRESCOMMAND="$switchres $horizontalres $verticalres $verticalrefresh --calc --monitor $4"

if [ "$rotate" = "1" ]; then
	echo "VERTICAL GAME DETECTED: CALCULATE CUSTOM RESOLUTION FOR HORIZONTAL SCREEN"
	SWITCHRESCOMMAND="$SWITCHRESCOMMAND -r"
fi

echo "$SWITCHRESCOMMAND"
MODELINE=`$SWITCHRESCOMMAND | grep -i modeline | sed s/modeline//gi | awk '{$1=""}1' | awk '{printf "%s %s %s %s %s %s %s %s %s %s %s %s", $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16}'`;
MODELINENAME=`$SWITCHRESCOMMAND | grep -i modeline | sed s/modeline//gi | awk '{$1=""}1' | awk '{printf "%s %s %s", $1, $2, $3}'`;

echo "MODELINE: $MODELINE";
echo "MODELINENAME: $MODELINENAME";

# ADD NEW MODLINE
echo "$xrandr --newmode $MODELINENAME $MODELINE";
$xrandr --newmode "$MODELINENAME" $MODELINE

echo "$xrandr --addmode $VIDEOCARDNAME $MODELINENAME";
$xrandr --addmode $VIDEOCARDNAME "$MODELINENAME";

echo "$xrandr --output $VIDEOCARDNAME --mode $MODELINENAME";
$xrandr --output $VIDEOCARDNAME --mode "$MODELINENAME";

exit 0;
