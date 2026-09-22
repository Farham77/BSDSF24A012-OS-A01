CC := gcc
CFLAGS := -std=c11 -Wall -Wextra -pedantic -Iinclude
LDFLAGS :=

TARGET := bin/client
OBJDIR := obj
SRCDIR := src
OBJECTS := $(OBJDIR)/main.o $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o

.PHONY: all build compile link run clean

all: build

build: link

compile:
	@mkdir -p $(OBJDIR) bin
	$(MAKE) -C $(SRCDIR) CC="$(CC)" CFLAGS="$(CFLAGS)"

link: compile
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(TARGET)

run: build
	./$(TARGET)

clean:
	$(MAKE) -C $(SRCDIR) clean
	rm -f $(TARGET)