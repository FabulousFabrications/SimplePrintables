module cylinder_wall(d1, d2, h, w) {
    diamDifference = w*2;//(w*2) * cos(90 - atan((d2-d1)/(1*h)));
    difference() {
        cylinder(d1=d1+diamDifference, d2=d2+diamDifference, h=h);
        union() {
            translate([0, 0, -0.01]) cylinder(d=d1, h=0.02);
            translate([0, 0, h-0.01]) cylinder(d=d2, h=0.05);
            cylinder(d1=d1, d2=d2, h=h);
        }
    }
}
$fn=50;
thickness=2;
bd = 10;
td = 30;
cylinder_wall(bd, td, 5, 2);
color("grey") translate([0, 0, -1]) cylinder(d=bd+thickness*2, $fn=50);
color("grey") translate([0, 0, 5]) cylinder(d=td+thickness*2, $fn=50);