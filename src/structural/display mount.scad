use <../lib/hole.scad>;
use <../lib/bevel.scad>;

l = 30;
w = 20;
h = 4;
hd = 3.5;
th = 15;
uth = 4;
thd = 4.6;

$fs = 0.2;
$fn = 50;

hd_edge = hd*4/3;
thd_edge = thd*1.5;

bottom_holes = false;

difference() {
	cube([l, w, h]);
	if (bottom_holes) {
		translate([0, 0 ,h]) {
			translate([hd_edge, hd_edge, 0]) {
				hole_row();
			}
			translate([hd_edge, w-hd_edge, 0]) {
				hole_row();
			}
		}
	}
}


clamp_offset = bottom_holes ? hd_edge * 1.5 : 0;
rw = w - clamp_offset;
translate([0, clamp_offset, h]) {
	difference() {
		union() {
			cube([l, uth, th]);
			translate([0, 0, th]) cube([l, rw, uth]);
			translate([0, uth, 0]) bevel(l, 1);
		}
		if (bottom_holes) {
			translate([-1, 0, th + uth]) rotate([270, 0, 0]) bevel(l + 2, 3);
		}
		translate([thd_edge, rw - thd_edge, th-1]) cylinder_outer(uth+2, 4.6, fn=$fn); 
		translate([l - thd_edge, rw - thd_edge, th-1]) cylinder_outer(uth+2, 4.6, fn=$fn); 
	}
}

module hole_row() {
	for (i = [0 : hd * 3 : l - hd_edge*2]) {
		translate([i, 0, 0]) hole(hd, 10, 1);
	}
}
