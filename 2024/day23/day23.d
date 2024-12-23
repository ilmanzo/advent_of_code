import std;
import std.datetime.stopwatch;

void main(string[] args) {
    string[string] conns;
    auto input=stdin.byLineCopy.map!(l => l.split ("-"));
    foreach (ref items; input) {
        auto a = items[0], b=items[1];
        conns[a] ~= b;
        conns[b] ~= a;
    }
    auto xs = conns.keys.array.sort;
    auto sw = StopWatch(AutoStart.yes);
    int part1 = 0;
    for (int i = 0; i < xs.length; i++) {
        auto a = xs[i];
        for (int j = i + 1; j < xs.length; j++) {
            auto b = xs[j];
            for (int k = j + 1; k < xs.length; k++) {
                auto c = xs[k];
                if (conns[b].canFind(a) && conns[c].canFind(a) && conns[c].canFind(b) 
                    && (a[0]=='t' || b[0]=='t' || c[0]=='t')) part1++;
            }
        }
    }
    part1.writeln;
    writeln("Time for part1: ",sw.peek);
    sw.reset();
    ulong best=0;
    foreach (t; 0 .. 100) {
        xs=xs.randomShuffle;
        string[] clique;
        foreach (ref x; xs) {
            auto ok = true;
            foreach (ref y; clique) if (!conns[y].canFind(x)) {ok = false; break; }
            if (ok) clique ~= x;
        }
        if (clique.length > best) { 
            best = clique.length;
            writeln(clique.sort.join(",")); 
        }
    }
    writeln("Time for part2: ",sw.peek);
}