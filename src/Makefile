# kernel module needs installed: fliusb-1.3.2


SECTIONS = libastro libfits libmisc libfs libwcs csimc csimcd rund

.PHONY: $(SECTIONS) all clean install

include common.mk

all: $(SECTIONS)


$(SECTIONS):
	$(MAKE) -C $@

clean:
	@for dir in $(SECTIONS); do \
	  $(MAKE) -C $$dir clean; \
	done

install:
	@for dir in $(SECTIONS); do \
	  $(MAKE) -C $$dir install; \
	done

