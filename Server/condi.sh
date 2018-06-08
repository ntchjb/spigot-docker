#!/bin/sh
if [ ! -f eula.txt ]; then
  echo "Initialize file and Setting EULA..."
  /mccore/START.sh
  sed -i 's/false/true/g' eula.txt
fi
echo "Start server"
/mccore/START.sh
