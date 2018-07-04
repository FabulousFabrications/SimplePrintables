use <../lib/cylinders.scad>;

entry_diameter = 32;
wall_thickness = 1.8;
base_thickness = 2;
height_cone = 125;
height_top = entry_diameter + 31;
height_join = 10;
hoseholderlength = 85;
hoseholderside = 85;
hoseholdersideoffset = 10;
dhosetop = 31.7;
dhoseside = 37.9;
dhoseexpansion = 1.05;
holderexpansion = 0.04;
dbase = 215;
d1 = 250;
d2 = 150;

$fn=50;

union() {
translate([0, 0, height_cone-0.5]) {
    cylinder_wall(d1, d1, wall_thickness*2+base_thickness, wall_thickness*1.5);
    translate([0, 0, wall_thickness*0]) cylinder_wall(d1+wall_thickness*2+holderexpansion, d1+wall_thickness*2+holderexpansion, wall_thickness*4+height_join+0.5, wall_thickness);
}

difference() {
union(){
    translate([0, 0, height_cone-5])
cylinder_wall(d1-4, d1+wall_thickness*2+holderexpansion, 5, wall_thickness);
translate([0, 0, base_thickness]) cylinder(d1=d2+15, d2=d2, h=5);
}
cylinder(d2=d1, d1=d2, h=height_cone);
}
cylinder_wall(d2, d1, height_cone, wall_thickness);
difference() {
    union() {
        cylinder(d=dbase, h=base_thickness);
        difference() {
            for (a = [0:90:270]) {
                //rotate(45+a) translate([-2.5, d2/2+15, 0]) cube([5, 5, 40]);
                rotate(45+a) translate([0, dbase/2 - 7.5, 0]) cylinder(d=8, h=height_cone - 10, $fn=15);
            }
            cylinder(d2=d1, d1=d2, h=height_cone);
        }
    }
    translate([0, 0, -0.5])cylinder(d=d2+wall_thickness, h=wall_thickness+1);
    for (a = [0:90:270]) {
        rotate(a) translate([0, dbase/2 - 6, -0.5]) cylinder(d=4, h=base_thickness+1, $fn=15);
    }
}
}

cd=10;

translate([0, d1*1.5, 0])
union() {
    *#translate([-hoseholdersideoffset, d1/2+wall_thickness/2, height_top-dhoseside/2]) {
        cube([hoseholdersideoffset, wall_thickness/2, dhoseside/2+wall_thickness]);
        translate([0, 0, -dhoseside/2]) intersection() {
            cube([hoseholdersideoffset, wall_thickness/2, dhoseside + wall_thickness]);
            translate([hoseholdersideoffset+0.5, -dhoseside/2-wall_thickness/2
, dhoseside/2]) rotate([0, 270, 0]) cylinder(d=dhoseside+wall_thickness*2, h=hoseholdersideoffset+1);
        }
    }
    sidehoserot=[0, 270, 0];
    sidehose=[-hoseholdersideoffset, d1/2 - dhoseside/2 - wall_thickness*0.5, height_top-dhoseside/2-dhoseexpansion];
    translate(sidehose) {
        rotate(sidehoserot) difference() {
            union() {
                cylinder(d1=dhoseside+wall_thickness*2, d2=dhoseside+wall_thickness*2+dhoseexpansion, h=hoseholderside);
                c=[dhoseside/2+wall_thickness+dhoseexpansion, dhoseside+wall_thickness*2, hoseholderside];
                translate([height_top-sidehose[2]+base_thickness, -dhoseexpansion/2, hoseholderside/2]) {
                    translate([-c[0]/2, 0, 0]) cube(c, center=true);
                }
            }
            translate([0, 0, -0.5]) cylinder(d1=dhoseside, d2=dhoseside+dhoseexpansion, h=hoseholderside+1);
        }
    }
    
    // top and exit pipe
    translate([0, 0, height_top]) difference() {
        union() {
            cylinder(d=d1+wall_thickness*2, h=base_thickness);
            translate([0, 0, -(hoseholderlength-wall_thickness)]) cylinder(d1=dhosetop+wall_thickness*2, d2=dhosetop+wall_thickness*2+dhoseexpansion, h=hoseholderlength);
            
            rotate_extrude()
            translate([dhosetop/2, 0])
            scale([1, -1]) difference() { square([cd, cd]); translate([cd, cd]) circle(r=cd); }
            
            
            rotate_extrude()
            translate([d1/2, 0])
            scale([-1, -1]) difference() { square([cd, cd]); translate([cd, cd]) circle(r=cd); }
        }
        translate([0, 0, -(0.5+(hoseholderlength-wall_thickness))]) cylinder(d1=dhosetop, d2=dhosetop+dhoseexpansion, h=hoseholderlength+1);
        
        translate(sidehose-[0,0,height_top])
        rotate(sidehoserot)
        translate([0, 0, -0.5]) cylinder(d1=dhoseside, d2=dhoseside+dhoseexpansion, h=hoseholderside+1);
        
        //#sphere(r=10);
    }
    difference() {
        cylinder(d=d1+wall_thickness*2, h=height_top);
        translate([0, 0, -0.5]) cylinder(d=d1, h=height_top+1);
        translate(sidehose) {
            rotate(sidehoserot)
                translate([0, 0, -0.5]) cylinder(d1=dhoseside, d2=dhoseside+dhoseexpansion, h=hoseholderside+1+hoseholdersideoffset);
        }
    }
}