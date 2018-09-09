include ../common.mk

CFLAGS := -I../libmisc $(CFLAGS)
LIBS = -L$(inst_dir) -lmisc -lastro -lfits -lm -lsqlite3


rund: rund.o
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

.PHONY: install
install:
	cp rund $(inst_dir)

.PHONY: clean
clean:
	rm -f *.o rund

