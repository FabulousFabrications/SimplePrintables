diameter = 49;
thickness = 1.0;
height = 84;
hsize=4;
$fn=20;

difference() {
    union() {
        translate([0, 0, height]) cylinder(r=diameter/2+thickness, h=thickness, $fn=50);
        difference() {
            cylinder(r=diameter/2+thickness, h=height, $fn=50);
            translate([0, 0, -0.5]) cylinder(r=diameter/2, h=height+1, $fn=50);
        }
    }
    for (zOffset = [hsize*1.75 : hsize*2.5 : height-hsize*1.75]) {
        for (r = [0 : 30 : 360]) {
            rotate([0, 0, r])
            translate([diameter/2-thickness*5, 0, zOffset])
            rotate([0, 90, 0])
            cylinder(r=hsize, h=thickness*10);
        }
    }
}

