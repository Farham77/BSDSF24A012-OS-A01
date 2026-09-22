CC ?= gcc
CFLAGS ?= -std=c11 -Wall -Wextra -pedantic -I../include
OBJDIR ?= ../obj

SOURCES := main.c mystrfunctions.c myfilefunctions.c
OBJECTS := $(SOURCES:%.c=$(OBJDIR)/%.o)

.PHONY: all clean

all: $(OBJECTS)

$(OBJDIR)/%.o: %.c
	@mkdir -p $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS)