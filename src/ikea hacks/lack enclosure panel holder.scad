use <../lib/bevel.scad>;
use <../lib/hole.scad>;

glass_thickness = 3;
length = 25;
width = 20;
thickness = 2.4;
hole = 3.5;
glass_width = 5;
$fn = 50;
other_width = width - glass_width;

translate([0, -other_width, 0]) difference() {
	cube([length, other_width, thickness]);
	translate([length-hole*2, (other_width-thickness*1.5)/2, thickness]) hole(hole, thickness);
	translate([hole*2, (other_width-thickness*1.5)/2, thickness]) hole(hole, thickness);
}
translate([0, -thickness, thickness]) rotate([90, 0, 0]) bevel(length, thickness/2);
difference() {
	translate([0, -thickness, 0]) cube([length, thickness, glass_thickness+thickness]);
	translate([-1, -thickness, thickness+glass_thickness]) rotate([270, 0, 0]) bevel(length+2, thickness/2);
}
translate([0, 0, glass_thickness]) {
	cube([length, glass_width, thickness]);
	translate([0, -thickness, thickness]) rotate([270, 0, 0]) bevel_inv(length, thickness);
}
