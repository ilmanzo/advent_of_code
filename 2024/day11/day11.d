import std;
import std.datetime.stopwatch;

void main()
{
    auto sw = StopWatch(AutoStart.no);
    auto input = readln.split.to!(ulong[]);
    sw.start();
    input.map!(x => fastblink(x, 25)).sum.writeln;
    writeln("Time for part1:", sw.peek());
    input.map!(x => fastblink(x, 75)).sum.writeln;
    sw.reset();
    writeln("Time for part2:", sw.peek());
}

alias fastblink = memoize!(blink);
ulong blink(const ulong n, const int s)
{
    if (!s) return 1;
    if (!n) return fastblink(1, s - 1);
    auto t = n.text;
    return t.length % 2 ? fastblink(n * 2024, s - 1) : 
        fastblink(t[0 .. $ / 2].to!(ulong), s - 1) + fastblink(t[$ / 2 .. $].to!(ulong), s - 1);
}
