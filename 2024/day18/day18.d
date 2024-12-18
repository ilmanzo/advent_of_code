import std;

immutable int [4] dY = [-1,  0, +1,  0];
immutable int [4] dX = [ 0, -1,  0, +1];

struct Point {
    int y;
    int x;
}

class Grid {
    char [][]board;
    int height,width;
    Point start,end;
    this() {
        auto input = stdin.byLineCopy.map!(l => l.split (',').to !(int []))
            .map!(p => Point(p[0], p[1])).array;
        height=input.map!("a.y").maxElement + 1;
        width=input.map!("a.x").maxElement + 1;
        start = Point(0, 0);
        end = Point(height - 1, width - 1);
        input = (input.length < 1024 ? input[0..12] : input[0..1024]);
        board = new char [] [] (height, width);
        board.each!((ref line) => line[]='.');
        input.each!((ref c) => board[c.y][c.x] = '#');
    }
}

class Queue {
	Point[] queue;
    Grid g;
    int[][] d;

    this() {
        d = new int [][](g.height, g.width);
        d.each!((ref line) => line[]=int.max/4);
        queue.add(g.start, 0);
    }

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
	Point remove()
	{
		auto res = queue.front;
		queue.popFront ();
		queue.assumeSafeAppend ();
		return res;
	}
    bool isEmpty() {return queue.empty;}
}


void main ()
{
    auto g=new Grid();
    queue=new Queue(g);
	while (!queue.isEmpty())
	{
		auto c = queue.remove();
		auto dist = d[c.y][c.x];
		foreach (dir; 0..4)
		{
			auto v = Point(c.y + dY[dir], c.x + dX[dir]);
			queue.add(v, dist + 1);
		}
	}
	d[g.end.y][g.end.x].writeln;
}