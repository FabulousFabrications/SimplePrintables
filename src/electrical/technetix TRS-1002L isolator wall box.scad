// box which houses a TRS-1002L isolator

isolator_width = 38.5 + 0.2;
isolator_length = 61.4 + 0.1;
isolator_height = 20.5; // Actually 20 but we don't want to cover the entire thing
isolator_offset = 9.5;
isolator_cutout_diameter = 18.6;
isolator_cutout_offset_width = 3.5;
isolator_cutout_offset_height = 1.0;
isolator_cutout2_diameter = 10;
isolator_cutout2_offset_width = 11;
isolator_cutout2_offset_height = 9;
isolator_cutout2_extra_width = 2;
height_isolator_part = 1.5;
hole = 3.5;

$fn = 30;

wall_thickness = 2.4;

use <../lib/hole.scad>;
use <../lib/util.scad>;
use <../lib/box.scad>;
use <../lib/bevel.scad>;
hs = hole_sizing(hole, wall_thickness);
box_extension = 20;
box_width = isolator_width + hs + box_extension;
hole_spacing_x = 20;
hole_spacing_y = 30;

module wall_box(base) {
	difference() {
		union() {
			translate([0, box_width/2-isolator_width/2+wall_thickness, 0]) {
				if (base) {
					cube_shell([isolator_length, isolator_width, height_isolator_part], wall_thickness, true);
				} else {
					translate([0, 0, isolator_height+wall_thickness*2]) scale([1, 1, -1]) cube_shell([isolator_length, isolator_width, height_isolator_part], wall_thickness, true);
				}
			}


			if (base) {
				box_base(isolator_length, isolator_width+box_extension, isolator_height, wall_thickness, "hole", hole, hm=0.7);
			} else {
				box_top(isolator_length, isolator_width+box_extension, isolator_height, wall_thickness, "hole", hole, hm=0.3);
			}
		}
		wall_cutout();
		translate([hole_spacing_x, hole_spacing_y, 0]) bottom_hole();
		translate([-hole_spacing_x, hole_spacing_y, 0]) bottom_hole();
		translate([hole_spacing_x, -hole_spacing_y, 0]) bottom_hole();
		translate([-hole_spacing_x, -hole_spacing_y, 0]) bottom_hole();
		translate([hole_spacing_x, -10, 0]) bottom_hole();
		translate([-hole_spacing_x, -10, 0]) bottom_hole();
	}
}

wall_box(true);
translate([100, 0, 0]) wall_box(false); 

module bottom_hole() {
	translate([0, 0, wall_thickness]) hole(hole, wall_thickness, 1.25);
}

module wall_cutout() {
	translate([0, box_width/2+hs/2+wall_thickness/2, isolator_height / 2 + wall_thickness]) difference() {
		cube([isolator_length+wall_thickness*2, wall_thickness+0.1, isolator_height], center=true);
		scale([1, 1, 1]) bev();
		scale([-1, 1, 1]) bev();
		scale([1, 1, -1]) bev();
		scale([-1, 1, -1]) bev();
	}
}

module bev() {
		translate([isolator_length/2+wall_thickness, -wall_thickness/2-0.5, -isolator_height/2]) rotate([0, 0, 90]) bevel(wall_thickness+1, 5);
}