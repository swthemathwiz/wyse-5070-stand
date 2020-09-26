//
// Copyright (c) Stewart Whitman, 2020.
//
// File:    wyse-5070-box.scad
// Project: Dell Wyse 5070 Stand
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    A mockup of the Wyse 5070 boxes (including final hole positions)
//

module wyse_5070_box(v,transparency = 0.5, clipz = 0) {

  // Note: these are really the interior spots of the drill holes
  module drill_holes(v) {
    // Front holes
    translate( [v.x-58,v.y/2,-0.001] ) cylinder( h=6, r=5 ); 
    // Rear holes
    translate( [24,v.y/2-10.25,-0.001] ) cylinder( h=6, r=5 ); 
    translate( [24,v.y/2+10.25,-0.001] ) cylinder( h=6, r=5 ); 
  } // end drill_holes

  module interior(v) {
    wall = 2;
    i = v - [2*wall,2*wall,2*wall];
    translate( [wall, wall, wall] ) cube( i );
  } // end interior

  // Mainly so that we can easily tell the front
  module logo() {
    t = "DELL";
    color("silver", transparency )
      rotate([+90,0,90])
	linear_extrude(1) {
	  text(t, font = "Liberation Sans", halign = "center", valign = "center");
	}
  } // end logo

  module main(v) {
    union() {
      difference() {
	color( "black", transparency ) cube( v );
	drill_holes( v );
        interior( v );
      }
      translate( [v.x,v.y/2,20] ) logo();
    }
  } // end main

  translate( [-v.x/2,-v.y/2,0] ) {
    intersection() {
      main(v);
      cube( [v.x*2, v.y*2, clipz > 0 ? clipz : v.z*2 ] );
    }
  }
} // end wyse_5070_box

module wyse_5070_slim(transparency=0.5,clipz=0) {
  v = [ 184, 35.6, 184 ];
  wyse_5070_box(v,transparency,clipz);
} // end wyse_5070_slim

module wyse_5070_extended(transparency=0.5,clipz=0) {
  v = [ 184, 66, 184 ];
  wyse_5070_box(v,transparency,clipz);
} // end wyse_5070_extended
