use <../lib/cylinders.scad>;

entry_diameter = 32;
wall_thickness = 2.0;
height_cone = 125;
height_top = entry_diameter + 31;
height_join = 10;
hoseholderlength = 65;
hoseholderside = 65;
hoseholdersideoffset = 10;
dhosetop = 31.7;
dhoseside = 37.9;
dhoseexpansion = 1.05;
holderexpansion = 0.04;
dbase = 145;
d1 = 160;
d2 = 45;

$fn=50;

union() {
translate([0, 0, height_cone-0.5]) {
    cylinder_wall(d1, d1, wall_thickness*2, wall_thickness*1.5);
    translate([0, 0, wall_thickness*2]) cylinder_wall(d1+wall_thickness*2+holderexpansion, d1+wall_thickness*2+holderexpansion, wall_thickness*2+height_join+0.5, wall_thickness);
}
cylinder_wall(d2, d1, height_cone, wall_thickness);
difference() {
    union() {
        cylinder(d=dbase, h=wall_thickness);
        difference() {
            for (a = [0:90:270]) {
                //rotate(45+a) translate([-2.5, d2/2+15, 0]) cube([5, 5, 40]);
                rotate(45+a) translate([0, dbase/2 - 10, 0]) cylinder(d=8, h=height_cone - 10, $fn=15);
            }
            cylinder(d2=d1, d1=d2, h=height_cone);
        }
    }
    translate([0, 0, -0.5])cylinder(d=d2+wall_thickness, h=wall_thickness+1);
    for (a = [0:90:270]) {
        rotate(a) translate([0, dbase/2 - 6, -0.5]) cylinder(d=4, h=wall_thickness+1, $fn=15);
    }
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
    translate([-hoseholdersideoffset, d1/2 - dhoseside/2, height_top-dhoseside/2-dhoseexpansion]) {
        rotate([0, 270, 0]) difference() {
            union() {
                cylinder(d1=dhoseside+wall_thickness*2, d2=dhoseside+wall_thickness*2+dhoseexpansion, h=hoseholderside);
                translate([(dhoseside+wall_thickness*2)/4, 0, hoseholderside/2]) cube([dhoseside/2+wall_thickness+dhoseexpansion*2, dhoseside+wall_thickness*2, hoseholderside], center=true);
            }
            translate([0, 0, -0.5]) cylinder(d1=dhoseside, d2=dhoseside+dhoseexpansion, h=hoseholderside+1);
        }
    }
    
    translate([0, 0, height_top]) difference() {
        union() {
            cylinder(d=d1+wall_thickness*2, h=wall_thickness);
            translate([0, 0, -(hoseholderlength-wall_thickness)]) cylinder(d1=dhosetop+wall_thickness*2, d2=dhosetop+wall_thickness*2+dhoseexpansion, h=hoseholderlength);
        }
        translate([0, 0, -(0.5+(hoseholderlength-wall_thickness))]) cylinder(d1=dhosetop, d2=dhosetop+dhoseexpansion, h=hoseholderlength+1);
    }
    difference() {
        cylinder(d=d1+wall_thickness*2, h=height_top);
        translate([0, 0, -0.5]) cylinder(d=d1, h=height_top+1);
        translate([0, d1/2 - dhoseside/2, height_top-dhoseside/2-dhoseexpansion]) {
            rotate([0, 270, 0])
                translate([0, 0, -0.5]) cylinder(d1=dhoseside, d2=dhoseside+dhoseexpansion, h=hoseholderside+1+hoseholdersideoffset);
        }
    }
}