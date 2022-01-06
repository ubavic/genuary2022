color[] colors = {color(246, 2, 1), color(31, 127, 201), color(253, 237, 1), color(2, 2, 8)};

void setup() {
	size(1000, 1000);
	background(254, 255, 250);
	noLoop();
	strokeWeight(2);
}

void draw() {
	drawSquare(50, 50, 900, 10);
	save("day05.png");
}

void drawSquare(float x, float y, float a, int n) {
	if (n == 0)
		return;

	if (random(1) < 0.4)
		fill(colors[floor(random(0, 4)) % 4]);
	else
		fill(254, 255, 250);

	square(x, y, a);

	if (random(1) < 2 * (10 - n)/10.0)
		return;

	n--;
	drawSquare(x, y, a/2, n);
	drawSquare(x + a/2, y, a/2, n);
	drawSquare(x, y + a/2, a/2, n);
	drawSquare(x + a/2, y+ a/2, a/2, n);
}
