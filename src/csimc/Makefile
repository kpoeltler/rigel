#gcc csimc.c -I../libwcs -I../libfs -I../libastro -I../libfits -I../libmisc  -MM -MT csimc.o
#csimc.o: csimc.c ../libmisc/strops.h ../libmisc/telenv.h \
# ../libmisc/csimc.h ../libmisc/configfile.h el.h mc.h

include ../common.mk

CFLAGS := -I../libwcs -I../libfs -I../libastro -I../libfits -I../libmisc $(CFLAGS)
LDFLAGS=  -L$(inst_dir)
LIBS = -lmisc -lfits -lastro -lwcs -lfs -lm

src = $(wildcard *.c)
obj = $(src:.c=.o)
dep = $(obj:.o=.d)

.PHONY: all
all: csimc csimcio

-include $(dep)

csimc: csimc.o boot.o eintrio.o el.o
	@echo top_dir = $(top_dir)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)


csimcio: csimcio.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)


eltest: el.o
	$(CC) $(CFLAGS) -DTESTEL -o eltest el.c


.PHONY: clean
clean:
	rm -f *.o *.d csimc csimcio eltest

.PHONY: install
install:
	cp csimc csimcio $(inst_dir)
