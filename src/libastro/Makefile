# Makefile for the basic astronomy routines.

include ../common.mk


src = $(wildcard *.c)
obj = $(src:.c=.o)
dep = $(obj:.o=.d)

.PHONY: all
all: libastro.so

-include $(dep)

libastro.so: $(obj)
	$(CC) -shared -o $@ $^


.PHONY: clean
clean:
	rm -f *.o *.d libastro.a libastro.so

.PHONY: install
install:
	cp libastro.so $(inst_dir)
