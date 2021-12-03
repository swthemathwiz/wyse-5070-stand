//
// Copyright (c) Stewart Whitman, 2020-2021.
//
// File:    wyse-5070-box.scad
// Project: Dell Wyse 5070 Stand
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    A mockup of the Wyse 5070 boxes (including final hole positions)
//

include <smidge.scad>

module wyse_5070_box(v,transparency = 0.5, clipz = 0) {
  wall_thickness = 2;

  module drill_slot_cutouts(v) {
    drill_thickness = wall_thickness+2*SMIDGE;
    slot_length = 10;

    // Note: these are the final locations that the mounts are below
    holes = [
	    // Front hole
            [v.x-58,v.y/2],
	    // Rear holes
            [24,v.y/2-10.25], [24,v.y/2+10.25]
          ];

    for( hole = holes ) {
      translate( concat( hole, -SMIDGE ) ) {
        cylinder( h=drill_thickness, d=3.6 );
        translate( [+slot_length/2, 0, drill_thickness/2] ) cube( [slot_length,3.6,drill_thickness], center=true );
        translate( [+slot_length, 0, 0] ) cylinder( h=drill_thickness, d=7.5 );
      }
    }
  } // end drill_slot_cutouts

  module interior(v) {
    i = v - 2*[wall_thickness,wall_thickness,wall_thickness];
    translate( [wall_thickness, wall_thickness, wall_thickness] ) cube( i );
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
	drill_slot_cutouts( v );
        interior( v );
      }
      translate( [v.x,v.y/2,20] ) logo();
    }
  } // end main

  translate( [-v.x/2,-v.y/2,0] ) {
    intersection() {
      main(v);
      translate( [-SMIDGE,-SMIDGE,-SMIDGE] ) cube( [v.x*2, v.y*2, clipz > 0 ? clipz : v.z*2 ] + 2*[SMIDGE,SMIDGE,SMIDGE] );
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
