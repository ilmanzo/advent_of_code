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

// get array of lengths for each vertical stripe of '#'
uint[5] getVertLengths(const string[] s) {
        uint[5] result;
        foreach (y; 0 .. 7) foreach (x; 0 .. 5) if (s[y][x] == '#') result[x]++;
        return result;
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
    auto l2=locks.map!(l=>getVertLengths(l));
    auto k2=keys.map!(k=>getVertLengths(k));
    part1=0;
    sw.reset();
    foreach(l;l2) foreach(k;k2) if (l[0]+k[0]<=7 && l[1]+k[1]<=7 && l[2]+k[2]<=7 && l[3]+k[3]<=7 && l[4]+k[4]<=7) part1++;
    writeln("Time for part1 (numeric): ",sw.peek);
    part1.writeln;
}
