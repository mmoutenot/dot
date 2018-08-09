#!/bin/sh

# Get out of town if something errors
# set -e

# Get info on the monitors
EDP1_STATUS=$(</sys/class/drm/card0/card0-eDP-1/status )  
DP1_STATUS=$(</sys/class/drm/card0/card0-DP-1/status )  
DP2_STATUS=$(</sys/class/drm/card0/card0-DP-2/status )  

EDP1_STATUS=$(</sys/class/drm/card0/card0-eDP-1/status )  
DP1_ENABLED=$(</sys/class/drm/card0/card0-DP-1/enabled )  
DP2_ENABLED=$(</sys/class/drm/card0/card0-DP-2/enabled )  

# Check to see if our state log exists
if [ ! -f /tmp/monitor ]; then  
    touch /tmp/monitor
    STATE=5
else  
    STATE=$(</tmp/monitor)
fi

# The state log has the NEXT state to go to in it

# If monitors are disconnected, stay in state 1
if [ "disconnected" == "$DP1_STATUS" -a "disconnected" == "$DP2_STATUS" ]; then  
    STATE=1
fi

case $STATE in  
    1)
    # eDP is on, projectors not connected
    /usr/bin/xrandr --output eDP-1 --auto
    STATE=2
    ;;
    2)
    # eDP is on, projectors are connected but inactive
    /usr/bin/xrandr --output eDP-1 --auto --output DP-1 --off --output DP-2 --off
    STATE=3 
    ;;
    3)
    # eDP is off, projectors are on
    if [ "connected" == "$DP1_STATUS" ]; then
        /usr/bin/xrandr --output eDP-1 --off --output DP-1 --auto
        TYPE="DP1"
    elif [ "connected" == "$DP2_STATUS" ]; then
        /usr/bin/xrandr --output eDP-1 --off --output DP-2 --auto
        TYPE="DP2"
    fi
    /usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE"
    STATE=4
    ;;
    4)
    # eDP is on, projectors are mirroring
    if [ "connected" == "$DP1_STATUS" ]; then
        /usr/bin/xrandr --output eDP-1 --auto --output DP-1 --auto
        TYPE="DP1"
    elif [ "connected" == "$DP2_STAtus" ]; then
        /usr/bin/xrandr --output eDP-1 --auto --output DP-2 --auto
        TYPE="DP2"
    fi
    /usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE mirroring"
    STATE=5
    ;;
    5) 
    # eDP is on, projectors are extending
    if [ "connected" == "$DP1_STATUS" ]; then
        /usr/bin/xrandr --output eDP-1 --auto --output DP-1 --auto --pos 960x0
        TYPE="DP1"
    elif [ "connected" == "$DP2_STATUS" ]; then
        /usr/bin/xrandr --output eDP-1 --auto --output DP-1 --auto --pos 960x0
        TYPE="DP2"
    fi
    /usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE extending"
    STATE=2
    ;;
    *)
    # Unknown state, assume we're in 1
    STATE=1 
esac    

echo $STATE > /tmp/monitor  
