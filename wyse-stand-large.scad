//
// Copyright (c) Stewart Whitman, 2020-2021.
//
// File:    wyse-stand-large.scad
// Project: Dell Wyse 5070 Stand
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    Invokes wyse-stand to generate a large OEM-like base
//

// Large version of wyse-stand
include <wyse-stand.scad>

// Show model mounted on the stand ("none", "slim", "extended")
box = "none"; // [ "none", "slim", "extended" ]

base = [ "large", "roundover" ];
