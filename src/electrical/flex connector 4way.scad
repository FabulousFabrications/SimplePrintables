use <../lib/util.scad>;
use <../lib/hole.scad>;
use <../lib/bevel.scad>;

width = 80;
length = 80;
height = 25;
thickness = 0.5 * 6;
hole = 3;
clearance = 0.1;
$fn = 25;

look_inside = true;

size = [length, width, height];
fsize = size+repeat(thickness*2, 3);

module case_shell() {
	c = hole * 3;
	difference() {
		cube(size+repeat(thickness*2, 3), center=true);
		cube(size, center=true);
	}
	for (r = [0 : 180 : 180]) {
		rotate([0, 0, r]) translate([(length + thickness*2)/2-c/2, 0, -(height+thickness*2)/2]) {
			translate([0, -fsize[1]/2 + c/2, fsize[2]/2]) 
			difference() {
				cube([c, c, height+thickness*2], center=true);
				rotate([0, 0, -90]) translate([-c/2-0.005, -c/2-0.005, height/2+0.001]) rotate([0, 90, 0]) bevel(height+0.002, c/2+0.005);
			}
			translate([0, fsize[1]/2 - c/2, fsize[2]/2]) difference() {
				cube([c, c, height+thickness*2], center=true);
				translate([-c/2-0.005, -c/2-0.005, height/2+0.001]) rotate([0, 90, 0]) bevel(height+0.002, c/2+0.005);
			}
		}
	}
}

module holes(d) {
	c = hole * 3.5;
	for (r = [0 : 180 : 180]) {
		rotate([0, 180, r]) translate([length/2+thickness, 0, height/2 + thickness]) {
			translate([-thickness-hole-c/2, -7, 0]) hole(d, height+0.01, 1, true);
			translate([-thickness-hole-c/2, 7, 0]) hole(d, height+0.01, 1, true);
			translate([- c/2, width/2+thickness-c/2, 0]) hole(d, height+0.01, 1, true);
			translate([- c/2, -width/2-thickness+c/2, 0]) hole(d, height+0.01, 1, true);
		}
	}
	for (r = [0 : 180 : 180]) {
		rotate([0, 180, 90+r]) translate([width/2+thickness, 0, height/2 + thickness]) {
			translate([-thickness-hole*2, -7, 0]) hole(d, height+0.01, 1, true);
			translate([-thickness-hole*2, 7, 0]) hole(d, height+0.01, 1, true);
		}
	}
}

module base() {
	difference() {
		case_shell();
		translate([0, 0, thickness]) cube(fsize+repeat(0.001, 3), center=true);
		holes(hole + clearance);
	}
}

module top() {
	difference() {
		case_shell();
		translate([0, 0, -(height+thickness*2)/2+thickness/2-0.001]) cube([fsize[0]+0.001, fsize[1]+0.001, thickness+0.003], center=true);
		holes(hole - clearance);
		for (r = [0 : 180 : 180]) {
			rotate([0, 180, r]) translate([length/2+thickness, 0, height/2]) {
				translate([-thickness-0.001, 0, 0]) rotate([0, 90, 0]) cylinder(d=10, h=thickness+0.002);
			}
		}
		for (r = [0 : 180 : 180]) {
			rotate([0, 180, 90+r]) translate([width/2+thickness, 0, height/2]) {
				translate([-thickness-0.001, 0, 0]) rotate([0, 90, 0]) cylinder(d=10, h=thickness+0.002);
			}
		}
	}
}

module flex_grabber() {
	difference() {
		cube([22, 8, thickness], center=true);
		translate([-7, 0, (thickness+0.002)/2]) hole(hole-clearance, thickness+0.002, 0, false);
		translate([7, 0, (thickness+0.002)/2]) hole(hole-clearance, thickness+0.002, 0, false);
	}
}

base();
translate([0, width*1.5, 0]) top();
for( i = [0:3]) {
    translate([0, width*2.5+10*i, 0])flex_grabber();
}
