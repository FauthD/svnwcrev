EXECUTABLE_NAME=svnwcrev

CC=$(CXX)
CXX=g++

CPPFLAGS=-I$(SUBVERSION_INCLUDE) -I$(APR_INCLUDE)
CXXFLAGS=-g3

LDLIBS=-lpthread -L$(LIBRARIES) -lsvn_client-1 -lsvn_wc-1 -lsvn_subr-1 -lapr-1

objects=src/status.o src/SVNWcRev.o

include config.mk
include default.mk

#########################################################################################
# Create a version info file
# Using the svn tool and echo commands to fill the file with a #define statement.

# A file that will contain the subversion revision.
# It will be created down below in this makefile.
# We need to ensure the VERSIONFILE will be updated if the version changes. 
# Though simple file dates will not work, so we check the latest vesion with svnversion
# and compare with the contenst of the VERSIONFILE. Conditional-make uses .PHONY
# only on version changes.

# One string for the version contents ensures the compare really works
VERSIONFILE:=src/version.h
VERSIONTEXT:=/bin/echo -ne "\x23define SVNWCREV_VERSION \x221.1, Build "; svnversion -n .; /bin/echo -e "\x22"
CURRENTVERSION:=$(shell $(VERSIONTEXT))
FILEDVERSION:=$(shell cat $(VERSIONFILE) 2>/dev/null)

ifneq ($(CURRENTVERSION), $(FILEDVERSION))
.PHONY : $(VERSIONFILE)
endif
$(VERSIONFILE):
	( $(VERSIONTEXT) )> $(VERSIONFILE)

	