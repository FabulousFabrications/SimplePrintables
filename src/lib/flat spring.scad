FlatSpring(10, 3, 1, 2, 15, 15, $fn=25);

%cube([FlatSpringLength(10, 3, 1, 2), 1, 15]);

function FlatSpringLength(outer_diameter, wall_thickness, offset_per_loop, loops) = (offset_per_loop*2+(outer_diameter+(outer_diameter - wall_thickness*2)))*loops + (outer_diameter - wall_thickness*2)/2;

module FlatSpring(outer_diameter, wall_thickness, offset_per_loop, loops, width2, height) {
	width = width2 - outer_diameter;
	inner_diameter = outer_diameter - wall_thickness*2;
	per_pair_translate = offset_per_loop*2+(outer_diameter+inner_diameter);
	
	linear_extrude(height) translate([outer_diameter/2, outer_diameter/2]) {
		for (i = [0:loops-1]) {
			translate([per_pair_translate*i,0,0])
			FlatSpringLoopPair(outer_diameter, inner_diameter, wall_thickness, width, offset_per_loop, i == loops-1);
		}
		
		translate([-(wall_thickness+inner_diameter/2), 0, 0]) {
			FlatSpringAcrossEnd(wall_thickness, offset_per_loop, width-0.5, outer_diameter);
		}
		translate([(per_pair_translate*loops)-outer_diameter/2-offset_per_loop, width, 0])  rotate([180,0,0]) {
			FlatSpringAcrossEnd(wall_thickness, offset_per_loop, width-0.5, outer_diameter);
		}
	}
}

module FlatSpringLoopPair(outer_diameter, inner_diameter, wall_thickness, width, offset_per_loop, noend) {
	FlatSpringLoop(outer_diameter, inner_diameter);
	
	translate([inner_diameter/2, 0, 0])
	FlatSpringAcross(wall_thickness, offset_per_loop, width);
	
	translate([offset_per_loop+outer_diameter/2+inner_diameter/2, width, 0]) rotate([180,0,0])
	union() {
		FlatSpringLoop(outer_diameter, inner_diameter);
		if (!noend) {
			translate([inner_diameter/2, 0, 0])
			FlatSpringAcross(wall_thickness, offset_per_loop, width);
		}
	}
}

module FlatSpringAcross(wall_thickness, offset_per_loop, width) {
	polygon([[0,0], [wall_thickness, 0], [wall_thickness+offset_per_loop, width], [offset_per_loop, width]]);
}

module FlatSpringAcrossEnd(wall_thickness, offset_per_loop, width, outer_diameter) {
	FlatSpringAcross(wall_thickness, 0, width+outer_diameter/2-wall_thickness/2);
	translate([wall_thickness/2, width+outer_diameter/2-wall_thickness/2, 0]) circle(d=wall_thickness);
}

module FlatSpringLoop(outer_diameter, inner_diameter) {
	difference() {
		circle(d=outer_diameter);
		union() {
			circle(d=inner_diameter);
			translate([-outer_diameter/2,0,0]) square([outer_diameter, outer_diameter]);
		}
	}
}