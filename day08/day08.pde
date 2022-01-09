char[] instructions;

String ruleA = "A+BF++BF-FA--FAFA-BF+";
String ruleB = "-FA+BFBF++BF+FA--FA-B";

int n = 5;

void setup() {
	size(1100, 1100);
	background(20, 30, 40);
	noLoop();
	strokeWeight(3);
	char[] axiom = new char[]{'B'};
	instructions = generateInstructions(axiom, n);
	colorMode(HSB);
}

char[] generateInstructions(char[] instructions, int depth) {
	if (depth == 0)
		return instructions;

	char[] result = {};

	for (char c : instructions)
		switch(c) {
		case 'A':
			result = concat(result, ruleA.toCharArray());
			break;
		case 'B':
			result = concat(result, ruleB.toCharArray());
			break;
		default:
			result = append(result, c);
		}

	return generateInstructions(result, depth - 1);
}

void draw() {
	scale(0.8);
	translate(420, 100);
	for (int i =0; i < instructions.length; i++) {
		stroke( 20 * sin((i * 6617.0) / instructions.length) + 200, 200, 220);
		switch(instructions[i]) {
		case 'F':
			line(0, 0, width * pow(2, -n - 2), 0);
			translate(width * pow(2, -n - 2), 0);
			stroke(0, 0, 0);
			break;
		case '+':
			rotate(PI / 3.0);
			break;
		case '-':
			rotate(- PI/ 3.0);
			break;
		}
	}

	save("day08.png");
}
