# wyse-5070-stand
This is a 3D-Printable [Openscad](https://openscad.org/) model of a stand for the [Dell Wyse 5070 Thin Client](https://www.dell.com/en-us/work/shop/wyse-endpoints-and-software/wyse-5070-thin-client/spd/wyse-5070-thin-client) using the existing mounts in the case.

## Variations

There are three different variations: minimal, large, and mesh:

1. **Minimal**: is about the width of a slim 5070 with 4 legs and works well for the slim 5070.

2. **Large**: is very close in shape and style to the OEM stand.

3. **Mesh**: is like the large except that it has a mesh inset that looks like the 5070's textured surface.

The length of each stand is about the length of the 5070 (about 20cm), with Minimal being about a centimeter shorter than the Large.

## 3D Printing

I used a Creality Ender 3 Pro to build with a layer height of 0.20mm. Because the models are quite large, you may wish to do selective infill with structural areas set to high infill and non-structural much lower

The way to do this varies according to your slicing software. In Cura, you load a stand from _wyse-stand-XXX.stl_ and the infill model from _wyse-stand-infill.stl_. Turn off _Ensure Models are kept apart_ in settings. Select the _wyse-stand-infill_ model, and then use the _Per Model Settings_ and set that model to _Mesh Type: modify settings for overlap_. Choose _Select Settings_ and modify infill to something close to 100%. Then all you have to do is align the two models to overlap the same positions on the build platform. Z-axis setting should be 0 for both; one of X or Y should be zero depending on rotation. Use the overhead view and align the models on the other axis. It should be plus or minus a few millimeters. And then you're set.

After a millimeter or two of base, you should be able to see the difference in infill if you've done it correctly.

## Also Available on Thingiverse

STL's are available on [Thingiverse](https://www.thingiverse.com/thing:4560865).
