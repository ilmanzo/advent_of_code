import std;

immutable int [4] dX = [ 0, -1,  0, +1];
immutable int [4] dY = [-1,  0, +1,  0];

struct Data {
    char [][] grid;
    int rows,cols;
    int Y,X; // current guard position
}

void main() {
    Data d;
    d.grid=stdin.byLineCopy.map !(q{a.dup}).array;
    d.rows=d.grid.length.to !(int);
    d.cols=d.grid.front.length.to !(int);
    d.Y=d.grid.countUntil !(line => line.canFind ('^')).to !(int);
    d.X=d.grid[d.Y].countUntil ('^').to!(int);
    d.walk.writeln;
}

ulong walk (Data d)
{
        auto dir = 0;
        int [][] visited = new int[][](d.rows,d.cols);
        while (!(visited[d.Y][d.X] & (1 << dir)))
        {
                visited[d.Y][d.X] |= 1 << dir;
                auto nX = d.X + dX[dir];
                auto nY = d.Y + dY[dir];
                if (nY < 0 || d.rows <= nY || nX < 0 || d.cols <= nX) 
                  return visited.map!(l => l.count !(q{a != 0})).sum;
                else if (d.grid[nY][nX] == '#') dir = (dir + 3) % 4;
                else { d.Y = nY; d.X = nX; }
        }
        return 0;
        
}