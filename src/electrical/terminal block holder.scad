l=136.3;
w=8;
h=1.8;
wall_thickness = 2;

translate([0, 0, wall_thickness/2]) cube([l, w, wall_thickness], center=true);
translate([0, (w+wall_thickness)/2, (h+wall_thickness)/2]) cube([l, wall_thickness, h+wall_thickness], center=true); 
translate([0, -(w+wall_thickness)/2, (h+wall_thickness)/2]) cube([l, wall_thickness, h+wall_thickness], center=true);
translate([(l+wall_thickness)/2, 0, (h+wall_thickness)/2]) cube([wall_thickness, w+wall_thickness*2, h+wall_thickness], center=true); 
translate([-(l+wall_thickness)/2, 0, (h+wall_thickness)/2]) cube([wall_thickness, w+wall_thickness*2, h+wall_thickness], center=true); 


translate([0, 0, wall_thickness/2]) cube([w*3, w*3, wall_thickness], center=true);
translate([(l+wall_thickness)/2, 0, wall_thickness/2]) cube([w*3, w*3, wall_thickness], center=true);
translate([-(l+wall_thickness)/2, 0, wall_thickness/2]) cube([w*3, w*3, wall_thickness], center=true);
