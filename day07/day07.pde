void setup() {
	size(1000, 1000);
	noLoop();
}

void draw() {
	background(250);
	strokeWeight(6);
	noFill();

	int n = 22;
	int X, Y;
	int direction;
	float a = ((float)width) / (n+1);

	for (int i = 0; i < n * n; i++) {
		X = i % n;
		Y = (i - X) / n;
		direction = floor(random(0, 4)) % 4;

		if (X == 0 || X == n || Y == 0 || Y == n)
			continue;

		float centerX;
		float centerY;
		float startAngle;

		if (direction % 2 == 0) {
			stroke(200, 0, 0);
			centerX = X * a + a / 2;
			if (direction == 0) {
				centerY = Y * a;
				startAngle = PI / 4;
			} else {
				centerY = Y * a + a;
				startAngle = PI + QUARTER_PI;
			}

			if (random(1) < 0.1) {
				float d = a / 30.0;
				line(X * a + d, Y * a + a/2, X * a + a - d, Y * a + a/2);
				continue;
			}
		} else {
			stroke(0, 20, 200);
			centerY = Y * a + a / 2;
			if (direction == 1) {
				centerX = X * a ;
				startAngle = PI + HALF_PI + QUARTER_PI;
			} else {
				centerX = X * a + a;
				startAngle = HALF_PI + QUARTER_PI;
			}
		}

		arc(centerX, centerY, sqrt(2) * a, sqrt(2) * a, startAngle, startAngle + HALF_PI);
	}

	save("day07.png");
}
