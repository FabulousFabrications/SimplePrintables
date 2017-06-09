phone_l = 20;
phone_w = 78.5;
phone_t = 15;

through_bolt_d = 5;
through_bolt_l = 30;

tripod_bolt_d = 10;
tripod_block_d = 35;

wall_t = 3;

translate([0, 0, wall_t]) { 
    translate([-wall_t, 0, 0]) cube([wall_t, phone_l, phone_t]);
    translate([phone_w, 0, 0]) cube([wall_t, phone_l, phone_t]);

    translate([0, 0, phone_t]) { 
        translate([-wall_t, 0, 0]) cube([wall_t*2, phone_l, wall_t]);
        translate([phone_w-wall_t, 0, 0]) cube([wall_t*2, phone_l, wall_t]);
    }
    translate([-wall_t, 0, -wall_t+0.01]) cube([phone_w + wall_t*2, phone_l, wall_t]);
}

b_d=through_bolt_d*2;
b_h=phone_t+wall_t*2;
ib_l = through_bolt_l/3;
translate([-wall_t-b_d, -(through_bolt_l - phone_l)/2, 0]) {
    difference() {
        cube([b_d, through_bolt_l, b_h]);
        translate([b_d/2, 0, b_h/2]) rotate([-90, 0, 0]) translate([0, 0, -0.5]) cylinder(d=through_bolt_d, h=through_bolt_l+1, $fn=25);
        translate([0, through_bolt_l/2-ib_l/2, 0]) cube([b_d, ib_l, b_h]);
    }
    
}

translate([-100, 0, 0]) {
    difference() {
        cube([tripod_block_d, tripod_block_d, tripod_bolt_d]);
        translate([tripod_block_d/2, tripod_block_d/2, -0.5]) cylinder(d=tripod_bolt_d,h=tripod_bolt_d+1);
    }
    translate([0, tripod_block_d, 0]) {
        cube([tripod_block_d, ib_l, tripod_bolt_d]);
        
        translate([tripod_block_d/2-b_h/2, 0, tripod_bolt_d]) {
            cube([b_h, ib_l, b_d]); 
            translate([b_h/2, b_d, b_d]) rotate([90, 0, 0]) cylinder(d=b_h,h=b_d);
        }
    }
    
}