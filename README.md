# Fix SpaceChem for OS X 10.11

The crux of the issue is that SpaceChem uses SDL_image 1.2.12.

Additionally, SpaceChem doesn't include Mono - you have to install it yourself - and Mono 4.3/4.4 break some web stuff so you need to use Mono 4.2 or older, and you **need** to make sure you use 32-bit Mono not 64-bit Mono, and...

Visit the Wiki if you want to understand what the hell is going on. It's very hairy.

## For the impatient: (Link TODO) and just run the .app to patch SpaceChem

### You don't even need to install Mono anymore. We include it.

Ah, this page used to be full of technical stuff. I found a thing called MonoKickStart that lets you ship Mono inside applications, and now everything is hunky dory.

bonsai.tar.bz2 is an archive with all the files to be updated/replaced in SpaceChem.app, curated and massaged by yours truly based on Mono 4.2.4.4, and fix-spacechem.sh is a script that'll copy the files over. 

'Fix Spacechem.app' is just the script in .app form, running in a window. Nice little program called Platypus did that.

Everything's here, so if you don't trust me at all or you're just curious, dig through the wiki and the tarball.

# Issues?

Make issues on GitHub ideally, or complain in that Reddit or that Steam thread. 

Try to `cd` into the Resources directory inside SpaceChem.app and do `./SpaceChem.bin.osx` from a Terminal. Copy the output, and if it says it made a .zicrash file somewhere (and it will), please go find that file. (It's a zip file with a funny extension; if you rename it, you can see `exception.txt` inside which is really the key here.)

