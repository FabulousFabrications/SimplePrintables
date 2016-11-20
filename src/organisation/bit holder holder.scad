count = 5;
depth = 5;
offset = 3;
thickness = 1.2;
width = 10.05;
length = 40;

// Doesn't work properly yet
angle = 0;

module holder(i) {
	h = depth+thickness + (count-i)*offset;
	translate([0, i*(width+thickness), 0])
	difference() {
		union() {
			translate([0, 0, h/2]) cube([length+thickness*2, width+thickness*2, h], center=true);
			if (angle != 0 && i == count-1) {
				translate([0, 0, 0]) cube([length+thickness*2, width+thickness*2, h], center=true);
			}
		}
		translate([0, 0, h-depth/2]) cube([length, width, depth+0.001], center=true);
	}
}

module full() {
	for (i = [0:count-1]) {
		holder(i);
	}
}

if (angle != 0) {
	render()
	difference() {
		translate([0, 0, -(count-1)*offset])
		rotate([angle, 0, 0])
		full();
		translate([0, 0, -500])
		cube([1000, 1000, 1000], center=true);
	}
} else {
	full();
}
