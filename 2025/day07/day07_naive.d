import std.stdio;
import std.file;
import std.string;
import std.datetime.stopwatch;

struct Pos { int y, x; }

long solve(immutable string[] grid, const bool part2)
{
    auto startCol = cast(int) grid[0].indexOf('S');
    auto startPos = Pos(0, startCol);
    immutable n = grid.length;
    auto dp = [startPos: 1L];
    long res = part2 ? 1L : 0L;
    foreach (_; 0 .. n - 1)
    {
        auto ndp = typeof(dp).init;
        foreach (pos, cur; dp)
        {
            if (pos.y == n - 1)  continue;
            auto inc = part2 ? cur : 1L;
            auto nextY = pos.y + 1;
            auto curX = pos.x;
            if (grid[nextY][curX] == '^')
            {
                res += inc;
                ndp[Pos(nextY, curX - 1)] += inc;
                ndp[Pos(nextY, curX + 1)] += inc;
            }
            else ndp[Pos(nextY, curX)] += inc;
        }
        dp = ndp;
    }
    return res;
}

void main(string[] args)
{
    immutable grid = readText(args[1]).strip.splitLines;
    auto sw = StopWatch(AutoStart.yes);
    writeln("Part 1: ", solve(grid, false));
    writeln("Time: ", sw.peek());
    sw.reset();
    writeln("Part 2: ", solve(grid, true));
    writeln("Time: ", sw.peek());
}