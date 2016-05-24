DSTDIR = bld
SRCDIR = src

CFLAGS = -std=c99 -c -pedantic -O3 -flto -Wall -Wno-pointer-sign
LDFLAGS = -lz

ifeq ($(shell uname), Darwin)
	CC = xcrun -sdk macosx clang
else
	CC = gcc
	CFLAGS += -fPIC
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
