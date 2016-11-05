use <lib/hole.scad>;

module angle_bracket(a = 30, b = 30, h = 50, thickness = 3.6, d = 3, angle = 90) {
	angle_bracket_side(a, h, thickness, d);
	rotate(angle) scale([1, -1, 1]) angle_bracket_side(a, h, thickness, d);
}

module angle_bracket_side(a, h, thickness, d) {
	difference() {
		cube([a, thickness, h]);
		translate([a*1/3, 0, d]) rotate([90, 0, 0]) hole(d, thickness);
		translate([a*2/3, 0, d]) rotate([90, 0, 0]) hole(d, thickness);
		translate([a*1/3, 0, d+h/4]) rotate([90, 0, 0]) hole(d, thickness);
		translate([a*2/3, 0, d+h/4]) rotate([90, 0, 0]) hole(d, thickness);
		translate([a*1/3, 0, h-d]) rotate([90, 0, 0]) hole(d, thickness);
		translate([a*2/3, 0, h-d]) rotate([90, 0, 0]) hole(d, thickness);
		translate([a*1/3, 0, h-(d+h/4)]) rotate([90, 0, 0]) hole(d, thickness);
		translate([a*2/3, 0, h-(d+h/4)]) rotate([90, 0, 0]) hole(d, thickness);
	}
}

angle_bracket();