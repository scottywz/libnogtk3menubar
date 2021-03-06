NAME = nogtk3menubar
CFLAGS = `pkg-config --cflags glib-2.0 gtk+-3.0`
LDFLAGS = `pkg-config --libs glib-2.0 gtk+-3.0`

all: lib${NAME}.so

32: lib${NAME}32.so
64: lib${NAME}.so

lib${NAME}.so: lib${NAME}-native.so
	mv $^ $@

lib${NAME}%.so: main.c
	$(CC) $(CFLAGS) -Wall -fPIC -DPIC -c main.c -o ${NAME}.o \
	 $(if $(filter 32,$*),-m$*,)
	$(LD) $(LDFLAGS) -ldl -shared -o $@ ${NAME}.o \
	 $(if $(filter 32,$*),-m elf_i386,)
	rm -f ${NAME}.o

.PHONY: clean

clean:
	rm -f lib${NAME}*.so*
