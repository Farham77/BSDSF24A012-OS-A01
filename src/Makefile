CC ?= gcc
CFLAGS ?= -std=c11 -Wall -Wextra -pedantic -I../include
OBJDIR ?= ../obj

DRIVER_OBJECT := $(OBJDIR)/main.o
LIBRARY_OBJECTS := $(OBJDIR)/mystrfunctions.o $(OBJDIR)/myfilefunctions.o
OBJECTS := $(DRIVER_OBJECT) $(LIBRARY_OBJECTS)

.PHONY: all clean

all: $(OBJECTS)

$(OBJDIR)/%.o: %.c
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS)