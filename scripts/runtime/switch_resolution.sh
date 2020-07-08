#!/bin/bash

export DISPLAY=:0


switchres='/usr/local/bin/switchres';
xrandr='/usr/bin/xrandr';
horizontalres=$1;
verticalres=$2;
verticalrefresh=$3;
monitor=$4;

RESOLUTIONNAME="${horizontalres}x${verticalres}x${verticalrefresh}";

echo "RESOLUTION NAME: $RESOLUTIONNAME";

# DETECT VIDEOCARD NAME
VIDEOCARDNAME=`$xrandr | grep -w connected | /usr/bin/awk '{print $1}'`


#Calculate modeline
echo "$switchres $horizontalres $verticalres $verticalrefresh --calc --monitor $4 | grep -i modeline | sed s/modeline//gi | awk '{$1=""}1'";
MODELINE=`$switchres $horizontalres $verticalres $verticalrefresh --calc --monitor $4 | grep -i modeline | sed s/modeline//gi | awk '{$1=""}1'`;

echo "MODELINE: $MODELINE";

# ADD NEW MODLINE
echo "$xrandr --newmode $RESOLUTIONNAME $MODELINE";
$xrandr --newmode "$RESOLUTIONNAME" $MODELINE

echo "$xrandr --addmode $VIDEOCARDNAME $RESOLUTIONNAME";
$xrandr --addmode $VIDEOCARDNAME $RESOLUTIONNAME;

# SWITCH MODELINE
echo "$xrandr --output $VIDEOCARDNAME --mode $RESOLUTIONNAME";
$xrandr --output $VIDEOCARDNAME --mode $RESOLUTIONNAME;

exit 0;
