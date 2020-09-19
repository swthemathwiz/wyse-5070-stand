//
// Copyright (c) Stewart Whitman, 2020.
//
// File:    wyse-stand.scad
// Project: Dell Wyse 5070 Stand
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    The stand and all it's variations.
//

use <wyse-5070-box.scad>
include <bag.scad>
include <rounded.scad>

// box: show a version mounted on the stand ("none", "slim", "extended")
boxstyles = [ "none", "slim", "extended" ];
box = "none";

// infillonly: option to generate map of areas that need high-infill
infillonly = false;

// base styles:
basestyles = [ "large", "mesh", "minimal", "round", "roundover", "long" ];
base = [ "minimal", "roundover" ];

// wing styles (only used for "minimal" style)
wingstyles = [ "angled", "side", "round", "straight" ];
wing = [ "side", "straight" ];

// Round-over for nubs/posts as a percentage of radius
roundover=15;

// Round-over for the top of a base as a percentage of height (only when option "roundover" is specified)
baseroundover=15;

// Dell OEM stand size:
//   Rectangular 205mm x 75mm
//   7mm depth including 4 rubber feet on each corner
//   5mm without feet
//
size = [205,75,7];

// round_top_cylinder:
//
// Generate a cylinder with a rounded top.
//
module round_top_cylinder(d,h,ro=roundover) {
  rounded_top_cylinder(d=d,h=h,radius=d*ro/200);
} // end round_top_cylinder

// round_top_and_bottom_cylinder:
//
// Generate a cylinder with a rounded top and bottom.
//
module round_top_and_bottom_cylinder(d,h,ro=roundover) {
  rounded_top_cylinder(d=d,h=h,radius=d*ro/200);
} // end round_top_and_bottom_cylinder

// round_top_cube:
//
// Rounded top cube.
//
module round_top_cube(v,ro=baseroundover,center=false) {
  round_top_volume(v, ro, center ? [0,0,0] : v/2 ) cube(v,center=center);
} // end round_top_cube

// round_top_volume:
//
// Operates on its children creating a roundover effect based
// on percentage of height. Operations are:
//    1. Translate volume to origin
//    2. Scale X-Y down by volume based-on the radius to be added
//    3. Minkowski with sphere adding 2*radius in all dimensions
//    4. Remove rounded over bottom radius:
//     a. Translate down a radius
//     b. Intersect with full volume
//    5. Restore volume to origin
//
module round_top_volume(v,ro=baseroundover,c=[0,0,0]) {
  p = v.z*ro/100;

  if( p != 0 ) {
    d = v - [2*p, 2*p, 0];
    s = [d.x/v.x, d.y/v.y, d.z/v.z ];

    translate(c) intersection() {
      cube( v, center=true );
      translate([0, 0, -p ] ) minkowski() {
	scale( s ) translate(-c) children();
	sphere( r=p );
      }
    }
  }
  else
    children();
} // end round_top_volume

// nub:
//
// A nub is a little rounded off cylinder. If the base
// is mesh, the we add a solid round platform below.
//
module nub() {
  // Diameter: 9.85mm Height 5.5mm
  union() {
    round_top_cylinder( d=9.85, h=5.5 );
    if( bag_contains(base,"mesh") || infillonly ) {
      translate( [ 0, 0, -size.z] ) cylinder( r2=9.85/2, r1=15/2, h=size.z );
    } 
  }
} // end nub

// post:
//
// A post is a little 'T' on top of a nub.
//
module post() {
  union() {
    // Base is a nub
    nub();

    // Base Diameter: 3.65mm Base Height : 3.6mm
    translate( [0,0,5.5] ) cylinder( r=3.65/2, h=3.6 );

    // Top Diameter: 6.8mm  Top Height: 2mm  
    translate( [0,0,5.5+3.6] ) round_top_and_bottom_cylinder( d=6.8, h=2.0 );
   }
} // end post

// add_to_base:
//
// Add a surface feature (e.g. a post) to the base. The position
// is an (X,Y) pair relative to the center.
//
module add_to_base(pos) {
  translate([pos.x,pos.y,size.z]) children();
} // end add_to_base

// rectangle:
//
// Cut-out a solid rectangular frame.
//
module rectangle(v,width=0) {
  w = width <= 0 ? v.z : width;

  //round_top_volume( v, bag_contains(base,"roundover") ? baseroundover : 0 )
  difference() {
    round_top_cube( v, bag_contains(base,"roundover") ? baseroundover : 0, center=true );
    //cube( v, center=true );
    if( v.y > w && v.x > w ) {
      cube( [v.x-2*w, v.y-2*w, v.z*2], center=true );
    }
  }
} // end rectangle

// meshline:
//
// Generate a mesh line.
//
module meshline(recess) {
  simple = false;

  w = 2;
  h = size.z-recess;
  l = 2*min(size.x,size.y); // It doesn't have to be exact (just big)

  if( simple ) {
    cube( [ w, l, h ], center=true );
  }
  else {
    partition=0.2;
    angle=30;

    profile = [ [0,0], [0,h], [w*partition,h], [w,h-(w-w*partition)*cos(angle)], [w,0] ];
    translate( [-l/2,0,0] ) rotate( [90,0,0] ) rotate( [0,90,0] )
       linear_extrude( height=l, $fn = 8 ) translate( [-w/2,-h/2] ) polygon( profile );
  }
} // end meshline

// mesh_position:
//
// Position the radiating wings
//
module meshposition(i,r,s)
{
  intersection() {
    translate( [i*s/cos(90+r),0,0] ) rotate( [0,0,r] ) children();
    cube( size, center = true );
  }
} // end meshposition

// mesh:
//
// Generate an approximation of Dell Wyse 5070 style mesh.
//
// Mesh is a 5mm diamond
//   5 mm diamond mesh with bars being 2mm wide
//
module mesh() {
  step   = 5;
  count  = max( size.y, size.x ) / step + 2;
  recess = 2; // Below the enclosing frame by this amount

  translate( [0, 0, -recess/2 ] )
    union() {
      for( i = [-count/2 : +count/2] ) {
	meshposition( i, +30, 5 ) meshline(recess);
	meshposition( i, -30, 5 ) meshline(recess);
      }
  }
} // end mesh

// Measurements were taken for the layout of the posts & nubs based
// on the OEM stand from the front and rear. So the use of 205 explicitly
// (the OEM base size) is correct here.
//
// These functions adjust the positions to be center-relative. No matter
// what size you choose for the base, the posts & nubs remain at the
// same relative position.
//
function relative_to_front(x) = 205/2-x;
function relative_to_rear(x) = -205/2+x;

// minimalwing:
//
// Generate the supporting "wings" of the smaller base.
//
module minimalwing(w,l,i) {
  assert( i>=0 && i<=3 );

  v = [w, l, size.z];

  rotate( [ 0, 0, bag_contains( wing, "side" ) ? i*180 : (i*90+45) ] )
    translate( [0,-l/2,0] ) {
      round_top_volume( v, bag_contains(base,"roundover") ? baseroundover : 0 ) 
	if( bag_contains( wing, "round" ) ) { 
	  r = w/2;
	  translate( [0,+r/2,0] ) cube( [w, l-r, size.z], center=true ); 
	  translate( [0,-l/2+r,0] ) cylinder( r=r, h=size.z, center=true );
	}
	else
	  cube( v, center=true ); 
    }
} // end minimalwing

// minimal:
//
// Generate a smaller base that looks something like:
//
// \ /
//  |
// / \
//
module minimal() {
  // 1x Front Post (F): 68.75mm from front, on center line 
  // 2x Rear Posts (R): 35mm from end, 20.25mm apart (10.125mm off Y-center)
  // 2x Nubs: inline with rear posts (10.125 off center)
  //          in front of front post by 26.5mm (not critical) 
  front_origin_X = relative_to_front( 68.5-26.5 ); 
  rear_origin_X  = relative_to_rear( 35 ); 

  // Seems like width is arbitrary as long as it is large enough
  // to hold the surface features (posts/nibs), but, N.B.:
  //    the slim machine itself is about this wide (36mm)
  //    the distance from rear post centers to end of machine is ~24mm 
  //    the distance from the front post center to the front of the machine is ~57mm 
  //    the distance of the nibs from the front of the machine is ~42mm
  //    the total length of the machine is ~182mm
  // so we scale to 184mm - ~2mm ahead and behind the machine
  w = 38;
  h = size.z;
  l = front_origin_X - rear_origin_X + w;
  addon_front = 182 - l + 2;
  addon_rear  = 13; // old: zero

  v = [l+addon_front+addon_rear,w,h];
  c = [(addon_front+front_origin_X+rear_origin_X-addon_rear)/2,0,0];

  echo(["total length = ", v.x ] );

  round_top_volume( v, bag_contains(base,"roundover") ? baseroundover : 0, c ) {
    if( bag_contains( base,"round") ) {
      // At front
      translate( [front_origin_X+addon_front, 0, 0 ] ) cylinder( r=w/2, h=h, center=true );
      // At rear
      translate( [rear_origin_X-addon_rear, 0, 0 ] ) cylinder( r=w/2, h=h, center=true );
      // Fill in space in between the islands
      translate(c) cube( [l+addon_front+addon_rear-w, w, h], center=true );
    }
    else {
      translate(c) cube( v, center=true );
    }
  }

  // Wings:
  //
  // All these are mostly aesthetics...
  //
  // N.B.: Wings start at the X-axis (so ~w/2 or length is already in the body)
  //
  {
    wing_length  = bag_contains(wing,"angled") ? w*1.75 : w*1.2; // old: w*1.5 : w 
    wing_offset  = bag_contains(wing,"angled") ? v.x/3 : v.x/5; //w/2.5;
    wing_width   = w/2;
    front_wing_X = bag_contains(wing,"angled") ? front_origin_X+w/2+addon_front-wing_offset : front_origin_X;
    rear_wing_X  = bag_contains(wing,"angled") ? rear_origin_X-w/2-addon_rear+wing_offset : rear_origin_X;

    translate( [front_wing_X, 0, 0 ] ) minimalwing( wing_width, wing_length, 0 );
    translate( [front_wing_X, 0, 0 ] ) minimalwing( wing_width, wing_length, 1 );
    translate( [rear_wing_X, 0, 0 ] ) minimalwing( wing_width, wing_length, 2 );
    translate( [rear_wing_X, 0, 0 ] ) minimalwing( wing_width, wing_length, 3 );

    echo(["total width = ", 2 * wing_length / (bag_contains(wing,"angled") ? sqrt(2) : 1) ] );
  }
} // end minimal

// bottom:
//
// The bottom (everything below the posts & nubs) - 3 different types.
//
module bottom() {
  if( bag_contains( base, "mesh" ) ) {
    union() {
      mesh();
      rectangle( size, size.z/2 );
    }
  }
  else if( bag_contains( base, "minimal" ) ) {
    $fn = bag_contains( base,"round") || bag_contains( wing, "round" ) ? 60 : $fn; 
    minimal();
  }
  else {
    round_top_cube( size, bag_contains(base,"roundover") ? baseroundover : 0, center=true );
  }
} // end bottom

// stand:
//
// Build the full stand.
//
module stand() {
  union() {
    // Build the bottom
    if( !infillonly )
      translate( [0,0,+size.z/2] ) bottom();

    {
      $fn = infillonly ? $fn : 60;

      // 1x Front Post (F): 68.75mm from front, on center line 
      add_to_base( [ relative_to_front( 68.75 ),0] ) post();

      // 2x Rear Posts (R): 35mm from end, 20.25mm apart (10.125mm off Y-center)
      add_to_base( [ relative_to_rear( 35 ),+10.125] ) post();
      add_to_base( [ relative_to_rear( 35 ),-10.125] ) post();

      // 2x Nubs: inline with rear posts (10.125 off center)
      //          in front of front post by 26mm (not critical) 
      add_to_base( [relative_to_front( 68.75-26.75 ),+10.125] ) nub();
      add_to_base( [relative_to_front( 68.75-26.75 ),-10.125] ) nub();
    }

    if( !infillonly ) {
      // Clipping here to see how the mounts align...
      if( box == "slim" ) {
	translate( [relative_to_rear( 35 )+184/2-24,0,size.z+5.5] ) wyse_5070_slim(clipz=60);
      }
      else if( box == "extended" ) {
	translate( [relative_to_rear( 35 )+184/2-24,0,size.z+5.5] ) wyse_5070_extended(clipz=60);
      }
    }
  }
} // end stand

// Sanity check
assert( bag_contains(boxstyles,box) );
assert( bag_contains_bag(basestyles,base) );
assert( bag_contains_bag(wingstyles,wing) );
assert( (bag_contains(basestyles,"large") ? 1 : 0) +
        (bag_contains(basestyles,"minimal") ? 1 : 0) +
        (bag_contains(basestyles,"mesh") ? 1 : 0) > 1 );
assert( bag_contains_bag(wingstyles,wing) );
assert( !(bag_contains(wing,"angled") && bag_contains(wing,"side")) );
assert( !(bag_contains(wing,"round") && bag_contains(wing,"straight")) );

// The same infill map should work for all since all posts/nubs stay
// at the same location.
if( infillonly ) {
  // 1.5 mm of padding added so you don't have to align perfectly
  pad = 1.5;
  intersection() {
    minkowski() {
      stand();
      sphere( r=pad );
    }
    // Cut-off any below Z-axis so the infill sits flat
    translate( [0,0,100] ) cube( [size.x,size.y,200], center=true);
  }
}
else {
  stand();
}
