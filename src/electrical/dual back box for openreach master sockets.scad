box_side = 86;
box_height = 18;
hole_distance = 60.3;
hole_diameter = 3.7;
grip_height = 6;
wall_thickness = 2.0;
base_thickness = 2.0;
gap = 10;
count = 2;
cable_grip_gap = 25;
cable_run_height = 25;
$fn = 10;
double = 0;
grip_thickness = 2.0;

hole_side_gap = (box_side - hole_distance)/2+wall_thickness;
grip_down = 6;
hole_box = hole_diameter+wall_thickness*2;
box_extra_down = grip_down/3-hole_box;
backing_width = box_side*count + gap*(count+1);
backing_height = box_side + gap*2 + cable_run_height;

module box(grip) {
    translate([0, box_side, 0])
    cube([box_side, wall_thickness, box_height]);
    translate([0, -box_extra_down, 0])cube([wall_thickness, box_side+box_extra_down+wall_thickness, box_height]);
    translate([(box_side-hole_box-hole_distance)/2, (box_side/2-hole_box/2)+wall_thickness, 0]) {
        difference() {
            translate([hole_box-hole_side_gap, 0, 0]) cube([hole_side_gap, hole_box, box_height]);
            translate([hole_box/2, hole_box/2]) cylinder(d=hole_diameter, h=box_height+1);
        }
        translate([hole_distance, 0, 0]) {
            difference() {
                cube([hole_side_gap, hole_box, box_height]);
                translate([hole_box/2, hole_box/2]) cylinder(d=hole_diameter, h=box_height+1);
            }
        }
    }
    translate([box_side - wall_thickness, 0, 0])
    translate([0, -box_extra_down, 0]) cube([wall_thickness, box_side+box_extra_down+wall_thickness, box_height]);
    
    if (grip) {
        translate([box_side - wall_thickness, -grip_down, 0]) {
            difference() {
                cube([hole_box, hole_box, grip_height]);
                translate([hole_box/2, hole_box/2]) cylinder(d=hole_diameter, h=box_height+1);
            }
            translate([0, -cable_grip_gap, 0])
            difference() {
                cube([hole_box, hole_box, grip_height]);
                translate([hole_box/2, hole_box/2]) cylinder(d=hole_diameter, h=box_height+1);
            }
        }
    }
}

module half(grip=true) {
    translate([-gap, -(gap+cable_run_height), -base_thickness+0.01]) cube([backing_width, backing_height, base_thickness]);
    for (i = [0 : 1 : count-1]) {
        translate([(box_side + gap)*i, 0, 0]) box(grip);
        if (i != count-1) {
            translate([(box_side + gap)*i+box_side-0.5, 0, 0]) {
                translate([0, -box_extra_down, 0]) cube([gap+1, wall_thickness, box_height]);
                translate([0, box_side, 0]) cube([gap+1, wall_thickness, box_height]);
            }
        }
    }
}

half();
if (double) {
    translate([backing_width-gap*2, -cable_run_height-grip_down*2/3, 0]) rotate(180) half(false);
}

module clip() {
    difference() {
            translate([0, -cable_grip_gap, 0]) cube([hole_box, hole_box+cable_grip_gap, grip_thickness]);
            translate([hole_box/2, hole_box/2]) cylinder(d=hole_diameter, h=box_height+1);
            translate([0, -cable_grip_gap, 0]) translate([hole_box/2, hole_box/2]) cylinder(d=hole_diameter, h=box_height+1);
        }
    spd=20;
    of = spd/2;
    translate([0, -cable_grip_gap+hole_box, grip_thickness])
    difference() {
        cube([hole_box, cable_grip_gap-hole_box, grip_thickness]);
        translate([hole_box+0.5, (cable_grip_gap-hole_box)/2, of+grip_thickness/2]) rotate([0, -90, 0]) cylinder(d=spd, h=hole_box+1, $fn=20);
    }
}

translate([-50, 0, 0]) {
    clip();
}