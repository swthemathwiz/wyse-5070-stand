//
// Copyright (c) Stewart Whitman, 2020-2021.
//
// File:    wyse-5070-box.scad
// Project: Dell Wyse 5070 Stand
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    A mockup of the Wyse 5070 boxes (including final hole positions)
//

include <smidge.scad>

// wyse_5070_box:
//
// A 5070 of volume <v>, optionally clipped open at <clipz>
//
module wyse_5070_box(v,transparency = 0.5, clipz = 0) {
  // An approximation
  wall_thickness = 2;

  function dupXYZ(s) = [ s, s, s ];

  // keyhole_cutouts: openings for mount
  module keyhole_cutouts(v) {
    drill_thickness = wall_thickness+2*SMIDGE;
    slot_length = 10;

    // Note: Final locations the mounted 5070 ends up at (top center of keyhole)
    holes = [
	    // Front
            [v.x-58,v.y/2],
	    // Rear
            [24,v.y/2-10.25], [24,v.y/2+10.25]
          ];

    for( hole = holes ) {
      translate( concat( hole, -SMIDGE ) ) {
        cylinder( h=drill_thickness, d=3.6 );
        translate( [+slot_length/2, 0, drill_thickness/2] ) cube( [slot_length,3.6,drill_thickness], center=true );
        translate( [+slot_length, 0, 0] ) cylinder( h=drill_thickness, d=7.5 );
      }
    }
  } // end keyhole_cutouts

  // interior: interior volume of the box
  module interior(v) {
    interior_v = v - dupXYZ( 2*wall_thickness );
    translate( dupXYZ(wall_thickness) ) cube( interior_v );
  } // end interior

  // logo: mainly so that we can easily tell the front
  module logo(oem_name) {
    color("silver", transparency )
      rotate([+90,0,90])
	linear_extrude(1) {
	  text(oem_name, font = "Liberation Sans", halign = "center", valign = "center");
	}
  } // end logo

  // box: 5070 of given volume
  module box(v) {
    difference() {
      color( "black", transparency ) cube( v );
      keyhole_cutouts( v );
      interior( v );
    }
    translate( [v.x,v.y/2,20] ) logo("DELL");
  } // end box

  // Create box and clip if requested
  translate( [-v.x/2,-v.y/2,0] ) {
    intersection() {
      box(v);
      translate( dupXYZ( -SMIDGE ) ) cube( [v.x*2, v.y*2, clipz > 0 ? clipz : v.z*2 ] + dupXYZ( 2*SMIDGE ) );
    }
  }
} // end wyse_5070_box

// wyse_5070_slim:
//
// Slim 5070 mockup.
//
module wyse_5070_slim(transparency=0.5,clipz=0) {
  v = [ 184, 35.6, 184 ];
  wyse_5070_box(v,transparency,clipz);
} // end wyse_5070_slim

// wyse_5070_extended:
//
// Extended 5070 mockup.
//
module wyse_5070_extended(transparency=0.5,clipz=0) {
  v = [ 184, 66, 184 ];
  wyse_5070_box(v,transparency,clipz);
} // end wyse_5070_extended
