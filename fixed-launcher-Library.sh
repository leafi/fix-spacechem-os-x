#!/usr/bin/env python

import os
import sys

APPDATA_DIR = os.path.expanduser("~/.local/share/Zachtronics Industries/SpaceChem")
LAUNCHLOG_PATH = os.path.join(APPDATA_DIR, 'maclaunch.log')

# Create the log file.
if not os.path.exists(APPDATA_DIR):
    os.makedirs(APPDATA_DIR)
log_file = open(LAUNCHLOG_PATH, "w");

def log(message):
    print message
    log_file.write(message + '\n')
    log_file.flush()

def which(program):
    for path in os.environ['PATH'].split(':'):
        try:
            for name in os.listdir(path):
                if name == program:
                    full_path = os.path.join(path, name)
                    is_executable = os.access(full_path, os.X_OK)
                    if os.path.isfile(full_path) and is_executable:
                        return full_path
        except:
            pass
    return None

def main():
    log("Log created, script running.")
    log("THIS IS A PATCHED LAUNCHER FROM LEAFI'S GITHUB - hardcoded /Library/Frameworks/Mono.framework/Commands/mono one!")


    # Find the absolute path to the .app bundle.
    cwd = os.getcwd()
    app_path = os.path.join(cwd, os.path.dirname(sys.argv[0]), '..', '..')
    app_path = os.path.normpath(app_path)
    log('Working directory = "%s"' % cwd)
    log('Invoked path = "%s"' % sys.argv[0])
    log('.app path = "%s"' % app_path)

    app_name = os.path.basename(sys.argv[0])
    log('App name = "%s"' % app_name)

    # Change to the Resources directory, where SpaceChem.exe is.
    os.chdir(os.path.join(app_path, 'Contents', 'Resources'))
    log('Changed to Resources directory; working directory = "%s"' 
        % os.getcwd())

    # Launch SpaceChem!
    log('Launching SpaceChem!')
    log_file.close()
    os.execlp('/Library/Frameworks/Mono.framework/Commands/mono', app_name, app_name + '.exe')


# Entry point.
if __name__ == '__main__':
    main()

