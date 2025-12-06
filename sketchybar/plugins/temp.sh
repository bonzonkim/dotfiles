#!/bin/bash
# Check for smctemp in both Intel and Apple Silicon locations
if [ -x "/opt/homebrew/bin/smctemp" ]; then
    TEMP=$(/opt/homebrew/bin/smctemp -c)
elif [ -x "/usr/local/bin/smctemp" ]; then
    TEMP=$(/usr/local/bin/smctemp -c)
else
    TEMP="N/A"
fi

# if [ $? -ne 0 ]; then
# 	echo "Something has gone wrong."
# 	exit 1
# fi

sketchybar --set temp label=" ${TEMP}°C"
