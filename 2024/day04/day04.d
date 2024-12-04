import std;

void main ()
{
	string [] a;
	foreach (s; stdin.byLineCopy) {	a ~= s;	}
	a.part1.writeln;
	a.part2.writeln;
}

int part1(string[] a) {
	int result = 0;
	foreach (i; 0..4) {	result += a.search_h; result += a.search_v; a = a.rotate90;	}
	return result;
}

int part2(string[] a) {
	int result = 0;
	foreach (i; 0..4) { result += a.search_x; a=a.rotate90; }
	return result;
}

pure string [] rotate90 (const string [] a)
{
	auto rows = a.length;
	auto cols = a.front.length;
	string [] result;
	foreach_reverse (col; 0..cols) { result ~= rows.iota.map !(row => a[row][col]).text; }
	return result;
}

pure int search_h (const string [] a)
{
	auto rows = a.length;
	auto cols = a.front.length;
	int result = 0;
	foreach (row; 0..rows) foreach (col; 0..cols - 5) {result += a[row][col..col + 4] == "XMAS";}
	return result;
}

pure int search_v (const string [] a)
{
	auto rows = a.length;
	auto cols = a.front.length;
	int result = 0;
	const XMAS="XMAS";
	foreach (row; 0..rows - 5) foreach (col; 0..cols - 5)
		{
			bool found = true;
			foreach (i; 0..4)	found &= (a[row + i][col + i] == XMAS[i]);
			result += found;
		}
	return result;
}

pure int search_x (const string [] a)
{
	auto rows = a.length;
	auto cols = a.front.length;
	int result = 0;
	foreach (row; 0..rows - 2) foreach (col; 0..cols - 2)
		{
			bool found = true;
			found &= (a[row + 0][col + 0] == 'M');
			found &= (a[row + 0][col + 2] == 'M');
			found &= (a[row + 1][col + 1] == 'A');
			found &= (a[row + 2][col + 0] == 'S');
			found &= (a[row + 2][col + 2] == 'S');
			result += found;
		}
	return result;
}

