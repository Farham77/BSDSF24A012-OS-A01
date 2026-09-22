CC := gcc
AR := ar
CFLAGS := -std=c11 -Wall -Wextra -pedantic -Iinclude
LDFLAGS :=

TARGET := bin/client_static
LIBRARY := lib/libmyutils.a
DYNAMIC_LIBRARY := lib/libmyutils.so
DYNAMIC_TARGET := bin/client_dynamic
PREFIX ?= /usr/local
BINDIR := $(PREFIX)/bin
LIBDIR := $(PREFIX)/lib
MANDIR := $(PREFIX)/share/man/man3
MANPAGES := man/man3/mystrlen.3 man/man3/mystrcpy.3 man/man3/mystrncpy.3 man/man3/mystrcat.3 man/man3/wordCount.3 man/man3/mygrep.3
OBJDIR := obj
SRCDIR := src
DRIVER_OBJECT := $(OBJDIR)/main.o
LIBRARY_OBJECTS := $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
DYNAMIC_SOURCES := $(SRCDIR)/mystrfunctions.c $(SRCDIR)/myfilefunctions.c

.PHONY: all build compile archive link run dynamic shared dynamic-link run-dynamic install clean

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

dynamic: dynamic-link

shared: compile
	$(CC) $(CFLAGS) -fPIC --shared $(DYNAMIC_SOURCES) -o $(DYNAMIC_LIBRARY)

dynamic-link: shared
	$(CC) $(LDFLAGS) $(DRIVER_OBJECT) -Llib -lmyutils -o $(DYNAMIC_TARGET)

run-dynamic: dynamic
	./$(DYNAMIC_TARGET)

install: dynamic
	install -d $(DESTDIR)$(BINDIR) $(DESTDIR)$(LIBDIR) $(DESTDIR)$(MANDIR)
	install -m 755 $(DYNAMIC_TARGET) $(DESTDIR)$(BINDIR)/client
	install -m 755 $(DYNAMIC_LIBRARY) $(DESTDIR)$(LIBDIR)/libmyutils.so
	install -m 644 $(MANPAGES) $(DESTDIR)$(MANDIR)
	ldconfig

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f $(TARGET) $(DYNAMIC_TARGET) $(LIBRARY) $(DYNAMIC_LIBRARY)