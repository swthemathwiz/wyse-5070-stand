#
# Copyright (c) Stewart Whitman, 2020.
#
# File:    Makefile
# Project: Dell Wyse 5070 Stand
# License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
# Desc:    Makefile for directory 
#

SOURCES = wyse-stand-infill.scad wyse-stand-mesh.scad wyse-stand-large.scad wyse-stand-minimal.scad wyse-stand.scad wyse-5070-box.scad

STANDS = wyse-stand-infill.scad wyse-stand-mesh.scad wyse-stand-large.scad wyse-stand-minimal.scad
 
TARGETS = $(STANDS:.scad=.stl)

IMAGES = $(STANDS:.scad=.png)

%.stl : %.scad wyse-stand.scad wyse-5070-box.scad
	openscad -o $@ $<

%.png : %.scad wyse-stand.scad wyse-5070-box.scad
	openscad -o $@ $<

all: $(TARGETS)

images: $(IMAGES)

clean:
	rm -f *.stl *.bak

distclean:
	rm -f *.png
