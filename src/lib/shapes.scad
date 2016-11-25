module prism(w, l, h, center=true) {
	if (center) {
		translate([-w/2, -l/2, -h/2]) prism(w, l, h, false);
	} else {
		polyhedron(points=[
			[0,0,h],
			[0,0,0],[w,0,0],
			[0,l,h],
			[0,l,0],[w,l,0]
		], faces=[
			[0,2,1],
			[3,4,5],
			[0,1,4,3],
			[1,2,5,4],
			[0,3,5,2],
		]);
	}
}