function repeat(x, c) = [for (i = [1 : c]) x];

module cube_centered_xy(s) {
	translate([0, 0, s[2]/2]) cube(s, center=true);
}

module cube_shell(size, wall_thickness, center=false) {
	if (center) {
		cube_shell_int(size, wall_thickness);
	} else {
		translate([size[0]/2 + wall_thickness, size[1]/2 + wall_thickness, 0])
		cube_shell_int(size, wall_thickness);
	}
}

module cube_shell_int(size, wall_thickness) {
	difference() {
		cube_centered_xy(size + [wall_thickness*2, wall_thickness*2, wall_thickness]);
		translate([0, 0, wall_thickness]) cube_centered_xy(size + [0, 0, 0.001]);
	}
}

module rotate_all(increment=90) {
	for (i = [0 : increment : 360]) {
		rotate(i) children();
	}
}

module mirror_all() {
	children();
	scale([-1, 1, 1]) children();
	scale([1, -1, 1]) children();
	scale([-1, -1, 1]) children();
}
