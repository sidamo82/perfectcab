input=$1;

DISPLAY=:0;

export DISPLAY=:0;

echo $input;

#xrandr --output VGA-0 --mode 256x192-sms-1
#xrandr --output VGA-0 --mode 320x240

/usr/bin/amixer set Master 70%

sleep 1

echo "/usr/local/bin/snes9x -fullscreen ${input}";
/usr/local/bin/snes9x "${input}"

/usr/bin/amixer set Master 100%

sleep 1

#xrandr --output VGA-0 --mode default




