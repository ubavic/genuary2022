float r = 1;
float R = 2;

void setup() {
	size(500, 500);
	background(0);
	noLoop();
	loadPixels();
}

void draw() {
	PVector p, n, X, Y, X2, Y2;
	PVector O = new PVector(0, 5 * 1.3, 5 * 1.5);
	
	PVector to = O.copy().mult( -1);
	PVector up = new PVector(0, 1, 0);
	
	to.normalize();
	X = up.cross(to).normalize();
	Y = X.cross(to).normalize();
	
	float C0 = 0, C1 = 0, C2 = 0, C3 = 0, C4 = 0;
	float t = 0, s = -0.5;
	
	X2 = PVector.add(PVector.mult(X, cos(s)), PVector.mult(Y, -sin(s)));
	Y2 = PVector.add(PVector.mult(X, sin(s)), PVector.mult(Y, cos(s)));
	
	X = X2;
	Y = Y2;
	
	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {
			p = PVector.add(PVector.mult(to, 2), PVector.add(PVector.mult(X,(x * 2.0) / width - 1.0), PVector.mult(Y,(y * 2.0) / height - 1.0)));
			p.normalize();
			
			C4 = sq(PVector.dot(p, p));
			C3 = 4 * PVector.dot(p, p) * PVector.dot(p, O);
			C2 = 2 * PVector.dot(p, p) * (PVector.dot(O, O) - sq(r) - sq(R)) + 4 * sq(PVector.dot(p, O)) + 4 * sq(R) * sq(p.y);
			C1 = 4 * (PVector.dot(O, O) - sq(r) - sq(R)) * PVector.dot(p, O) + 8 * sq(R) * p.y * O.y;
			C0 = sq(PVector.dot(O, O) - sq(r) - sq(R)) - 4 * sq(R) * (sq(r) - sq(O.y));
			
			t = findRoot(C0, C1, C2, C3, C4);
			
			if (t < 0)
				pixels[x + y * width] = (random(1) > 0.99) ? color(0, 0, 170) : color(0, 0, 90);
			else{
				n = gradient(PVector.add(O, p.mult(t)));
				n.normalize();
				t = 0.3 + 0.5 * PVector.dot(n, up) + random(0.1);
				
				pixels[x + y * width] = color(t * 240, 0, 0);
			}
		}
	}
	
	colorMode(HSB);
	
	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height - 2; y++) {
			t = brightness(pixels[x + y * width]);
			s = (t > 129) ? 255 : 0;
			t = (t - s) / 10;
			
			pixels[x + y * width] = color(s);
			
			addBrightness(x + 1, y, t);
			addBrightness(x + 2, y, t);
			addBrightness(x, y + 1, t);
			addBrightness(x + 1, y + 1, t);
			addBrightness(x, y + 2, t);
		}
	}
	
	updatePixels();
	save("day02.png");
}

void addBrightness(int x, int y, float b) {
	color C = pixels[x + y * width];
	pixels[x + y * width] = color(hue(C), saturation(C), brightness(C) + b);
}

float findRoot(float C0, float C1, float C2, float C3, float C4) {
	float x = 0, x0 = 0;
	
	for (int i = 0; i < 100; i++) {
		x0 = x;
		x = x - (C0 + x * (C1 + x * (C2 + x * (C3 + C4 * x)))) / (C1 + x * (2 * C2 + x * (3 * C3 + 4 * C4 * x)));
		if (abs(x - x0) < 0.001)
			break;
	}
	
	return(abs(x - x0) <0.01) ? x : - 1;
}

PVector gradient(PVector v) {
	float s = PVector.dot(v, v) - sq(r) - sq(R);
	return new PVector(4 * v.x * s, 4 * v.y * (s + 2 * sq(R)), 4 * v.z * s);
}
