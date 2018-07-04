t=1.3;
td=197;
bd=250;
h=30;
end=15;

$fs=5;
$fa=4;

difference() {  
    union() {
        linear_extrude(h, scale=(td+t*2)/(bd+t*2)) circle(d=bd+t*2);
        translate([0, 0, -end]) cylinder(h=end, d=bd+t*2);
        translate([0, 0, h]) cylinder(h=end, d=td+t*2);
    }
    linear_extrude(h, scale=td/bd) circle(d=bd);
    translate([0, 0, -end-0.01]) cylinder(h=end+0.02, d=bd);
    translate([0, 0, h-0.01]) cylinder(h=end+0.02, d=td);
}