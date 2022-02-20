int degree, iterations, hue, hueStart, skew;

void setup() {
	size(1000, 1000);
	noLoop();
}

void draw() {
	colorMode(HSB, 100);
	loadPixels();

	degree = floor(random(2, 7));
	iterations = floor(random(1, 5 - degree/3));
	hue = floor(random(5, 20));
	skew = floor(random(1, 5));
	hueStart = floor(random(0, 100 - hue - 10));

	double delta = 4.0 / width;
	double x = - 2.0;
	double y = - 2.0;
	Complex z;
	float s;

	for (int i = 0; i < width; i++) {
		x += delta;
		y = -2.0;
		for (int j = 0; j < height; j++) {
			y += delta;
			z = iterate(new Complex(x, y));
			s = (float) Math.sin(z.phase() + skew * Math.log(1 + z.abs()));
			pixels[i * width + j] = color((s * 5 + hueStart) % 100, 90, 90 + 10 * pow(s, 3.0));
		}
	}


	updatePixels();
	save("day16.png");
}

Complex iterate(Complex z) {
	for (int i = 0; i < iterations; i++)
		z = poly(z);

	return z;
}

Complex poly(Complex z) {
	Complex w = new Complex(1, 0);
	for (int i = 0; i < degree; i++)
		w = w.times(new Complex(Math.cos(i/((double) degree) * TWO_PI), Math.sin(i/((double) degree) * TWO_PI)).minus(z));

	return w;
}

class Complex {
	double re;
	double im;

	Complex(double re, double im) {
		this.re = re;
		this.im = im;
	}

	public double abs() {
		return Math.hypot(re, im);
	}

	public double phase() {
		return Math.atan2(im, re) + PI;
	}

	public Complex minus(Complex b) {
		return new Complex(this.re - b.re, this.im - b.im);
	}

	public Complex times(Complex b) {
		return new Complex(this.re * b.re - this.im * b.im, this.re * b.im + this.im * b.re);
	}
}
