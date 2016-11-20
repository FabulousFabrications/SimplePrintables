bolt_diameter = 8;
bolt_length = 75;
bolt_clearance = 0.4;
slider_length = 40;
key_clearance = 0.05;
thickness = 4.2;
screw_diameter = 3.6;
part = 0;
receiver_extra_height = 0;
slider_extra_height = 11;

$fn = 25;
bolt_width_scale = 0.75;
key_width_scale = 2;
key_diameter = bolt_diameter*2/3*bolt_width_scale;
key_width = key_width_scale*key_diameter;
bolt_height = bolt_diameter/2;
slider_length_scale = 0.65;
receiver_length = slider_length * slider_length_scale - key_width*1.5;
t2 = thickness*2;
block_width = (bolt_diameter + t2)*bolt_width_scale + screw_diameter * 4;
all = 0;
bolt_offset = slider_length-bolt_length/2;
zeroish = 0.001;
key_offset = key_diameter + slider_length*(1-slider_length_scale)/2;
explodify = 20;
bolt_top_cutoff = 0.1;

use <lib/hole.scad>;
use <lib/bevel.scad>;

if (part == all || part == 1)
	color("blue") explode(1) translate([bolt_offset+zeroish, 0, thickness+bolt_clearance/2])
	difference() {
		bolt(bolt_height, bolt_diameter, bolt_length, true);
		translate([-50, -50, bolt_height+bolt_diameter/2-bolt_top_cutoff]) cube([100, 100, 20]);
	}
if (part == all || part == 2)
	color("red") explode(2) translate([slider_length/2, 0, 0]) slider();
if (part == all || part == 3)
	color("green") explode(3) translate([bolt_offset+receiver_length/2-bolt_length/2, 0, 0]) receiver();
if (part == all || part == 4)
	color("cyan") explode(4) translate([key_offset, 0, thickness+bolt_clearance+bolt_height*1/3]) scale([key_width_scale, 1, 1])
	union() {
		cylinder(d1=key_diameter-key_clearance*2, d2=key_diameter-key_clearance, h=bolt_diameter*1.5);
		translate([0, 0, bolt_diameter*1.9]) scale([1, 1, 1.25]) sphere(d=key_diameter*2);
	}

module explode(i) {
	translate([0, (i-1)*explodify, 0]) children();
}

module bolt_2d(bolt_height, bolt_diameter) {
	//square?
	scale([1, bolt_width_scale, 1]) {
		if (false) {
			square([bolt_height + bolt_diameter/2, bolt_diameter], center=true);
		} else {
			translate([bolt_height/2, 0]) square([bolt_height, bolt_diameter], center=true);
			difference() {
				circle(bolt_diameter/2);
				translate([bolt_diameter/2, 0])square(bolt_diameter, center=true);
			}
		}
	}
}

module bolt(bolt_height, bolt_diameter, bolt_length, key=false) {
	difference() {
		translate([-bolt_length/2, 0, bolt_height])
		rotate([0, 90, 0])
		linear_extrude(bolt_length) bolt_2d(bolt_height, bolt_diameter);
		if (key)
			translate([key_offset-bolt_offset, 0, 0.25]) scale([key_width_scale, 1, 1]) cylinder(d=key_diameter, h=bolt_diameter);
	}
}

module bolt_cutout(length, extra_height = 0) {
	difference() {
		bolt(bolt_height + thickness, bolt_diameter + t2, length);
		translate([0, 0, thickness]) bolt(bolt_height+bolt_clearance/2, bolt_diameter+bolt_clearance, length + 2);
	}
	translate([0, 0, -extra_height/2]) cube([length, bolt_width_scale*(bolt_diameter+t2), extra_height], center=true);
	translate([0, 0, -extra_height]) {
		translate([-length/2, bolt_width_scale*-(bolt_diameter+t2)/2, thickness]) rotate([90, 0, 0]) bevel(length, 2);
		translate([-length/2, bolt_width_scale*(bolt_diameter+t2)/2, thickness]) bevel(length, 2);
		translate([0, 0, thickness/2]) cube([length, block_width, thickness], center=true);
	}
}

module hole_pair() {
	translate([0, -(block_width/2-screw_diameter), 0]) hole(screw_diameter, thickness, 1.5, true);
	translate([0, block_width/2-screw_diameter, 0]) hole(screw_diameter, thickness, 1.5, true);
}

module receiver() {
	difference() {
		bolt_cutout(receiver_length, receiver_extra_height);
		translate([0, 0, thickness-receiver_extra_height]) hole_pair();
	}
}

module slider() {
	difference() {
		bolt_cutout(slider_length, slider_extra_height);
		union() {
			translate([slider_length/2-screw_diameter*2, 0, thickness-slider_extra_height]) hole_pair();
			translate([-(slider_length/2-screw_diameter*2), 0, thickness-slider_extra_height]) hole_pair();
			translate([0, 0, bolt_diameter+bolt_height]) cube([slider_length*slider_length_scale, bolt_diameter*2/3, bolt_diameter+thickness], center=true);
		}
	}
}

