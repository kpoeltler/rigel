include ../common.mk

CFLAGS :=  -I../libmisc -I../libastro -I../libwcs $(CFLAGS)

OBJS =	align2fits.o	\
	fitsbase.o		\
	fitscorr.o	\
	filters.o	\
	fitsip.o

libfits.so:	$(OBJS) $(wildcard *.h)
	gcc -shared -o $@ $(OBJS)

.PHONY: clean
clean:
	rm -f *.o libfits.a libfits.so


.PHONY: install
install:
	cp libfits.so $(inst_dir)

