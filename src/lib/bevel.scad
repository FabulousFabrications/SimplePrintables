module bevel(l, s, oe=0.1) {
	scale([-1, 1, 1])
	rotate([0, -90, 0])
	linear_extrude(l)
	difference() {
		translate([-oe, -oe]) square([s+oe, s+oe]);
		translate([s, s]) circle(r=s, center=true);
	}
}


module bevel_inv(l, s) {
	scale([-1, 1, 1])
	rotate([0, -90, 0])
	linear_extrude(l)
	difference() {
		square([s, s]);
		difference() {
			square([s, s]);
			translate([s, s]) circle(r=s, center=true);
		}
	}
}