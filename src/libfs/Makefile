include ../common.mk

CFLAGS := -I../libmisc -I../libastro $(CFLAGS)

OBJS = gsc.o usno.o

libfs.so: $(OBJS) $(wildcard *.h)
	gcc -shared $(CFLAGS) -o $@ $(OBJS)

.PHONY: install
install:
	cp libfs.so $(inst_dir)

.PHONY: clean
clean:
	rm -f *.o libfs.so
