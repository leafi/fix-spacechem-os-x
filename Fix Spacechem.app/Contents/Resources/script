#!/bin/bash

export SPACECHEM_PATH="$HOME/Library/Application Support/Steam/steamapps/common/SpaceChem/SpaceChem.app/Contents"

if [ ! -d "$SPACECHEM_PATH" ]; then
  echo "I couldn't find SpaceChem! Is it installed in the default Steam library?"
  read -p "Press Return to exit."
  exit 1
fi

cp -v bonsai.tar.bz2 "$SPACECHEM_PATH/"
pushd "$SPACECHEM_PATH"
rm -rf Frameworks/SDL_image.framework
rm -rf Frameworks/SDL_mixer.framework
rm -rf Frameworks/SDL.framework
tar -jxvf bonsai.tar.bz2
rm bonsai.tar.bz2

echo "Should all be OK! Try launching via Steam. Any problems, log an issue on GitHub."

read -p "Press Return to close..."

