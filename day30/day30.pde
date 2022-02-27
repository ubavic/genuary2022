void setup() {
	size(1000, 850);
	noLoop();
	colorMode(HSB, 100);
	background(9, 4, 100);
	fill(8, 80, 30);
}

void draw() {
	translate(width/2 - 10, 0.95 * height);
	rotate(PI);
	scale(4);
	drawRect(15);
	save("day30.png");
}

void drawRect(int i) {
	if (i == 0) return;
	pushMatrix();
	scale(0.7);
	rect(-5, 0, 10, 100);
	translate(-2, 100);
	rotate(0.53);
	drawRect(i - 1);
	scale(0.9);
	rotate(-1.96);
	drawRect(i - 1);
	popMatrix();
}
