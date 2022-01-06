float r = 0.9;
color blue = #212b37;

void setup() {
	size(1000, 1000);
	noLoop();
}

void draw() {
	float x, y, t, p, q;
	int j;
	Star s;
	translate(width/ 2, height/ 2);
	background(20);
	fill(blue);
	strokeWeight(5);
	stroke(255);
	circle(0, 0, r * height);

	int noConstellations = floor(random(10, 24));
	Constellation[] constellations = new Constellation[noConstellations];

	for (int i = 0; i < noConstellations; i++) {
		p = sqrt(random(0, r));
		q = random(0, 2 * PI);
		constellations[i] = new Constellation(p * cos(q), p * sin(q));
	}

	strokeWeight(1);
	stroke(45, 58, 73);

	for (int i = 6; i > 0; i--)
		circle(0, 0, i * r/6.0 * height);

	for (int i = 0; i < 180; i+=15)
		line(cos(radians(i)) * r * width / 2, sin(radians(i)) * r * width / 2, -cos(radians(i)) * r * width / 2, -sin(radians(i)) * r * width / 2);


	fill(255);

	for (int i = 0; i < 120; ) {
		p = sqrt(random(0, r));
		q = random(0, 2 * PI);
		s = new Star(p * cos(q), p * sin(q), (random(6, 9)));
		j = closestConstellation(constellations, s);
		if (constellations[j].addStar(s))
			i++;
	}

	noStroke();

	float milkyWayCenter = radians(random(0, 360));
	float mWX = cos(milkyWayCenter);
	float mWY = sin(milkyWayCenter);
	milkyWayCenter += PI/2;
	q = random(0, 0.1);

	for (int i = 0; i < 2000; ) {
		t = milkyWayCenter + random(0, PI);
		p = random(0.9, 1.2) + 0.08 * randomGaussian();
		x = mWX + cos(t) * (p + q * cos(3*t));
		y = mWY + sin(t) * (p + q * cos(3*t));
		if (x * x + y * y < 1) {
			s = new Star(x, y, sq(random(0, 1.5)));
			s.draw();
			i++;
		}
	}

	for (int i = 0; i < 500; i++) {
		p = sqrt(random(0, r));
		q = random(0, 2 * PI);
		s = new Star(p * cos(q), p * sin(q), (random(0, 1.5)));
		s.draw();
	}

	strokeWeight(2);
	for (int i = 0; i < noConstellations; i++)
		(constellations[i]).draw();

	noFill();
	strokeWeight(5);
	stroke(255);
	circle(0, 0, r * height);

	save("day03.png");
}

class Star
{
	float x, y, size;

	Star(float x, float y, float size) {
		this.x = x;
		this.y = y;
		this.size = size;
	}

	void draw() {
		circle(this.x * r * width / 2, this.y * r * height / 2, this.size);
	}

	float distanceToStar(Star s) {
		return sqrt(sq(this.x - s.x) + sq(this.y - s.y));
	}
}

class Edge
{
	Star A;
	Star B;

	Edge(Star A, Star B) {
		this.A = A;
		this.B = B;
	}

	void draw() {
		line(A.x * r * width / 2, A.y * r * width / 2, B.x * r * width / 2, B.y * r * width / 2);
	}

	float length() {
		return this.A.distanceToStar(this.B);
	}

	boolean intersects(Edge e) {

		if (e.A == this.A || e.A == this.B || e.B == this.A || e.B == this.B)
			return false;


		int o1 = orientation(e.A, e.B, this.A);
		int o2 = orientation(e.A, e.B, this.B);
		int o3 = orientation(this.A, this.B, e.A);
		int o4 = orientation(this.A, this.B, e.B);

		if (o1 != o2 && o3 != o4)
			return true;

		return false;
	}

	private int orientation(Star s1, Star s2, Star s3) {
		float v = (s2.y - s1.y) * (s3.x - s2.x) - (s2.x - s1.x) * (s3.y - s2.y);

		if (v == 0)
			return 0;

		return (v > 0) ? 1 : -1;
	}
}


class Constellation
{
	float x, y;
	Star[] stars;
	Edge[] edges;

	Constellation(float x, float y) {
		this.x = x;
		this.y = y;
		stars = new Star[] {};
		edges = new Edge[] {};
	}

	boolean addStar(Star star) {
		if (this.stars.length > 20)
			return false;

		star.x = this.x + 0.8 * (star.x - this.x);
		star.y = this.y + 0.8 * (star.y - this.y);

		for (int i=0; i < this.stars.length; i++)
			if (this.stars[i].distanceToStar(star) < 0.1)
				return false;

		this.stars = (Star[]) splice(this.stars, star, 0);

		return true;
	}

	void draw() {
		Star[] closestStars;
		stars = sortStars(stars);
		Edge edge;
		boolean intersects;
		int maxEdges;

		stroke(255);

		for (int i = 0; i < stars.length; i++) {
			closestStars = sortStarsByDistance(stars, stars[i]);
			maxEdges = min(closestStars.length, floor(random(3, 7)));

			for (int j = 1; j < maxEdges; j++) {
				edge = new Edge(stars[i], closestStars[j]);

				if (edge.length() > random(0.5))
					continue;

				intersects = false;

				for (int k = 0; k < edges.length; k++)
					intersects = intersects || edge.intersects(edges[k]);

				if (!intersects)
					edges = (Edge[]) append(edges, edge);
			}
		}

		for (int i = 0; i < edges.length; i++)
			edges[i].draw();


		stroke(blue);
		for (int i = 0; i < this.stars.length; i++)
			this.stars[i].draw();
	}

	float maxDistance() {
		float d, max = 0;

		for (int i = 0; i < stars.length; i++) {
			d = sq(this.x - this.stars[i].x) + sq(this.y - this.stars[i].y);
			max = (d > max) ? d : max;
		}

		return max;
	}
}

int closestConstellation(Constellation[] cs, Star s) {

	if (cs.length == 0) {
		return -1;
	}

	float min = 100, r;
	int minIndex = 0;

	for (int i = 0; i < cs.length; i++) {
		r = sq(cs[i].x - s.x) + sq(cs[i].y - s.y);
		if (r < min) {
			min = r;
			minIndex = i;
		}
	}

	return minIndex;
}


Star[] sortStars(Star[] s) {
	if (s.length <= 1)
		return s;
	else if (s.length == 2) {
		if (s[0].size > s[1].size)
			return s;
		else
			return new Star[] {s[1], s[0]};
	} else {
		Star[] l = {};
		Star[] h = {};

		for (int i = 1; i < s.length; i++) {
			if (s[i].size < s[0].size)
				l = (Star[]) splice(l, s[i], 0);
			else
				h = (Star[]) splice(h, s[i], 0);
		}

		return (Star[]) concat((Star[]) append(sortStars(h), s[0]), sortStars(l));
	}
}


Star[] sortStarsByDistance(Star[] s, Star st) {
	if (s.length <= 1)
		return s;
	else if (s.length == 2) {
		if (st.distanceToStar(s[0]) < st.distanceToStar(s[1]))
			return s;
		else
			return new Star[] {s[1], s[0]};
	} else {
		Star[] l = {};
		Star[] h = {};

		for (int i = 1; i < s.length; i++) {
			if (st.distanceToStar(s[i]) < st.distanceToStar(s[0]))
				l = (Star[]) splice(l, s[i], 0);
			else
				h = (Star[]) splice(h, s[i], 0);
		}

		return (Star[]) concat(append(sortStars(l), s[0]), sortStars(h));
	}
}
