import java.util.*;

void setup() {
	size(800, 800);
	noLoop();
}

void draw() {
	background(20, 20, 20);
	float a = 12;

	strokeWeight(a / 2);
	colorMode(HSB);
	stroke(month() * 20, 240, 200);

	long d = (new Date()).getTime();
	int[] timestamp = {};

	do {
		timestamp = append(timestamp, (int)(d % 2));
		d = (d - d % 2) / 2;
	} while (d != 0);

	translate((width - a * timestamp.length) / 2, (width - a * timestamp.length) / 2);
	
	int k = ceil((width / a - timestamp.length) / 2) + 1;

	for (int i = 0; i < timestamp.length; i++)
		for (int j = timestamp[i] - k; j < timestamp.length + k; j+=2)
			line(a * j, a * i, a * (j + 1), a * i);

	for (int i = 0; i < timestamp.length; i++)
		for (int j = timestamp[i] - k; j < timestamp.length + k; j+=2)
			line(a * i, a * j, a * i, a * (j + 1));

	save("day22.png");
}
