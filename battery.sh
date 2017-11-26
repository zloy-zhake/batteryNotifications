#!/usr/bin/env bash

# First of all, make this script executable
# chmod +x battery.sh
#
# Install acpi
# apt-get install acpi (Debian/Ubuntu)
# yum install acpi (RedHat/CentOS/Fedora)
# Then create a schedule to run the script every 5 minutes
# using crontab
# crontab -e
# */5 * * * * /path/to/script/battery.sh

# Get the battery status and store it in a variable
battery=$(acpi)

# The audio files location
# DIR="/path/to/audio/files/"
# DIR="./audio/"
# BATTERYFULLYCHARGED="charged"
# BATTERYDISCHARGED="discharged"
# LANG=""
# EXT=".wav"

# if [[ "$battery" =~ "Full" ]]; then
#   aplay -q "$DIR$BATTERYFULLYCHARGED$LANG$EXT"
  
# In my case, sometimes, the battery status never reach 100%
#elif [[ "$battery" =~ "99" ]]; then
#  aplay -q "$DIR$BATTERYFULLYCHARGED$LANG$EXT"

if [[ "$battery" =~ "Discharging" ]]; then
  percentage=${battery:24:2}
  percentage=${percentage//%}

  if [ "$percentage" -lt 51 ]; then
    # aplay -q "$DIR$BATTERYDISCHARGED$LANG$EXT"
    notify-send "$battery"
  fi

elif [[ "$battery" =~ "Charging" ]]; then
  percentage=${battery:21:2}
  percentage=${percentage//%}

  if [ "$percentage" -gt 79 ]; then
    # aplay -q "$DIR$BATTERYDISCHARGED$LANG$EXT"
    notify-send "$battery"
  fi

else
    echo "do nothing"
fi
