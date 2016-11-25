// LACK table has horizontal inner dimension of 450mm and vertical of 40mm. This extender increases vertical by 50mm to match

use <../lib/hole.scad>;
use <../lib/shapes.scad>

$fn = 50;

d = 50.5;
h = 50;
hole = 3.5;
extension = hole * 3;
thickness = 1.2;

cube([d, d, h]);
translate([0, -extension, 0]) base_extension();
rotate(90) base_extension();
translate([-extension, -extension, 0]) cube([extension, extension, thickness]);

translate([0, -thickness, h]) top_extension();
translate([-thickness, 0, h]) scale([-1, 1, 1]) rotate(90) top_extension();
translate([-thickness, -thickness, h]) cube([thickness, thickness, extension]);

module base_extension(b=false) {
	difference() {
		cube([d, extension, thickness]);
		translate([d - extension, extension/2, thickness]) #hole(hole, thickness, 1);
		translate([extension, extension/2, thickness]) #hole(hole, thickness, 0.5);
	}
	if(b) {
		rotate([180, 0, 90]) prism(thickness, d, thickness, false);
		rotate([180, 180, 90]) prism(thickness, d, thickness, false);
		//bevel(d, thickness);
	}
}

module top_extension() {
	translate([0, thickness, 0]) rotate([90, 0, 0]) base_extension(true); 
	//cube([d, thickness, extension]);
}