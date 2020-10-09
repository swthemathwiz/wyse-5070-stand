# wyse-5070-stand
This is a 3D-Printable Openscad model of a stand for the Dell Wyse 5070 Thin Client using
the existing mounts in the case.

## Variations

There are three different variations: minimal, large, and mesh.

1. Minimal: is about the width of a slim 5070 with 4 wings and works well for the slim 5070.

2. Large: is very close in shape and style to the OEM stand.

3. Mesh: is like the large except that it has a mesh inset that looks like the 5070's textured surface.

The length of each stand is about the length of the 5070 (about 20cm), with minimal being about a centimeter shorter than the large.

## 3D Printing

I used a Creality Ender 3 Pro to build with a layer height of 0.20mm. Because the models are quite large, you may wish to do
selective infill with structural areas with high infill, and non-structural much lower.

Select one of the different types of bases and set it to a low infill, then, overlay with the _wyse-infill-stand.stl_ and use it to designate a higher infill area.

The way to do this varies, but in Cura, you load the both the stand and the infill models, turn off _Ensure Models are kept apart_ in settings. Select the _wyse-infill-stand_ model, and
then use the _Per Model Settings_ to set that model to _Mesh Type: modify settings for overlap_. Choose _Select Settings_ and modify infill to something
close to 100%. Then all you have to do is align the two models to overlap the same positions on the build platform.
Z setting should be 0 for both; one of X or Y should be zero depending on rotation. Use the overhead view and align the models
on the other axis. It should be plus or minus a few millimeters. And then you're set.

After a millimeter or two of base, you should be able to see the difference in infill if you've done it correctly.

## Available on Thingiverse
https://www.thingiverse.com/thing:4560865
