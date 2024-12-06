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
    d.Y=d.grid.countUntil !(l => l.canFind ('^')).to !(int);
    d.X=d.grid[d.Y].countUntil ('^').to!(int);
    // part1: count the steps until exit 
    d.walk.writeln;
    // part2: try to fill each possible cell to see if it ends in a loop
    int part2=0;
    foreach (y; 0..d.rows)
        foreach (x; 0..d.cols)
          if (d.grid[y][x] == '.') {
             d.grid[y][x] = '#';
             if (d.walk==0) part2++;
             d.grid[y][x] = '.';
          }
    part2.writeln;
}

ulong walk (Data d)
{
    auto dir = 0;
    int [][] visited = new int[][](d.rows,d.cols);
    while (!(visited[d.Y][d.X] & (1 << dir))) {
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