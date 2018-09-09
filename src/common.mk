
top_dir := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
# debug -g -ggdb
CFLAGS = -O2 -ffast-math -fPIC -Wall -std=c11
inst_dir = $(realpath $(top_dir)/../bin)
export CFLAGS top_dir inst_dir

%.d: %.c
	$(CC) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@

