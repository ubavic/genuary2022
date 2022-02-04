void setup() {
	size(500, 935);
	noLoop();
	colorMode(HSB, 100.0, 100.0, 100.0);
}

void draw() {
	int lines = floor(random(4, 10));
	float hue = random(0, 100);
	float sat = random(50, 70);
	float lightnes = random(80, 100);
	float hueStep = random(5, 30);
	int strokeWeight = 40 + floor(random(0, 30));
	int start = 900 * 2 / 3 + lines * 20;
	int delta= floor(random(0, 10));
	
	background(hue, random(0, 20), random(2, 22));
	strokeWeight(strokeWeight + 1);

	for (int i = 0; i < lines; i++) {
		stroke((hue + i * hueStep) % 100, sat, lightnes);
		line(-10, start - i * (strokeWeight - 2 * delta), height + 20, start - 50 - i * (strokeWeight + delta));
	}
	
	char[] name = {
		char(floor(random(65, 91))),
		char(floor(random(65, 91))),
		'-',
		char(floor(random(48, 58))),
		char(floor(random(48, 58)))
	};
	String nameString = new String(name);

	textSize(random(70, 120));
	text(nameString, 40, 280);

	save("day18.png");
}
