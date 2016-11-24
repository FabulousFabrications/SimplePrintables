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

$fn = 30;

wall_thickness = 1.2;

use <../lib/hole.scad>;
use <../lib/util.scad>;
use <../lib/box.scad>;

module isolator() {
	difference() {
		children();
		
		translate([0, -isolator_width/2, wall_thickness])
		scale([1, -1, 1])
		isolator_cutout(isolator_cutout_diameter, isolator_cutout_offset_width, isolator_cutout_offset_height);
		
		translate([0, isolator_width/2, wall_thickness]) isolator_cutout(isolator_cutout2_diameter, isolator_cutout2_offset_width, isolator_cutout2_offset_height);
	}
}

isolator()
box_base(isolator_length, isolator_width, isolator_height, wall_thickness, "snap", hm=0.7)
isolator_cutout_shrouds();

translate([0, isolator_width+60, 0])
isolator()
box_top(isolator_length, isolator_width, isolator_height, wall_thickness, "snap", hm=0.3)
isolator_cutout_shrouds();

bodge = 0.002;

module isolator_cutout_shrouds() {
		translate([0, -isolator_width/2, 0])
		scale([1, -1, 1])
		isolator_cutout_shroud(isolator_cutout_diameter, isolator_cutout_offset_width, isolator_cutout_offset_height);

		translate([0, isolator_width/2, 0])
		isolator_cutout_shroud(isolator_cutout2_diameter, isolator_cutout2_offset_width, isolator_cutout2_offset_height, ew=isolator_cutout2_extra_width);
}

module isolator_cutout(d, w, h) {
	translate([isolator_length/2 - (d/2 + w), -bodge/2, d/2 + h])
	rotate([90, 0, 180])
		cylinder_outer(h=wall_thickness+bodge, d=d,fn=$fn);
}

module isolator_cutout_shroud(d, w, h, l=20, ew=0) {
	fh = isolator_height+wall_thickness*2;
	translate([isolator_length/2 - (d/2 + w), -bodge/2, fh/2])
	rotate([90, 0, 180])
	difference() {
		cube_centered_xy([d+wall_thickness*2+ew*2, fh, l]);
		translate([0, 0, -1]) cube_centered_xy([d+ew*2, fh-wall_thickness*2, l+2]);
	}
}
