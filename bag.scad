//
// Copyright (c) Stewart H. Whitman, 2020-2021.
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
function bag_add(bag,item) = assert( is_list(bag) ) is_undef(item) ? bag : concat( bag, item );

// bag_size:
//
// Returns the size of <bag>.
//
function bag_size(bag) = assert( is_list(bag) ) len( bag );

// bag_is_empty:
//
// Returns true if <bag> is empty.
//
function bag_is_empty(bag) = assert( is_list(bag) ) len(bag) == 0;

// bag_contains:
//
// Returns true if <item> is in <bag>.
//
function bag_contains(bag,item) = bag_count( bag, item ) != 0;

// bag_contains_bag:
//
// Returns true if all members of <bag2> are in <bag>.
//
function bag_contains_bag(bag,bag2) = assert( is_list(bag) ) assert( is_list(bag2) ) len( [ for( i = bag2 ) if( bag_contains( bag, i ) ) true ] ) == len( bag2 );

// bag_count:
//
// Returns the number of times <item> is in <bag>.
//
function bag_count(bag,item) = assert( is_list(bag) ) len( [ for( i = bag ) if( i == item ) true ] );

// bag_max_count:
//
// Returns the maximum count of duplicates in <bag>.
//
function bag_max_count(bag) = bag_is_empty(bag) ? 0 : max( [ for( i = bag ) bag_count(bag,i) ] );

// bag_is_set:
//
// Return true if <bag> contains no duplicates.
//
function bag_is_set(bag) = bag_max_count(bag) <= 1;
