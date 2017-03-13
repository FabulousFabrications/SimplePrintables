use <../lib/util.scad>;
use <../lib/hole.scad>;
use <../lib/bevel.scad>;
use <../lib/shapes.scad>;

$fn = 30;

function hole_sizing(hole, thickness) = hole+thickness*2;

module case_shell(size, fsize, hole, thickness, clearance, style) {
	c = hole_sizing(hole, thickness);
	difference() {
		union() {
			difference() {
				cube(size+repeat(thickness*2, 3), center=true);
				cube(size, center=true);
			}
			if (style == "hole") {
				mirror_all() translate([(fsize[0])/2-c/2, 0, -(fsize[2])/2]) {
					translate([0, -fsize[1]/2 + c/2, fsize[2]/2]) 
					difference() {
						cube([c, c, fsize[2]], center=true);
						rotate([0, 0, -90]) translate([-c/2-0.005, -c/2-0.005, size[2]/2+0.001]) rotate([0, 90, 0]) bevel(fsize[2]+0.002, c/2+0.005);
					}
				}
			}
		}
		mirror_all() translate([fsize[0]/2+0.001, fsize[1]/2+0.001, fsize[2]/2+ 0.001])
		rotate([0, 90, 180]) bevel(fsize[2]+0.002, c/2+0.005);
	}
}

module holes(hole, d, thickness, size, fsize) {
	c = hole_sizing(hole, thickness)/2;
	for (r = [0 : 180 : 180]) {
		rotate([0, 0, r]) translate([fsize[0]/2, 0, fsize[2]/2]) {
			translate([- c, fsize[1]/2-c, 0]) hole(d, size[2]+0.01, 1, true);
			translate([- c, -(fsize[1]/2-c), 0]) hole(d, size[2]+0.01, 1, true);
		}
	}
}

module box_base(length, width, height, thickness, style="hole", hole=0, clearance = 0.1, hm=0.9, extend=50) {
	extend = style == "hole" ? hole_sizing(hole, thickness)*2 : 0;
	size = [length + extend, width + extend, height];
	fsize = size+repeat(thickness*2, 3);
	difference() {
		translate([0, 0, fsize[2]/2])
		difference() {
			union() {
				case_shell(size, fsize, hole, thickness, clearance, style);
				translate([0, 0, -fsize[2]/2]) {
					children();
				}
			}
			cutoff = fsize+repeat(extend, 3);
			translate([0, 0, cutoff[2]/2-fsize[2]/2+thickness+hm*height]) cube(cutoff, center=true);
			
			if (style == "hole") {
				holes(hole, hole - clearance, thickness, size, fsize);
			}
		}
		if (style == "snap") {
			box_snap(size, fsize, thickness, 1 - hm, false);
		}
	}
}

module box_top(length, width, height, thickness, style="hole", hole=0, clearance = 0.1, hm=0.1, extend=50) {
	extend = style == "hole" ? hole_sizing(hole, thickness)*2 : 0;
	size = [length + extend, width + extend, height];
	fsize = size+repeat(thickness*2, 3);
	translate([0, 0, fsize[2]/2])
	difference() {
		union() {
			case_shell(size, fsize, hole, thickness, clearance, style);
			translate([0, 0, -fsize[2]/2]) {
				children();
			}
		}
		cutoff = fsize+repeat(extend, 3);
		translate([0, 0, -cutoff[2]/2+fsize[2]/2-thickness-hm*height+0.001]) cube(cutoff, center=true);
		
		if (style == "hole") {
			translate([0, 0, 0]) holes(hole, hole + clearance, thickness, size, fsize);
		}
	}
	if (style == "snap") {
		box_snap(size, fsize, thickness, hm, true);
	}
}

module box_snap(size, fsize, thickness, hm, top) {
	height = size[2];
	offset = 0;
	width = thickness * 4;
	ewidth = top ? 0 : thickness*0.1;
	catch_slant_height = 0.25 * thickness;
	l = (hm + 0.5) * size[2] + thickness + (top ? 0 : 0); //thickness * catch_slant_height / 3);
	mirror_all() {
		translate([fsize[0]/2-0.001, fsize[1]/2 - width - thickness * 2, fsize[2] - l]) {
			if (top) { cube([thickness*2, width, l]); }
			else {
				translate([-thickness/2+0.002, width/2, thickness*2 + catch_slant_height/2 -0.001]) rotate([0, 0, 180]) prism(thickness, width+ewidth, catch_slant_height, center=true);
			}
			translate([-thickness/2+0.002, width/2, thickness]) rotate([180, 0, 180]) prism(thickness, width+ewidth, thickness * 2);
		}
	}
}

box_base(30, 20, 10, 1, "snap");
translate([0, 20*1.5, 0]) box_top(30, 20, 10, 1, "snap");
