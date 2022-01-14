void setup() {
	size(800, 80);
	noLoop();
}

void draw() {
	background(0, 0, 210);
	stroke(255);
	strokeWeight(2);

	for (int i = 0; i < width * height / 100; i++)
		line((i % 80) * 10, (i / 80) * 10 + ((i % 13 + i % 11) % 2) * 10, (i % 80) * 10 + 10, (i / 80) * 10 + 10 - ((i % 13 + i % 11) % 2) * 10);

	save("day13.png");
}
