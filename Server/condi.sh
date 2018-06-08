#!/bin/sh
# If eula.txt file not found, create it and set it to true
if [ ! -f eula.txt ]; then
  echo "Initialize file and Setting EULA..."
  /mccore/START.sh
  sed -i 's/false/true/g' eula.txt
fi
echo "Start server"
# Start the server
/mccore/START.sh
