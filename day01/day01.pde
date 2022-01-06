void setup() {
	size(1100, 1100);
	background(239, 235, 225);
	noLoop();
	strokeWeight(1);
	colorMode(HSB, 100.0, 100.0, 100.0);
}

void draw() {
	int r = 10;
	float s = 1, f = 1;
	
	  for (int x = 0; x < 100; x++) {
		for (int y = 0; y < 100; y++) {
			s = (y / 100.0) + 0.1;
			f = random(r) * s;
			fill(50 + 2 * f, 30 + 20 * s, 90 - f * 4);
			rect(x * 10 + f + 50 , y * 10 + f + 50 , 5 + 2 * f, 5 + 2 * f);
		}
	}
	
	save("day01.png");
}
