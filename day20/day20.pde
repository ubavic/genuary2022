ArrayList<Shape> shapes = new ArrayList<Shape>();

int seconds = 2;
int fps = 60;
float frame = 0;
// integral of f(x) = pow(sin(TWO_PI * xd)/2 + 0.5, 3)
float integral = 0.3125;

void setup() {
	size(1000, 600);
	frameRate(30);
	colorMode(HSB, 100);

	Shape c;
	float x, y, min, d;

	for (int i = 0; i < 3000; i++) {
		x = random(1000);
		y = random(1000);

		min = 50;
		d = 0;

		for (Shape cc : shapes) {
			d = cc.distance(x, y);
			if (d < 0) break;
			min = (min < d) ? min : d;
		}

		if (d < 0) continue;
		if (min < 2) continue;
		if (min > 40) min *= random(0, 1);

		c = new Shape(x, y, min);
		shapes.add(c);
	}
}

void draw() {
	background(50, 10, 98);
	for (Shape s : shapes) {
		s.draw();
	}

	frame++;
	if (frameCount > fps * seconds) noLoop();

	saveFrame("day20-####.png");
}

class Shape
{
	int n;
	float x, y, r, a;
	color c;

	Shape(float x, float y, float r) {
		this.x = x;
		this.y = y;
		this.r = r;
		this.n = floor(random(3, 8));
		this.a = random(0, TWO_PI);
		this.c = color(35 + 4 * this.n, 20, 100);
	}

	void draw() {
		float s = pow(sin(TWO_PI * (frame/(seconds * fps) + ((float)x)/width))/2 + 0.5, 3);
		fill(hue(this.c), (1.0 - s/3.0) * saturation(this.c), brightness(this.c));

		this.a += TWO_PI * s / (integral * fps * seconds * this.n);

		float angle = TWO_PI / this.n;
		beginShape();
		for (float a = 0; a < TWO_PI; a += angle) {
			float sx = this.x + (s/4.0 + 3.0/4.0) * cos(a + this.a) * this.r;
			float sy = this.y + (s/4.0 + 3.0/4.0) * sin(a + this.a) * this.r;
			vertex(sx, sy);
		}
		endShape(CLOSE);
	}

	float distance(float x, float y) {
		return sqrt(sq(this.x - x) + sq(this.y - y)) - this.r;
	}
}
