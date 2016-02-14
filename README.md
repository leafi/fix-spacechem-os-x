# Fix SpaceChem for OS X 10.11

The crux of the issue is that SpaceChem uses SDL_image 1.2.12.

On El Capitan, this messes up images for some reason, and that causes SpaceChem's font loader to fail because the images it's getting are quite messed up.

## Using the script (easy mode)

Do you trust me? Great, grab the script  https://github.com/leafi/fix-spacechem-os-x/releases/download/v1.0/fix-spacechem.command.zip , unzip, and double-click it. I hope you installed SpaceChem in the default Steam library.

(Update: I've been told that double-clicking this might cause OS X to prompt you to install XCode CLI tools. You don't need these. If you get this prompt, please just open a Terminal, cd to the right directory, and do `./fix-spacechem.command`. `chmod +x fix-spacechem.command` if it whines about fix-spacechem.command not being executable.)

## DIY (hard mode)

### Downgrade SDL_image to 1.2.10

Ugh, this is a bit involved.

Go to the folder `(steamapps)/common/SpaceChem/SpaceChem.app/Contents/Frameworks`.

Copy SDL_mixer.framework and SDL.framework, and paste them in `/Library/Frameworks`. Our replacement SDL_image will get upset if it can't see them there.

Optional: Delete SDL_image.framework and the other SDL frameworks from SpaceChem's Frameworks folder. Mono seems to prefer loading the /Library/Frameworks ones anyway.

Optional: Open Tao.Sdl.dll.config and fix up the paths. In practice this doesn't seem to matter.

Download and open https://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.10.dmg . Copy and paste SDL_image.framework to /Library/Frameworks.

Now, try launching the game through Steam again. With luck that'll be it.

### Fixing Mono not found issues (maybe not needed)

(i.e. that damn Zachtronics web page keeps opening up when you try to launch)

Firstly: Make sure you've installed mono from http://mono-project.com/. We are going to need it.

If you're like me, you have mono anyway, and it's 64-bit not 32-bit. (Do `mono --version` in a terminal.)

Now, we need to edit the launcher. Go edit (steamapps)/common/SpaceChem/SpaceChem.app/Contents/MacOS/SpaceChem in a text editor.

Delete the stuff that checks for Mono, lines 35 through 43.

Go near the bottom, to what was line 64 (`os.execlp('mono', app_name, app_name + '.exe')`).

Change that to:

`os.execlp('/Library/Frameworks/Mono.framework/Commands/mono', app_name, app_name + '.exe')`

Save and try and start SpaceChem again through Steam.

### Done!

I hope! If the game actually starts, however briefly, then you may find yourself at least with a crash log in ~/.local/share/zachtronic industries/spacechem/crashes. Unzip the crash file (rename to .zip if you want) and have a look at exception.txt.

I can try to dig through the executable if needs be, and figure out what's up.


## Debugging your copy by launching manually

If you're still having trouble launching or you're having another problem, navigate in a terminal to (steamapps)/common/spacechem/SpaceChem.app/Contents/Resources.

(e.g. /Users/leaf/Library/Application Support/Steam/SteamApps/common/SpaceChem/SpaceChem.app/Contents/Resources)

### steam_appid.txt

Create a text file called steam_appid.txt inside this Resources directory and put the number 92800 in it. It'll ask you for this file otherwise, as we're not going to launch through Steam here.

### Check mono architecture

Do `mono --version` in the command line. You should expect to see output like this:

  centaur:Contents leaf$ mono --version

  Mono JIT compiler version 4.2.2 (explicit/996df3c Wed Jan 20 00:19:48 EST 2016)

  Copyright (C) 2002-2014 Novell, Inc, Xamarin Inc and Contributors. www.mono-project.com

	TLS:           normal
	
	SIGSEGV:       altstack
	
	Notification:  kqueue
	
	Architecture:  x86
	
	Disabled:      none
	
	Misc:          softdebug 
	
	LLVM:          yes(3.6.0svn-mono-(detached/a173357)
	
	GC:            sgen


If you're seeing **Architecture: amd64**, that's a problem. SpaceChem is 32-bit only; trying to launch it from 64-bit Mono will cause the load of some shipped native libraries to fail.

The fix is thankfully simple. Go to http://mono-framework.com/ and download the Mac OS X build.

Then substitute `/Library/Frameworks/Mono.framework/Commands/mono` in place of `mono` for these commands.

### Launch manually

Just do `mono SpaceChem.exe`, substituting with the long path above if necessary.

If/when it crashes, open a new terminal and (as the instructions say!) go to `~/.local/share/zachtronics industries/spacechem/crashes`.

Type e.g. `unzip 001.zipcrash`. Overwrite existing files if necessary.

Then, `cat exception.txt`.

### Issues I've seen

* Wrong mono, obviously.

* Complaining about no font glyph breaks? That's why you need to downgrade to SDL_image 1.2.10!

* Can't load SDL_image? The replacement SDL_image seems to want to live in /Library/Frameworks/ rather than in SpaceChem's Frameworks directory, and it looks for its dependencies (other SDL) in /Library/Frameworks too. Mono can't distinguish between a dependency not being found and a dependency's dependency not being found.

* It launches, but there's no icon in the dock and mouse focus is pretty broken? Yeah, that's why SpaceChem is packed in this weird .app format in the first place, and why launching it like this is bad. Once you've fixed everything else, just launch through Steam like you should, and everything will be fine.

* Others? Contact me in some way. Give me the exception. I'll try my best to help.
