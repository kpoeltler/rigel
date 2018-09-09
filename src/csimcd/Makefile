
include ../common.mk

CFLAGS := -I../libmisc $(CFLAGS)
LIBS=-L$(inst_dir) -lmisc -lfits -lastro -lm -lsqlite3

csimcd: csimcd.o
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

.PHONY: install
install:
	cp csimcd $(inst_dir)

.PHONY: clean
clean:
	rm -f *.o csimcd

