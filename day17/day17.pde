void setup() {
	size(1000, 1000);
	frameRate(30);
	noLoop();
}

void draw() {
	colorMode(HSB, 100);
	background(10, 10, 100);
	loadPixels();
	
	noiseDetail(3, 0.5);

	float[] values = new float[width * height];

	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {
			values[x * height + y] = noise(x / 50.0, y / 50.0);
		}
	}

	float max = max(values);
	float min = min(values);

	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {

			float n = map(values[x * height + y], min, max, -1.0, 1.0);

			if (n > 0) {
				n *= pow(sin(((float) x + y) / 10), 4.0);
				if (n > 0.1)
					pixels[x + y * width] = color(0, 40, 100);
			} else {
				n *= pow(sin(((float) x - y) / 10), 4.0);
				if (n < -0.1)
					pixels[x + y * width] = color(40, 40, 100);
			}
		}
	}

	updatePixels();
	save("day17.png");
}
