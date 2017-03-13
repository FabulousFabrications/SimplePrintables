use <../lib/cylinders.scad>;

entry_diameter = 32;
wall_thickness = 2.0;
height_cone = 80;
height_top = entry_diameter + 10;
height_join = 10;
hoseholderlength = 20;
hoseholderside = 45;
hoseholdersideoffset = 10;
dhosetop = 32;
dhoseside = 32;
dbase = 100;
d1 = 120;
d2 = 40;

$fn=50;


translate([0, 0, height_cone]) {
    difference() {
        cylinder(d=d1+wall_thickness*2, h=wall_thickness*2);
        translate([0, 0, -0.5]) cylinder(d=d1, h=wall_thickness*2+1);
    }
    difference() {
        cylinder(d=d1+wall_thickness*4, h=wall_thickness*2+height_join);
        translate([0, 0, -0.5]) cylinder(d=d1+wall_thickness*2, h=wall_thickness*2+1+height_join);
    }
}
cylinder_with_horizontal_thickness(d2, d1, height_cone, wall_thickness);
difference() {
    union() {
        cylinder(d=dbase, h=wall_thickness);
        difference() {
            for (a = [0:90:270]) {
                //rotate(45+a) translate([-2.5, d2/2+15, 0]) cube([5, 5, 40]);
                rotate(45+a) translate([0, dbase/2 - 8, 0]) cylinder(d=8, h=50, $fn=15);
            }
            cylinder(d2=d1, d1=d2, h=height_cone);
        }
    }
    translate([0, 0, -0.5])cylinder(d=d2+wall_thickness, h=wall_thickness+1);
    for (a = [0:90:270]) {
        rotate(a) translate([0, dbase/2 - 10, -0.5]) cylinder(d=4, h=wall_thickness+1, $fn=15);
    }
}

translate([0, d1*1.5, 0])
union() {
    translate([-hoseholdersideoffset, d1/2+wall_thickness/2, height_top-dhoseside/2]) {
        cube([hoseholdersideoffset, wall_thickness/2, dhoseside/2+wall_thickness]);
        translate([0, 0, -dhoseside/2]) intersection() {
            cube([hoseholdersideoffset, wall_thickness/2, dhoseside + wall_thickness]);
            translate([hoseholdersideoffset+0.5, -dhoseside/2-wall_thickness/2
, dhoseside/2]) rotate([0, 270, 0]) cylinder(d=dhoseside+wall_thickness*2, h=hoseholdersideoffset+1);
        }
    }
    translate([-hoseholdersideoffset, d1/2 - dhoseside/2, height_top-dhoseside/2]) {
        rotate([0, 270, 0]) difference() {
            union() {
                cylinder(d=dhoseside+wall_thickness*2, h=hoseholderside);
                translate([(dhoseside+wall_thickness*2)/4, 0, hoseholderside/2]) cube([dhoseside/2+wall_thickness, dhoseside+wall_thickness*2, hoseholderside], center=true);
            }
            translate([0, 0, -0.5]) cylinder(d=dhoseside, h=hoseholderside+1);
        }
    }
    
    translate([0, 0, height_top]) difference() {
        union() {
            cylinder(d=d1+wall_thickness*2, h=wall_thickness);
            translate([0, 0, -(hoseholderlength-wall_thickness)]) cylinder(d=dhosetop+wall_thickness*2, h=hoseholderlength);
        }
        translate([0, 0, -(0.5+(hoseholderlength-wall_thickness))]) cylinder(d=dhosetop, h=hoseholderlength+1);
    }
    difference() {
        cylinder(d=d1+wall_thickness*2, h=height_top);
        translate([0, 0, -0.5]) cylinder(d=d1, h=height_top+1);
        translate([0, d1/2 - dhoseside/2, height_top-dhoseside/2]) {
            rotate([0, 270, 0])
                translate([0, 0, -0.5]) cylinder(d=dhoseside, h=hoseholderside+1+hoseholdersideoffset);
        }
    }
}