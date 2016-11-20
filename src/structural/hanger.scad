use <../lib/hole.scad>;

w = 20;
h = 20;
l = 15;
thickness = 3.6;
hanger = 18;
d = 3.5;
both_sides = true;

difference() {
	cube([w+thickness*2, l, h+thickness]);
	translate([thickness,-0.001, -0.001]) cube([w, l+0.002, h+0.002]);
}

bottom();

if (both_sides) {
	translate([w+thickness, 0, 0]) bottom();
}

module bottom() {
	difference() {
		translate([0, 0, -hanger+0.001]) cube([thickness, l, hanger+0.001]);
		translate([0, l/2, -(hanger-d*2)]) rotate([0, 90, 0]) translate([0, 0, -0.001]) cylinder_outer(d=5, h=thickness+0.002);
	}
}
