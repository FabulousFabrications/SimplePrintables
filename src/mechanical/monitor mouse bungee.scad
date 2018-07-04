

thickness = 4;
monitor_thickness = 20;
ext_thickness = monitor_thickness+thickness*2;
bezel_height = 17.5;
width = 15;
arm_length = 50;
arm_width = 6;
tri_thickness = arm_width;
angle = 40;
back_angle = 35;
gripper_thickness = 2;

//section of monitor bezel
% cube([width+20, monitor_thickness, bezel_height], center=true);

translate([0, 0, bezel_height/2+thickness/2])
cube([width, ext_thickness, thickness], center=true);

translate([0, -(monitor_thickness+thickness)/2, 0])
cube([width, thickness, bezel_height], center=true);

translate([0, -(monitor_thickness+thickness-gripper_thickness)/2, -(bezel_height+thickness)/2])
cube([width, thickness+gripper_thickness, thickness], center=true);


translate([0, (monitor_thickness+thickness)/2, bezel_height/2+thickness/2])
rotate([back_angle, 0, 0])
translate([0, 0, -bezel_height/2])
cube([width, thickness, bezel_height], center=true);


a = ext_thickness/2;
module tri_arm() {
translate([0, 0, bezel_height/2+thickness]) rotate([90, 0, 270]) {

    linear_extrude(arm_width, center=true) translate([ext_thickness/2-a, 0, 0])
    polygon([
    //[a, 0],
    [a+0.01, (tan(angle)*a)-tri_thickness],
    [a+arm_length, (tan(angle)*(a+arm_length))-tri_thickness],
    [a+arm_length, (tan(angle)*(a+arm_length))+0.01],
    [0, 0]
    ]);
}
}

module tri() {
translate([0, 0, bezel_height/2+thickness]) rotate([90, 0, 270]) {
    linear_extrude(width, center=true) translate([ext_thickness/2-a, 0, 0])
    polygon([
    [a, 0],
    [a, (tan(angle)*a)],
    [0, 0]
    ]);
}
}

difference() {
    tri();
    tri_arm();
}
translate([100, 0, 0]) tri_arm();

//translate([width/2, -monitor_thickness/2-thickness/sin(angle), bezel_height/2+thickness]) rotate([angle, 0, 180]) cube([width, arm_length, tri_thickness]);