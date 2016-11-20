height = 80;
width = 100;
length = 200;
thickness = 0.6 * 8;

clamp(height, thickness, length, width);

module clamp(height, thickness, length, width) {
	angle = 90;

	difference() {
		union() {
			color("red")
			translate([width/2, 0, (thickness+height)/2])
			cube([width + thickness*2, length + thickness*2, thickness+height], center=true);
			
			rotate(angle)
			translate([width/2, 0, (thickness+height)/2])
			cube([width + thickness*2, length + thickness*2, thickness+height], center=true);
		}
		translate([width/2, -(thickness+0.002)/2, thickness])
		translate([0, 0, (height+0.002)/2])
		cube([width, length+(thickness+0.002), height+0.002], center=true);
		
		rotate(angle)
		translate([width/2, (thickness+0.002)/2, thickness])
		translate([0, 0, (height+0.002)/2])
		cube([width, length+(thickness+0.002), height+0.002], center=true);
	}
	
	c = length - width;
	l = sqrt(c*c*2);
	translate([-c/2-thickness/2, -c/2-thickness/2, (height+thickness)/2]) rotate(-angle/2) cube([l, thickness, height+thickness], center=true);
}
