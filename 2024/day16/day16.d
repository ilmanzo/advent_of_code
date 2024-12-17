import std;

void main ()
{
    auto grid=new Grid();
    auto p1=new Part1(grid);
    writeln(p1.dijkstra);
}

immutable int [4] dY = [-1,  0, +1,  0];
immutable int [4] dX = [ 0, -1,  0, +1];

struct Point {
    int y;
    int x;
    int dir;
}

class Grid {
    char[][] maze;
    Point start,end;
    int height,width;
    this() {
    	maze = stdin.byLineCopy.map!("a.dup").array;
    	height = maze.length.to!(int);
    	width = maze.front.length.to!(int);
        foreach (y; 0..height)
            foreach (x; 0..width)
            {
                if (maze[y][x] == 'S')
                {
                    start = Point(y, x, 3);
                    maze[y][x] = '.';
                }
                if (maze[y][x] == 'E')
                {
                    end = Point(y, x, 1);
                    maze[y][x] = '.';
                }
            }
        }
}

class Part1 {
    int[4][][]score;
    Grid grid;
    Point[] queue;
    this(Grid g) {
        score=new int [4][][](g.height,g.width);
    	foreach (ref x; score)
	    	foreach (ref y; x)
		    	y[] = int.max / 2;
        grid=g;
        this.add(g.start,0);
    }
	void add(Point p, int newscore)
	{
		if (grid.maze[p.y][p.x] != '#' && score[p.y][p.x][p.dir] > newscore)
		{
			queue ~= p;
			score[p.y][p.x][p.dir] = newscore;
		}
	}
    int dijkstra() {
        while (!queue.empty)
        {
            auto c = queue.front;
            queue.popFront();
            queue.assumeSafeAppend();
            auto newscore = score[c.y][c.x][c.dir];
            add(Point(c.y + dY[c.dir], c.x + dX[c.dir], c.dir), newscore + 1);
            add(Point(c.y, c.x, (c.dir + 1) % 4), newscore + 1000);
            add(Point(c.y, c.x, (c.dir + 3) % 4), newscore + 1000);
        }
        return score[grid.end.y][grid.end.x][].minElement;
    }
}
