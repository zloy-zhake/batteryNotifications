#!/usr/bin/env sh

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

# for notify-send to work through cron
export DISPLAY=:0

# Get the battery status and store it in a variable
battery=$(acpi)

# when battery is discharging
if acpi | grep -q "Discharging"; then
  percentage=$(echo "$battery" | cut -c 25-26 )

  # when battery is less than 51% show notification
  if [ "$percentage" -lt 51 ]; then
    notify-send "$battery"
  fi

# when battery is charging
elif acpi | grep -q "Charging"; then
  percentage=$(echo "$battery" | cut -c 22-23 )
  
  # when battery is more than 79% show notification
  if [ "$percentage" -gt 79 ]; then
    notify-send "$battery"
  fi
fi
