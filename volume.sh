#!/bin/bash

##############################################################################
#
#  Volume control script for use with pipewire uses wpctl
#  (c) Steven Saus 2025
#  Licensed under the MIT license
#
##############################################################################

VERSION="0.0.1"
export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
export INSTALL_DIR="$(dirname "$(readlink -f "$0")")"
LOUD=1
STATUSVAR=$(wpctl status -k)

function loud() {
##############################################################################
# loud outputs on stderr 
##############################################################################    
    if [ $LOUD -eq 1 ];then
        echo "$@" 1>&2
    fi
}


 

get_sinks() {
  # Requires: STATUSVAR to be defined and contain the wpctl status output
  [[ -z "$STATUSVAR" ]] && { echo "STATUSVAR is empty"; return 1; }

  # Extract the block of sinks
  local sinks_block
  sinks_block=$(echo "$STATUSVAR" | awk '/Sinks:/,/Sink endpoints:/')

  # Default sink line (marked with *)
  local default_line
  default_line=$(echo "$sinks_block" | grep '*')
 
  export DEFAULTSINKNUMBER=$(echo "$default_line" | tr -d '*' | awk '{print $2}' | tr -d '.')
  export DEFAULTSINK=$(echo "$default_line" | cut -d'.' -f2- | sed 's/^[[:space:]]*//;s/\[.*//')

  # Find first active stream sink
  local active_line
  active_line=$(echo "$STATUSVAR" | awk '/Streams:/,/Video/' | grep '\[active\]' | head -n1)
  export ACTIVESINK=$(echo "$active_line" | awk -F'> ' '{print $2}' | cut -d':' -f1)
  # Match to sink block to find active sink number
  local active_sink_line
  active_sink_line=$(echo "$sinks_block" | grep -E "\. $ACTIVESINK[[:space:]]")
  export ACTIVESINKNUMBER=$(echo "$active_sink_line" | tr -d '*' | awk '{print $2}' | tr -d '.')
}

calc_vol() {
    local input="$1"

    # Check for valid integer input
    if ! [[ "$input" =~ ^[0-9]+$ ]] || (( input < 0 || input > 300 )); then
        loud "[ERROR] Input must be an integer between 0 and 300"
        exit
    fi

    # Calculate and clamp the value
    local result
    result=$(awk -v val="$input" 'BEGIN { 
        v = val / 100.0; 
        if (v < 0) v = 0; 
        if (v > 3.0) v = 3.0; 
        printf "%.2f", v 
        }')
    
    wpctl set-volume "${DEFAULTSINKNUMBER}" "${result}"
    wpctl set-volume "${ACTIVESINKNUMBER}" "${result}"
}

 




#STATUSVAR="$(< wpctl_status.txt)"  # Load from file (or directly assign elsewhere)
get_sinks
        loud "Default Sink: $DEFAULTSINK ($DEFAULTSINKNUMBER)"
        loud "Active Sink:  $ACTIVESINK ($ACTIVESINKNUMBER)"

case "${1}" in 
    quiet)      
        LOUD=0
        shift
        ;;
    up)
        wpctl set-volume "${DEFAULTSINKNUMBER}" 0.1+
        wpctl set-volume "${ACTIVESINKNUMBER}" 0.1+
        exit
        ;;
    down)
        wpctl set-volume "${DEFAULTSINKNUMBER}" 0.1-
        wpctl set-volume "${ACTIVESINKNUMBER}" 0.1-
        exit
        ;;
    toggle)
        wpctl set-mute "${DEFAULTSINKNUMBER}" toggle
        wpctl set-mute "${ACTIVESINKNUMBER}" toggle
        exit
        ;;
    mute)
        wpctl set-mute "${DEFAULTSINKNUMBER}" 1
        wpctl set-mute "${ACTIVESINKNUMBER}" 1    
        exit
        ;;
    unmute)
        wpctl set-mute "${DEFAULTSINKNUMBER}" 0
        wpctl set-mute "${ACTIVESINKNUMBER}" 0
        exit
        ;;
    *)  
        calc_vol "${1}" 
        ;;  
esac  
