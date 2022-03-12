color[] colors = {#FFD400, #D90368};
int squares = 11;

void setup() {
	size(1000, 1000);
	noLoop();
}

void draw() {
	float r1, r2, l, a = width/(squares + 2.0);
	int s;

	background(#2E294E);
	noFill();
	stroke(#F1E9DA);
	strokeWeight(4);

	for (int j = 2; j < 22; j++) {
		if (j % 4 == 2) continue;
		square(width/2.0 - j * a /4.0, width/2.0 - j * a /4.0, j * a/2.0);
	}

	stroke(#541388);
	strokeWeight(2);
	for (int i = 0; i < squares; i++) {
		for (int j = 0; j < squares; j++) {
			r1 = ((float) i) / (squares + 1) + 0.05;
			r2 =	((float) j) / (squares + 1) + 0.05;
			s = i + j;
			for (int k = 0; k < 4; k++) {
				fill(colors[(s + k) % colors.length]);
				l = (k + 1) * 0.1;
				rect(a * (i + 1 + l), a * (j + 1 + l), a * (1 - 2 * l), a * (1 - 2 * l), r1 * a, r2 * a, r1 * a, r2 * a);
			}
		}
	}

	save("day27.png");
}

float smoothstep(float edge0, float edge1, float x) {
	x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0);
	return x * x * (3 - 2 * x);
}
