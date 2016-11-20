use <../lib/hole.scad>;

h=6;

difference() {
	union() {
		translate([7, 7, 0]) cylinder(d=14, h=h);
		cube([40, 40, 2]);
	}
	translate([7, 7, -0.001]) {
		nut_trap(8, 4, 6.001);
		cylinder_outer(d=5, h=h + 0.002);
	}
}