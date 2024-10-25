#! /usr/bin/bash

echo "The following script assumes that you already have a second hard drive with enough space (20G)."

echo "If true, confirm to continue (y/n):"
read answer

if [ "$answer" == "y" ]; then 
       echo "Continuing with the script..."
else 
    echo "Exiting the script."
    exit
fi

echo "Signing in to sudo. Please provide creditials."
sudo -v

# Keep sudo credentials alive until the script ends
while true; do
  # Refresh sudo timestamp to avoid timeout
  sudo -v
  sleep 60 # Keep sudo alive by refreshing every 60 seconds
done &

echo "You are signed in to sudo! Your privileges will remain active as long as this script runs."
echo "Press Ctrl+C to exit and end the sudo session."
echo "..."

echo "Checking to see whether your host system has all the appropriate versions, and the ability to compile programs, run the following commands"
./version_check.sh > /dev/null 2>&1
echo "......................................................"
./version_check.sh
echo "......................................................"

echo "If all is fine continue. (y/n)"
read answer

if [ "$answer" == "y" ]; then 
	echo "Continuing with the script..."
else
	exit;
fi
