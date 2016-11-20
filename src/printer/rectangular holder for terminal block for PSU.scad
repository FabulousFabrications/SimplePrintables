//88.1 18.7 

use <../lib/util.scad>;

thickness = 1.2;
length = 88.1;
width = 18.7;
height = 2.5;
base_height = 1;
base_width = 10;

size = [length, width, height];
outer_size = size + repeat(thickness*2, 3) + [0, 0, base_height];

difference() {
	union() {
		cube(outer_size, center=true);  
		translate([0, 0, -outer_size[2]/2 + base_height/2]) cube([outer_size[0], outer_size[1] + base_width*2, base_height], center=true);
	}
	translate([0, 0, base_height/2+thickness+0.001]) cube(size + [0, 0, 0.002], center=true);
}