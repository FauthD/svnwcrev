# svnwcrev
Saved from svnwcrev.tigris.org

These are the sources I've got from svnwcrev.tigris.org many years back.
The binaries I compiled in ~2015 still worked with Ubuntu 20.04, but now 
I've got an issue with some files that the tool tries to translate to UTF-8, 
even when they are binary files. That triggered to look for updates, just to 
find out that tigris is dead since 2020.

Looks like my copies are the latesst that can be found in the net. Therefore I 
think it is just fair to share what I've got.

## Build on Ubuntu

- sudo apt install libsvn-dev
- Navigate into the root of the project (were the Makefile is located).
- make
- copy the new generated svnwcrev to /usr/local/bin
- optionally create symlinks for similar names in case you share makefiles between Windows and Linux.
	(subwcrev, ...)

