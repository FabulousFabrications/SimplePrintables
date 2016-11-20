use <../lib/flat spring.scad>;

width = 20;
height = 35;
wallthickness = 1.2;
springWallThickness = 3.6;
springOffset = 2;
outerRadius=5;
tolerance = 0.3;
loops=2;
$fn=20;
topLength = -10;
topOutside = 0;

explode = 40;

translate([wallthickness,wallthickness,wallthickness]) FlatSpring(outerRadius*2, springWallThickness, springOffset, loops, width, height);

l = topLength+FlatSpringLength(outerRadius*2, springWallThickness, springOffset, loops);
w = width+tolerance*2;
h = height+tolerance*2;

translate([0,explode*1,0])
difference() {
	cube([l+wallthickness-0.01, w+wallthickness*2, h + wallthickness*2]);
	translate([wallthickness,wallthickness,wallthickness]) cube([l, w, h]);
}

translate([0,explode*2,0])
translate([wallthickness+l-topLength,wallthickness,wallthickness]) cube([topLength+topOutside, w-tolerance*2, h-tolerance*2]);