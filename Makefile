#
# Copyright (c) Stewart Whitman, 2020-2021.
#
# File:    Makefile
# Project: Dell Wyse 5070 Stand
# License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
# Desc:    Makefile for directory
#

NAME = wyse-5070-stand

OPENSCAD = openscad

SRCS = \
	wyse-stand-infill.scad \
	wyse-stand-mesh.scad \
	wyse-stand-large.scad \
	wyse-stand-minimal.scad \
	wyse-stand.scad \
	wyse-5070-box.scad \
	bag.scad \
	rounded.scad \
	smidge.scad \

BUILDS = \
	wyse-stand-infill.scad \
	wyse-stand-mesh.scad \
	wyse-stand-large.scad \
	wyse-stand-minimal.scad \

EXTRAS = \
	Makefile \
	README.md \
	LICENSE.txt \

TARGETS = $(BUILDS:.scad=.stl)
IMAGES = $(BUILDS:.scad=.png)
ICONS = $(BUILDS:.scad=.icon.png)

DEPDIR := .deps
DEPFLAGS = -d $(DEPDIR)/$*.d

COMPILE.scad = $(OPENSCAD) -o $@ $(DEPFLAGS)
RENDER.scad = $(OPENSCAD) -o $@
RENDERICON.scad = $(OPENSCAD) -o $@ --colorscheme Tomorrow --imgsize=128,128

all: $(TARGETS)

images: $(IMAGES)

icons : $(ICONS)

%.stl : %.scad
%.stl : %.scad $(DEPDIR)/%.d | $(DEPDIR)
	$(COMPILE.scad) $<

%.png : %.scad
	$(RENDER.scad) $<

%.icon.png : %.scad
	$(RENDERICON.scad) $<

clean:
	rm -f *.stl *.bak *.png

distclean: clean
	rm -rf $(DEPDIR)

$(DEPDIR): ; @mkdir -p $@

DEPFILES := $(TARGETS:%.stl=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))
