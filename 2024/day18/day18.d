import std;


void main ()
{
    auto g=new Grid();
	g.fill(1024);
	part1(g).writeln;
}

immutable int [4] dY = [-1,  0, +1,  0];
immutable int [4] dX = [ 0, -1,  0, +1];

struct Point {
    int y;
    int x;
}

class Grid {
    char [][]board;
	Point []input;
    int height,width;
    Point start,end;
    this() {
        input = stdin.byLineCopy.map!(l => l.split (',').to !(int[])).map!(p=>Point(p[0], p[1])).array;
        height=input.map!("a.y").maxElement + 1;
        width=input.map!("a.x").maxElement + 1;
        start = Point(0, 0);
        end = Point(height - 1, width - 1);
		board = new char [] [] (height, width);
	}
	void fill(int limit) {
		limit=input.length<1024?12:limit;
		board.each!((ref line) => line[]='.');
		foreach (ref p; input[0..limit]) board[p.y][p.x] = '#';
	}
}

int part1(Grid g) {
	Point[] queue;
    auto d = new int [][](g.height, g.width);
    d.each!((ref line) => line[]=int.max/4);
	void add (Point p, int dist)
	{
		if (0 <= p.y && p.y < g.height &&
		    0 <= p.x && p.x < g.width &&
		    g.board[p.y][p.x] != '#' &&
		    d[p.y][p.x] > dist)
		{
			queue ~= p;
			d[p.y][p.x] = dist;
		}
	}
    add(g.start, 0);
	while (!queue.empty)
	{
		auto c = queue.front;
		queue.popFront ();
		queue.assumeSafeAppend ();
		auto dist = d[c.y][c.x];
		foreach (dir; 0..4)
		{
			auto v = Point(c.y + dY[dir], c.x + dX[dir]);
			add(v, dist + 1);
		}
	}
	return d[g.end.y][g.end.x];	
}

int part2(Grid g) {
	
}