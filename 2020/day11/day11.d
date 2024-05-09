import std.stdio : stdin, writeln;
import std.algorithm : map, count, sum, filter;
import std.range : only;
import std.typecons : tuple;
import std.array : array;

void main()
{
    char[][] input = stdin.byLine.map!dup.array;
    part(1, input);
    part(2, input);
}

void part(int p, char[][] input)
{
    while (true)
    {
        auto next = p.nextGen(input);
        if (next == input)
        {
            next.map!(row => row.count('#')).sum.writeln();
            break;
        }
        input = next.map!dup.array;
    }
}

char[][] nextGen(int p, char[][] current)
{
    char[][] next = current.map!dup.array;

    foreach (y; 0 .. current.length) {
        foreach (x; 0 .. current[0].length) {
            switch (current[y][x]) {
            case 'L':
                if (
                 (p==1 && current.getNeighbors(x, y).count('#') == 0) || 
                 (p==2 && current.countOccupiedSeats(x, y) == 0)
                 ) next[y][x] = '#';
                break;
            case '#':
                if (
                    (p==1 && current.getNeighbors(x, y).count('#') >= 4) ||
                    (p==2 && current.countOccupiedSeats(x, y) >= 5)
                   ) next[y][x] = 'L';
                break;
            default:
                next[y][x] = current[y][x];
                break;
            }
        }
    }
    return next;
}

auto offsets() {
    return [
        tuple(-1, -1), tuple(-1, 0), tuple(-1, 1), tuple(0, -1), tuple(0, 1),tuple(1, -1), tuple(1, 0), tuple(1, 1)
    ];
} 

auto getNeighbors(char[][] grid, int x, int y)
{
    return only(offsets()).map!(
            pair => tuple(x + pair[0], y + pair[1]))
        .filter!(pair => grid.withinBounds(pair[0], pair[1]))
        .map!(pair => grid[pair[1]][pair[0]]);
}

bool withinBounds(char[][] grid, int x, int y)
{
    return 0 <= x && x < grid[0].length && 0 <= y && y < grid.length;
}

ulong countOccupiedSeats(char[][] grid, ulong x, ulong y)
{
 
    ulong count = 0;
    foreach (offset; offsets()) {
        auto current = tuple(x + offset[0], y + offset[1]);
        while (grid.withinBounds(current.expand)) {
            if (grid[current[1]][current[0]] == 'L') break;
            if (grid[current[1]][current[0]] == '#')
            {
                count++;
                break;
            }
            current[0] += offset[0];
            current[1] += offset[1];
        }
    }
    return count;
}
