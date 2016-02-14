#!/bin/bash

export SPACECHEM_PATH="$HOME/Library/Application Support/Steam/steamapps/common/SpaceChem/SpaceChem.app/Contents"

if [ ! -d "$SPACECHEM_PATH" ]; then
  echo "I couldn't find SpaceChem! Is it installed in the default Steam library?"
  read -p "Press Return to exit."
  exit 1
fi

echo "Checking if Mono's in the PATH"

if which mono | grep mono; then
  echo Yes
else
  echo "No. Please download and install Mono 32-bit."
  open "http://www.mono-project.com/download/" 
  read -p "Press Return to close, then try again."
  exit 1
fi

echo "Is Mono 32-bit?"

if mono --version | grep x86; then
  export THE_MONO='mono'
  echo Yes

  echo "Is the Mono in the path actually at /usr/local/bin? PATH changed in El Capitan!"
  if [[ `which mono` == "/usr/local/bin/mono" ]]; then
    echo Yes
    echo "Alright - replacing launcher with fixed-launcher-local.sh..."
    rm /tmp/fixed-launcher.sh 2>&1 >/dev/null
    curl -o /tmp/fixed-launcher.sh "https://raw.githubusercontent.com/leafi/fix-spacechem-os-x/master/fixed-launcher-local.sh"
    cp -f /tmp/fixed-launcher.sh "${SPACECHEM_PATH}/MacOS/SpaceChem"
    chmod a+rx "${SPACECHEM_PATH}/MacOS/SpaceChem"
    echo "OK, done."
  else
    echo Nah, you should be alright then
  fi

else
  export THE_MONO='/Library/Frameworks/Mono.framework/Commands/mono'
  echo "No! Hm. Trying explicit path /Library/Frameworks/Mono.framework/Commands/mono..."

  if $THE_MONO --version | grep x86; then
    echo "Alright - replacing launcher with fixed-launcher-Library.sh..."
    rm /tmp/fixed-launcher.sh 2>&1 >/dev/null
    curl -o /tmp/fixed-launcher.sh "https://raw.githubusercontent.com/leafi/fix-spacechem-os-x/master/fixed-launcher-Library.sh"
    cp -f /tmp/fixed-launcher.sh "${SPACECHEM_PATH}/MacOS/SpaceChem"
    chmod a+rx "${SPACECHEM_PATH}/MacOS/SpaceChem"
    echo "OK, done."
  else
    echo "No luck! Please download and install Mono 32-bit."
    open "http://www.mono-project.com/download/"
    read -p "Press Return to close, then try again."
    exit 1
  fi
fi

echo "Messing with libraries..."

rm -rf /tmp/old_SDL_image.framework >/dev/null 2>&1

echo "Downloading old SDL_image...."

curl -o /tmp/SDL_image-1.2.10.dmg "https://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.10.dmg"

hdiutil detach /Volumes/SDL_image >/dev/null 2>&1

hdiutil attach /tmp/SDL_image-1.2.10.dmg >/dev/null

echo "Copying stuff to /Library/Frameworks as administrator..."

osascript -e "do shell script \"mv /Library/Frameworks/SDL_image.framework /tmp/old_SDL_image.framework; cp -R /Volumes/SDL_image/SDL_image.framework /Library/Frameworks/SDL_image.framework ; cp -Rf '${SPACECHEM_PATH}/Frameworks/SDL.framework' /Library/Frameworks/SDL.framework ; cp -Rf '${SPACECHEM_PATH}/Frameworks/SDL_mixer.framework' /Library/Frameworks/SDL_mixer.framework\" with administrator privileges"

hdiutil detach /Volumes/SDL_image >/dev/null 2>&1

echo "Should all be OK! Try launching via Steam. Any problems, log an issue on GitHub."

read -p "Press Return to close..."

