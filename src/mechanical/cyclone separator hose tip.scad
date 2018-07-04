dhoseside=37.9;
dhoseexpansion=1.05;
wall_t=2.3;

$fs=2;
$fa=5;

module cylinder_wall(d1, d2, t, h) {
    difference() {
        cylinder(d1=d1+t*2, d2=d2+t*2, h=h);
        translate([0, 0, -0.01]) cylinder(d1=d1, d2=d2, h=h+0.02);
    }
}

cylinder_wall(d1=dhoseside+dhoseexpansion,d2=dhoseside, t=wall_t, h=30);
translate([0, 0, 29.99]) cylinder_wall(dhoseside, dhoseside*0.75, wall_t, 30);