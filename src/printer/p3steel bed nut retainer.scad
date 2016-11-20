width = 9.9;
length = width * 1.25;
hole = 3;
thickness = 4.8;
height = thickness * 2.25;

use <../lib/hole.scad>;

h = height - thickness;
l = length - width/2;

module retainer_inner(t, w, l) {
	linear_extrude(t) {
		circle(d=w);
		translate([-l/2, 0, 0]) square([l, w], center=true);
	}
}

translate([0, 0, thickness]) difference() {
	retainer_inner(h, width+thickness, l);
	translate([0, 0, -0.001]) retainer_inner(h+0.002, width, l+0.002);
}

difference() {
	retainer_inner(thickness, width+thickness, l);
	translate([0, 0, -0.001]) cylinder_outer(thickness+0.002, hole);
	translate([0, 0, thickness/3]) nut_trap(5.45, thickness * 2/3 + 0.01, 6);
}
