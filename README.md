# wyse-5070-stand

## Introduction

This is a 3D-Printable [OpenSCAD](https://openscad.org/) model of a stand for
the [Dell Wyse 5070 Thin Client](https://www.dell.com/en-us/work/shop/wyse-endpoints-and-software/wyse-5070-thin-client/spd/wyse-5070-thin-client)
using the existing mounts in the case.

![Image of Stand with 5070 Mounted](../media/media/stand-side-view.jpg "Image of Stand with 5070 Mounted")

## Models and Variations

There are three different stand variations: Minimal, Large, and Mesh.

<div class="model" data-name="Minimal Stand" data-icon-size="128" data-left-icon="wyse-stand-minimal.icon.png" data-left="wyse-stand-minimal.stl"><!-- expanded by annotate-model --><table align="center" width="100%"><tbody><tr width="100%"><td align="center" width="160" height="160"><a href="../media/media/wyse-stand-minimal.stl" target="_blank" title="View Minimal Stand Model"><img src="../media/media/wyse-stand-minimal.icon.png" alt="Minimal Stand Model" width="128" height="128" /></a></td><td>

### Minimal

The minimal stand is about the same width and length as a slim 5070 with
four legs that point out to the side. It works well for the slim 5070.

</td></tr></tbody></table></div>

<div class="model" data-name="Large Stand" data-icon-size="128" data-left-icon="wyse-stand-large.icon.png" data-left="wyse-stand-large.stl"><!-- expanded by annotate-model --><table align="center" width="100%"><tbody><tr width="100%"><td align="center" width="160" height="160"><a href="../media/media/wyse-stand-large.stl" target="_blank" title="View Large Stand Model"><img src="../media/media/wyse-stand-large.icon.png" alt="Large Stand Model" width="128" height="128" /></a></td><td>

### Large

The large stand is very close to the OEM stand in shape, size, and style. Like the
OEM stand it is about 20 cm x 7.5 cm.

</td></tr></tbody></table></div>

<div class="model" data-name="Mesh Stand" data-icon-size="128" data-left-icon="wyse-stand-mesh.icon.png" data-left="wyse-stand-mesh.stl"><!-- expanded by annotate-model --><table align="center" width="100%"><tbody><tr width="100%"><td align="center" width="160" height="160"><a href="../media/media/wyse-stand-mesh.stl" target="_blank" title="View Mesh Stand Model"><img src="../media/media/wyse-stand-mesh.icon.png" alt="Mesh Stand Model" width="128" height="128" /></a></td><td>

### Mesh

The mesh stand is the same size as large except that it has a mesh inset that
mimics the 5070's textured surface.

</td></tr></tbody></table></div>

## Source

The model is built using OpenSCAD. *wyse-stand.scad* is the main file for all
stands, with the *wyse-stand-XXX.scad* files creating a particular variation of
stand.

## Printing

I use a Creality Ender 3 Pro to build with a layer height of 0.20mm. Because the
models are quite large, you may wish to do selective infill with structural
areas (nubs and posts) set to high infill and non-structural much lower. This
saves filament and time. The way to do this varies according to your slicing
software. In Cura:

1.  Load one of the stand models from *wyse-stand-XXX.stl* and set infill to a
    low value (something between 5% to 10%).
2.  Load the infill model from *wyse-stand-infill.stl* which contains only nubs
    and posts.
3.  Select the *wyse-stand-infill* model, and then use the **Per Model Settings**
    and set that model to **Mesh Type: modify settings for overlaps**.
    Choose **Select settings**, turn on **Infill Density**, and
    modify infill density to a high value (something between 50% and 100%).
4.  From the main menu, choose **Preferences** → **Configure Cura...** →
    **General** and disable **Ensure Models are kept apart**.
5.  Align the two models so that they overlap at the same positions on the build
    plate. The nubs and post should match up. Z-axis setting should be 0 for
    both; one of X or Y should be zero depending on rotation. Use the overhead
    view and align the models on the other axis. Alignment accuracy is not
    critical - it can be plus or minus a few millimeters.

After a millimeter or two of base, you should be able to observe the difference
in infill if you've done it correctly.

## Also Available on Thingiverse

STLs are available on [Thingiverse](https://www.thingiverse.com/thing:4560865).
