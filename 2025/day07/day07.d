import std.stdio;
import std.file;
import std.string;
import std.datetime.stopwatch;
import std.algorithm;
import std.array;
import std.bitmanip;
import std.range;

long part1(const ref BitArray trap_grid, int width, int trap_grid_height, int startX)
{
    long res = 0L;
    bool[int] dp = [startX: true];
    for (int trap_row_idx = 1; trap_row_idx < trap_grid_height; ++trap_row_idx)
    {
        if (dp.empty) break;
        bool[int] ndp;
        foreach (curX, _; dp)
        {
            if (trap_grid[trap_row_idx * width + curX])
            {
                res++;
                ndp[curX - 1] = true;
                ndp[curX + 1] = true;
            }
            else
            {
                ndp[curX] = true;
            }
        }
        dp = ndp;
    }
    return res;
}

long part2(const ref BitArray trap_grid, int width, int trap_grid_height, int startX)
{
    long res = 1L;
    auto dp = [startX: 1L];
    for (int trap_row_idx = 1; trap_row_idx < trap_grid_height; ++trap_row_idx)
    {
        if (dp.empty) break;
        long[int] ndp;
        foreach (curX, cur; dp)
        {
            if (trap_grid[trap_row_idx * width + curX])
            {
                res += cur;
                ndp[curX - 1] += cur;
                ndp[curX + 1] += cur;
            }
            else
            {
                ndp[curX] += cur;
            }
        }
        dp = ndp;
    }
    return res;
}

void main(string[] args)
{
    immutable all_lines = readText(args[1]).strip.splitLines.array;
    immutable original_height = cast(int) all_lines.length;
    immutable width = original_height > 0 ? all_lines[0].length : 0;

    // Traps are on even rows. Create a grid of only the even rows.
    string[] trap_lines;
    trap_lines.reserve(all_lines.length / 2 + 1);
    foreach(i, line; all_lines)
    {
        if (i % 2 == 0)
            trap_lines ~= line;
    }
    immutable trap_grid_height = cast(int) trap_lines.length;

    BitArray trap_grid;
    trap_grid.length = width * trap_grid_height;
    foreach (y, row; trap_lines)
    {
        foreach (x, c; row)
        {
            if (c == '^') trap_grid[y * width + x] = true;
        }
    }
    auto startX = cast(int) all_lines[0].indexOf('S');

    auto sw = StopWatch(AutoStart.yes);
    writeln("Part 1: ", part1(trap_grid, cast(int)width, trap_grid_height, startX));
    writeln("Time: ", sw.peek());
    sw.reset();
    writeln("Part 2: ", part2(trap_grid, cast(int)width, trap_grid_height, startX));
    writeln("Time: ", sw.peek());
}