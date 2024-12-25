import std;
import std.datetime.stopwatch;

pure uint match(const string[] lock, const string[] key)
{
    foreach (y; 0 .. 6)
        foreach (x; 0 .. 5)
            if (lock[y][x] == '#' && key[y][x] == '#')
                return 0;
    return 1;
}

void main()
{
    string[][] locks,keys;
    foreach(l;stdin.byLineCopy.array.split("")) if(l[0].startsWith('#')) locks~=l; else keys~=l;
    uint part1 = 0;
    auto sw=StopWatch(AutoStart.yes);
    foreach (ref l; locks) foreach (ref k; keys) part1+=match(l, k);
    writeln("Time for part1 (naive): ",sw.peek);
    part1.writeln;
}
