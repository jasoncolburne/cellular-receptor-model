// read receptor.scad

// parameters

receptor_radius = 50;
receptor_rim_height = 5;
receptor_rim_top_thickness = 9.9;
receptor_rim_bottom_thickness = receptor_rim_top_thickness + 2.5;
receptor_rim_cut_top_width = 10.2;
// this is a snowflake (all other values are multiples of 2.5)
receptor_rim_cut_bottom_width = receptor_rim_cut_top_width - 4;
receptor_rim_cut_depth = 25;

stabbing_pyramid_base_width = 20;
stabbing_pyramid_height = 50;

base_radius = 20;
base_height = 20;

resolution = 512;
tolerance = 1.02;

font_size = 8;
label_depth = 0.2;

$fn=resolution;
