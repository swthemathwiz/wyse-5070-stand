//
// Copyright (c) Stewart H. Whitman, 2020.
//
// File:    bag.scad
// Project: Dell Wyse 5070 Stand
// License: CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)
// Desc:    A rough implementation of a bag based on an array (set that allows duplicates)
//

// bag_initialize:
//
// Returns initialization of a bag. 
//
function bag_initialize() = [];

// bag_add:
//
// Add <item> to <bag>.
//
function bag_add(bag,item) = concat( bag, item );

// bag_size:
//
// Returns the size of <bag>.
//
function bag_size(bag) = len( bag );

// bag_is_empty:
//
// Returns true if <bag> is empty.
//
function bag_is_empty(bag) = len(bag) == 0;

// bag_contains:
//
// Returns true if <item> is in <bag>.
//
function bag_contains(bag,item,_i=0) = (len(bag) <= _i) ? false : (item == bag[_i] ? true : bag_contains(bag,item,_i+1));

// bag_contains_bag:
//
// Returns true if all members of <bag2> are in <bag>.
//
function bag_contains_bag(bag,bag2,_i=0) = (len(bag2) <= _i) ? true : (bag_contains(bag,bag2[_i]) ? bag_contains_bag(bag,bag2,_i+1) : false);

// bag_count:
//
// Returns the number of times <item> is in <bag>.
//
function bag_count(bag,item,_i=0) = (len(bag) <= _i) ? 0 : ((item == bag[_i] ? 1 : 0) + bag_count(bag,item,_i+1));

// bag_max_count:
//
// Returns the maximum count of duplicates in <bag>.
//
function bag_max_count(bag,_i=0,_m=0) = (len(bag) <= _i) ? _m : _m >= bag_count( bag, bag[_i] ) ? bag_max_count( bag,_i+1,_m ) : bag_max_count( bag, _i+1, bag_count( bag, bag[_i] ) ); 

// bag_is_set:
//
// Return true if the bag contains no duplicates.
//
function bag_is_set(bag) = bag_max_count(bag) <= 1;
