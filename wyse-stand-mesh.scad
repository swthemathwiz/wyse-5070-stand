//
// Copyright (c) Stewart Whitman, 2020.
//
// File:    wyse-stand-mesh.scad
// Project: Dell Wyse 5070 Stand
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    Invokes wyse-stand to generate with a mesh-style base
//

// Mesh version of wyse-stand
include <wyse-stand.scad>

// Show model mounted on the stand ("none", "slim", "extended")
box = "none"; // [ "none", "slim", "extended" ]

base = [ "mesh" ];
