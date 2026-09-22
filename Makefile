CC := gcc
AR := ar
CFLAGS := -std=c11 -Wall -Wextra -pedantic -Iinclude
LDFLAGS :=

TARGET := bin/client_static
LIBRARY := lib/libmyutils.a
OBJDIR := obj
SRCDIR := src
DRIVER_OBJECT := $(OBJDIR)/main.o
LIBRARY_OBJECTS := $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

.PHONY: all build compile archive link run clean

all: build

build: link

compile:
	@mkdir -p $(OBJDIR) bin lib
	$(MAKE) -C $(SRCDIR) CC="$(CC)" CFLAGS="$(CFLAGS)"

archive: compile
	$(AR) rcs $(LIBRARY) $(LIBRARY_OBJECTS)

link: archive
	$(CC) $(LDFLAGS) $(DRIVER_OBJECT) $(LIBRARY) -o $(TARGET)

run: build
	./$(TARGET)

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f $(TARGET) $(LIBRARY)