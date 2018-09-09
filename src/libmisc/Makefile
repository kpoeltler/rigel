include ../common.mk

CFLAGS :=  -I../libastro -I../libfits $(CFLAGS)


OBJS =	catalogs.o 	\
	ccdcamera.o 	\
	ccdshared.o 	\
	ccd_auxcam.o \
	ccd_server.o \
	ccd_ocaas.o \
	cliserv.o 	\
	configfile.o 	\
	crackini.o	\
	csimc.o 	\
	focustemp.o     \
	funcmax.o	\
	gaussfit.o 	\
	lstsqr.o 	\
	misc.o 		\
	newton.o	\
	photstd.o 	\
	rot.o 		\
	running.o 	\
	scan.o 		\
	strops.o 	\
	telaxes.o	\
	telenv.o	\
	telfits.o	\
	telfifo.o   \
	tts.o

libmisc.so:	$(OBJS) $(wildcard *.h)
	$(CC) -shared -o $@ $(OBJS) -L$(inst_dir) $(CAMERA_LIBS)



.PHONY: clean
clean:
	rm -f *.o libmisc.so

.PHONY: install
install:
	cp libmisc.so $(inst_dir)


