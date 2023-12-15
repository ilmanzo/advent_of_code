import std.stdio;
import std.file : readText;
import std.algorithm;
import std.range;
import std.conv;
import std.string;
import std.format;
import std.ascii;
import std.math;
import std.traits;

class Board
{
    char[][] data;
    size_t width;
    size_t height;

    this(string filename)
    {
        data = readText(filename).splitter('\n').filter!(v => !v.empty)
            .map!(v => v.dup)
            .array;
        width = data[0].length;
        height = data.length;
    }

    // void dup()
    // {
    //     data = data.dup.map!(v => v.dup).array;
    // }

    public void north()
    {
        foreach (x; 0 .. width)
        {
            size_t target = 0;
            foreach (y; 0 .. height)
            {
                if (data[y][x] == 'O')
                {
                    if (target != y)
                    {
                        data[target][x] = 'O';
                        data[y][x] = '.';
                    }
                    ++target;
                }
                else if (data[y][x] == '#')
                {
                    target = y + 1;
                }
            }
        }
    }

    void west()
    {
        foreach (y; 0 .. height)
        {
            size_t target = 0;
            foreach (x; 0 .. width)
            {
                if (data[y][x] == 'O')
                {
                    if (target != x)
                    {
                        data[y][target] = 'O';
                        data[y][x] = '.';
                    }
                    ++target;
                }
                else if (data[y][x] == '#')
                {
                    target = x + 1;
                }
            }
        }

    }

    void south()
    {
        foreach (x; 0 .. width)
        {
            size_t target = height - 1;
            foreach_reverse (y; 0 .. height)
            {
                if (data[y][x] == 'O')
                {
                    if (target != y)
                    {
                        data[target][x] = 'O';
                        data[y][x] = '.';
                    }
                    --target;
                }
                else if (data[y][x] == '#')
                {
                    target = y - 1;
                }
            }
        }
    }

    void east()
    {
        foreach (y; 0 .. height)
        {
            size_t target = width - 1;
            foreach_reverse (x; 0 .. width)
            {
                if (data[y][x] == 'O')
                {
                    if (target != x)
                    {
                        data[y][target] = 'O';
                        data[y][x] = '.';
                    }

                    --target;
                }
                else if (data[y][x] == '#')
                {
                    target = x - 1;
                }
            }
        }
    }

    void cycle()
    {
        this.north;
        this.west;
        this.south;
        this.east;
    }

    public size_t calc_load_on_north()
    {
        size_t result = 0;

        foreach (x; 0 .. width)
        {
            foreach (y; 0 .. height)
            {
                if (data[y][x] == 'O')
                    result += height - y;
            }
        }
        return result;
    }

}

auto part1(string filename)
{
    auto board = new Board(filename);
    board.north();
    return board.calc_load_on_north;
}

size_t part2(string filename)
{
    auto board1 = new Board(filename);
    auto board2 = new Board(filename);

    size_t cycles = 0;
    size_t cyclelength = 0;
    while (cycles < 1_000_000_000)
    {
        ++cycles;
        board1.cycle;
        board2.cycle;
        board2.cycle;
        if (board1 == board2)
        {
            do
            {
                board1.cycle;
                ++cyclelength;
            }
            while (board1 != board2);
            break;
        }
    }
    foreach (i; 0 .. (1_000_000_000 - cycles) % cyclelength)
        board1.cycle;
    return board1.calc_load_on_north;
}

void main(string[] args)
{
    auto part1 = part1(args[1]);
    writeln("Part1=", part1);
    auto part2 = part2(args[1]);
    writeln("Part2=", part2);
}
