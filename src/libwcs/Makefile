include ../common.mk

CFLAGS := -I../libmisc -I../libfits -I../libastro -I../libfs $(CFLAGS)

OBJS =	align2wcs.o \
	delwcsfits.o \
	setwcsfits.o \
	checkwcsfits.o \
	findreg.o \
	findregd.o \
	worldpos.o \
	xyradec.o

libwcs.so: $(OBJS) $(wildcard *.h)
	$(CC) -shared $(CFLAGS) -o $@ $(OBJS)


.PHONY: install
install:
	cp libwcs.so $(inst_dir)

.PHONY: clean
clean:
	rm -f *.o libwcs.so

