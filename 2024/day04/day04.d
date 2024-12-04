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
	foreach (i; 0..4) {	result += search_pt1_a (a, "XMAS"); result += search_pt1_b (a, "XMAS"); a = a.rotate90;	}
	return result;
}

int part2(string[] a) {
	int result = 0;
	foreach (i; 0..4) { result += a.search_pt2; a=a.rotate90; }
	return result;
}

string [] rotate90 (string [] a)
{
	auto rows = a.length;
	auto cols = a.front.length;
	string [] result;
	foreach_reverse (col; 0..cols) { result ~= rows.iota.map !(row => a[row][col]).text; }
	return result;
}

int search_pt1_a (string [] a, string p)
{
	auto rows = a.length;
	auto cols = a.front.length;
	auto len = p.length;
	int result = 0;
	foreach (row; 0..rows) foreach (col; 0..cols - len + 1) {result += a[row][col..col + len] == p;}
	return result;
}

int search_pt1_b (string [] a, string p)
{
	auto rows = a.length;
	auto cols = a.front.length;
	auto len = p.length;
	int result = 0;
	foreach (row; 0..rows - len + 1) foreach (col; 0..cols - len + 1)
		{
			bool found = true;
			foreach (i; 0..len)	found &= (a[row + i][col + i] == p[i]);
			result += found;
		}
	return result;
}

int search_pt2 (string [] a)
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

