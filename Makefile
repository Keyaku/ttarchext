DSTDIR = bld
SRCDIR = src

BUILD = release

CFLAGS = -std=c99 -c -pedantic -fPIC -flto -Wall -Wno-pointer-sign
LDFLAGS = -lz

ifeq ($(shell uname), Darwin)
	CC = xcrun -sdk macosx clang
else
	CC = gcc
endif

ifeq ($(BUILD), debug)
	CFLAGS  += -O0 -g -pg -DDEBUG
else
	CFLAGS  += -O3
	LDFLAGS += -O3
endif

TARGET = $(DSTDIR)/ttarchext
OBJECTS  = $(patsubst $(SRCDIR)/%.c, $(DSTDIR)/%.o, $(wildcard $(SRCDIR)/*.c))

$(DSTDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -o $@ $<

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

clean:
	rm -rf $(DSTDIR)/*
