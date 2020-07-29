# GNU Make Makefile for Hello World Program
#
# Call make with: `make all`           for a “debug compile”, or
# call make with: `make all RELEASE=1` for a “release compile”.
#
# Note: On Windows, you may have GNU's `make`, or `mingw32-make`, so you
#       should run the appropriate version with this `Makefile`.

# operating system detection, to make the rest of the file more generic.
ifeq ($(OS),Windows_NT)
   THEOS := Windows
else
   THEOS := $(shell uname -s)
endif

# per-project settings and modifications. do not add `.exe` on Windows.
PROG := hello
SRCS := $(wildcard *.c)
OBJS := $(SRCS:.c=.o)
CC := gcc
CFLAGS := -Wall -Wextra -pedantic -std=c99
CPPFLAGS +=
LDFLAGS := 

# change compiler flags based on release/debug compiles.
ifdef RELEASE
   CFLAGS += -O2 -DNDEBUG
else
   CFLAGS += -O0 -g2
endif

ifeq ($(THEOS),Windows)
   PROG := bin\\$(PROG).exe
   RMCMD := cmd /c del $(PROG) $(OBJS) 2>NUL:
else
   PROG := bin/$(PROG)
   RMCMD := rm $(PROG) $(OBJS) 2>/dev/null || true
endif

# project-specific conditional compilation. call `make` with `DICE=X`,
# where `X` can be a positive integer value to control the number of
# dice the program will use on each ‘roll’.
#
ifdef DICE
   CFLAGS += -DDICE_COUNT=$(DICE)
endif

# generic rule for any `*.o` file, which is dependent on a `*.c` file
# with the same name, just a different extension. `$@` will result in
# the object file's name, and `$<` in the source file name.
#
%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

# ensure `./bin` directory exists.
#
bin:
	mkdir ./bin

# this rule specifies that the program executable, is dependend on
# the list of object files in `$(OBJS)`, and the commands to execute
# when it is out of date, is to peforming the “link” command.
#
$(PROG): $(OBJS) bin
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LDFLAGS)

.PHONY: all clean

# also clean preprocessed and assembler files, just in case.
clean:
	-@$(RMCMD)

all : $(PROG)
