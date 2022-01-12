void setup() {
	size(1000, 1000);
	noLoop();
}

void draw() {
	ArrayList<Circle> circles = new ArrayList<Circle>();
	Circle c;
	float x, y, min, d, t;

	background(20, 30, 40);
	stroke(20, 30, 40);
	fill(230, 223, 200);

	for (int i = 0; i < 300000; i++) {
		x = random(800);
		y = random(800);

		min = min(min(x, 800 - x), min(y, 800 - y));

		d = 0;

		for (Circle cc : circles) {
			d = cc.distance(x, y);
			if (d < 0) break;
			min = (min < d) ? min : d;
		}

		if (d < 0) continue;
		if (min < 3 || min > 200) continue;

		c = new Circle(x, y, min - 1);
		circles.add(c);
		c.draw();
	}
	
	save("day12.png");
}

class Circle
{
	float x, y, r;

	Circle(float x, float y, float r) {
		this.x = x;
		this.y = y;
		this.r = r;
	}

	void draw() {
		int d = floor(this.r / 10) + 1;
		for(int i = d; i > 0; i--)
			circle(100 + this.x, 100 + this.y, 2 * i * this.r/d);
	}

	float distance(float x, float y) {
		return sqrt(sq(this.x - x) + sq(this.y - y)) - this.r;
	}
}
