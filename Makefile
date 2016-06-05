OBJDIR = bld
SRCDIR = src

BUILD = release

CFLAGS = -std=c99 -c -pedantic -fPIC -Wall -Wno-pointer-sign
LDFLAGS = -lz

ifeq ($(shell uname), Darwin)
	CC = xcrun -sdk macosx clang
else
	CC = gcc
endif

LD = $(CC)

ifeq ($(BUILD), debug)
	CFLAGS  += -O0 -g -pg -DDEBUG
	LDFLAGS += -O0 -g
else
	CFLAGS  += -O3
	LDFLAGS += -O3
endif

TARGET = $(OBJDIR)/ttarchext

OBJECTS  = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(wildcard $(SRCDIR)/*.c))

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -o $@ $<

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	rm -rf $(OBJDIR)/*

.PHONY: all clean
