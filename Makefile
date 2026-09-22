CC := gcc
AR := ar
CFLAGS := -std=c11 -Wall -Wextra -pedantic -Iinclude
LDFLAGS :=

TARGET := bin/client_static
LIBRARY := lib/libmyutils.a
DYNAMIC_LIBRARY := lib/libmyutils.so
DYNAMIC_TARGET := bin/client_dynamic
OBJDIR := obj
SRCDIR := src
DRIVER_OBJECT := $(OBJDIR)/main.o
LIBRARY_OBJECTS := $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
DYNAMIC_SOURCES := $(SRCDIR)/mystrfunctions.c $(SRCDIR)/myfilefunctions.c

.PHONY: all build compile archive link run dynamic shared dynamic-link run-dynamic clean

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

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f $(TARGET) $(DYNAMIC_TARGET) $(LIBRARY) $(DYNAMIC_LIBRARY)