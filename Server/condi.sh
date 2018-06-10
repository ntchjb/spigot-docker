#!/bin/sh
YELLOW='\033[0;33m'
NC='\033[0m'
# if eula.txt does not exist, then generate it first
echo -e "Start running container... EULA is ${EULA}"
if [ ! -f eula.txt ]; then
  echo -e "${YELLOW}Initialize files...${NC}"
  /mccore/START.sh
  if [ "$EULA" = true ]; then
    echo -e "${YELLOW}Setting EULA to true...${NC}"
    sed -i 's/false/true/g' eula.txt
  fi
elif [ -f eula.txt ] &&  (grep -q "eula=false" "eula.txt") && [ "$EULA" = true ]; then
  echo -e "${YELLOW}Setting EULA to true...${NC}"
  sed -i 's/false/true/g' eula.txt
fi
echo -e "${YELLOW}Starting server...${NC}"
# Start the server
/mccore/START.sh
