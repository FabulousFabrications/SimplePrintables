module cylinder_outer(h,d=undef,d1=undef,d2=undef,fn=15) {
	fudge = cos(180/fn);
	cylinder(h=h,d=d/fudge,d1=d1/fudge,d2=d2/fudge,$fn=fn);
}

module hole(d, height, countersink=0, extra_above=false) {
	height = height - countersink;
	translate([0, 0, -(height+countersink)]) {
		translate([0, 0, height+0.001]) cylinder_outer(d1=d, d2=d*1.5, h=countersink);
		if (extra_above) {
			translate([0, 0, height+0.001]) cylinder_outer(d1=d, d2=d*2, h=countersink*3/2);
		}
		if (height > 0)
			translate([0, 0, -2]) cylinder_outer(d=d, h=height+2.1);
	}
}

module nut_trap(w, h, sides){
	cylinder(r = w / 2 / cos(180 / 6) + 0.05, h=h, $fn=6);
}
