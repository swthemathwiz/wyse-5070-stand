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
PNGCRUSH = pngcrush -brute

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
RENDER.scad = $(OPENSCAD) -o $@ --render --colorscheme=Tomorrow --camera=-225,410,325,0,0,0
RENDERICON.scad = $(RENDER.scad) --imgsize=256,256

.PHONY: all images icons clean distclean

all: $(TARGETS)

images: $(IMAGES)

icons : $(ICONS)

%.stl : %.scad
%.stl : %.scad $(DEPDIR)/%.d | $(DEPDIR)
	$(COMPILE.scad) $<

%.unoptimized.png : %.scad
	$(RENDER.scad) $<

%.icon.unoptimized.png : %.scad
	$(RENDERICON.scad) $<

%.png : %.unoptimized.png
	$(PNGCRUSH) $< $@ || mv $< $@

clean:
	rm -f *.stl *.bak *.png

distclean: clean
	rm -rf $(DEPDIR)

$(DEPDIR): ; @mkdir -p $@

DEPFILES := $(TARGETS:%.stl=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))
