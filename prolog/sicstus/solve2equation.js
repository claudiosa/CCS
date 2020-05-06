

let solve2equation = (a, b, c) => {
	// console.log(a, b, c);
	const delta = b*b - 4*a*c;
	if(delta < 0){
		return null;
	}
	const sqrDelta = math.sqrt(delta);
	return [
			(-b + sqrDelta)/(2*a),
			(-b - sqrDelta)/(2*a)
			];
}
