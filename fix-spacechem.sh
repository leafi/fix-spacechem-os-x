#!/bin/bash

export SPACECHEM_PATH="$HOME/Library/Application Support/Steam/steamapps/common/SpaceChem/SpaceChem.app/Contents"

# Not in the Steam library? Try the system application folder (Humble Bundle version could have been installed there)
if [ ! -d "$SPACECHEM_PATH" ]; then
	export SPACECHEM_PATH="/Applications/SpaceChem.app/Contents"
fi
# Should probably check the GOG library for that version, but I don't know the correct path for it


if [ ! -d "$SPACECHEM_PATH" ]; then
  echo "I couldn't find SpaceChem! Is it installed in the default Steam library or the default Application folder?"
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

# Fix broken symbolic link in bonsai
pushd Frameworks/SDL_mixer.framework
rm SDL_mixer.framework
ln -s Versions/A/SDL_mixer .
popd
# End fix for broken symlink

echo "Should all be OK! Try launching as usual. Any problems, log an issue on GitHub."
echo "(And copy and paste this log in the issue.)"

read -p "Press Return to close..."
