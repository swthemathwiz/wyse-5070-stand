//
// Copyright (c) Stewart Whitman, 2020.
//
// File:    rounded.scad
// Project: Dell Wyse 5070 Stand
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    Rounded cube/cylinder utilities
//

// rounded_cube:
//
// Generate a cube of <size> with a round-over <radius> in
// the X/Y direction. Centered optionally like a cube.
//
module rounded_cube( size, radius, center=false ) {
  assert( is_num(size) || is_list(size) );
  assert( is_num(radius) && radius >= 0 );

  c = is_list(size) ? size : [size,size,size];

  assert( len(c) == 3 );
  assert( c.x > 2*radius );
  assert( c.y > 2*radius );

  translate( [0,0,center?-c.z/2:0] )
    linear_extrude( height=c.z )
      offset( r=radius )
	offset( delta=-radius )
	  square( [c.x,c.y], center=center ); 
} // end rounded_cube

// rounded_top_cylinder:
//
// Generate a cylinder with a rounded top, with <d,r,h> parameters
// like cylinder, but <radius> defines the round-over radius.
//
module rounded_top_cylinder(h,d,r,radius,center=false) {
  assert( is_num(h) && h > 0 );
  assert( (is_undef(r) || is_undef(d)) && (is_num(r) || is_num(d)) ); // Not both
  assert( is_num(radius) );
  assert( h > radius );

  cylinder_radius = is_undef(d) ? r : d/2;
  assert( cylinder_radius > radius );

  translate( [0,0,(center?-h/2:0)] )
    rotate_extrude()
      intersection() {
        offset( r=+radius ) offset( delta=-radius ) square( [ 2*cylinder_radius, 2*h ], center=true );
        square( [cylinder_radius,h] );
      }
} // end rounded_top_cylinder

// rounded_top_and_bottom_cylinder:
//
// Generate a cylinder with a rounded top and bottom, with <d,r,h> parameters
// like cylinder, but <radius> defines the round-over radius.
//
module rounded_top_and_bottom_cylinder(h,d,r,radius,center=false) {
  assert( is_num(h) && h > 0 );
  assert( (is_undef(r) || is_undef(d)) && (is_num(r) || is_num(d)) ); // Not both
  assert( is_num(radius) );
  assert( h > radius );

  cylinder_radius = is_undef(d) ? r : d/2;
  assert( cylinder_radius > radius );

  translate( [0,0,(center?-h/2:0)] )
    rotate_extrude() 
      intersection() {
        translate( [-cylinder_radius, 0 ] ) offset( r=+radius ) offset( delta=-radius ) square( [ 2*cylinder_radius, h ], center=false );
	square( [cylinder_radius,h] );
      }
} // end rounded_top_and_bottom_cylinder
