# Fix SpaceChem for OS X 10.11

SpaceChem has bitrotted a bit. It uses SDL_image 1.2.12, a version that surprisingly broke on modern OS X, and it's very picky about the version of Mono required. (Must be 32-bit, must **not** be 4.3+ - Mono broke something. Ugh.)

But I'm here to take all your troubles away. 

**Patcher app: ->** https://github.com/leafi/fix-spacechem-os-x/releases/tag/v2

**Note: This is for the Steam version. I have no idea about anything for the Humble Bundle version.**

The app downgrades the particular shipped version of SDL and also includes a known good standalone version of Mono (thanks to MonoKickStart). Run it, or read on for more rambling technical info.

====

Without MonoKickStart: SpaceChem doesn't include Mono - you have to install it yourself - and Mono 4.3/4.4 break some web stuff so you need to use Mono 4.2 or older, and you **need** to make sure you use 32-bit Mono not 64-bit Mono, and...

Visit the Wiki if you want to understand what the hell is going on. It's very hairy.

### For the technical: Read the shell script and examine the tarball.

Ah, this page used to be full of technical stuff. I found a thing called MonoKickStart that lets you ship Mono inside applications, and now everything is hunky dory.

bonsai.tar.bz2 is an archive with all the files to be updated/replaced in SpaceChem.app, curated and massaged by yours truly based on Mono 4.2.4.4, and fix-spacechem.sh is a script that'll copy the files over. 

'Fix Spacechem.app' is just the script in .app form, running in a window. Nice little program called Platypus did that.

Everything's here, so if you don't trust me at all or you're just curious, dig through the wiki and the tarball.

# Issues?

Make issues on GitHub ideally, or complain in that Reddit or that Steam thread. 

Try to `cd` into the Resources directory inside SpaceChem.app and do `./SpaceChem.bin.osx` from a Terminal. Copy the output, and if it says it made a .zicrash file somewhere (and it will), please go find that file. (It's a zip file with a funny extension; if you rename it, you can see `exception.txt` inside which is really the key here.)

