# Simple Makefile.w32 for stunnel.exe by Michal Trojnara 1998-2007
#
# Modified by Brian Hatch  (bri@stunnel.org)

# This makefile is only tested on the mingw compiler.  Mingw
# can successfully compile both openssl and stunnel.  If you want
# to use another compiler, give it a shot, and tell us how it went.

# Modify this to point to your actual openssl compile directory
# (You did already compile openssl, didn't you???)
SSLDIR=../openssl-1.0.0a

DEFINES=-DUSE_WIN32 -DHAVE_OPENSSL

CC=gcc
CFLAGS=-g -O2 -Wall $(DEFINES) -I$(SSLDIR)/outinc
LDFLAGS=-s

# LIBS=-L$(SSLDIR)/out -lssl -lcrypto -lwsock32 -lgdi32 -lcrypt32

LIBS=-L$(SSLDIR)/out -lzdll -leay32 -lssl32 -lwsock32 -lgdi32 -lcrypt32
OBJS=stunnel.o ssl.o ctx.o verify.o file.o client.o protocol.o sthreads.o log.o options.o network.o resolver.o gui.o resources.o

stunnel.exe: $(OBJS)
	$(CC) $(LDFLAGS) -o stunnel.exe $(OBJS) $(LIBS) -mwindows

clean:
	del *.o
	del stunnel.exe

resources.o: resources.rc resources.h
	windres resources.rc resources.o

$(OBJS): *.h Makefile.w32

