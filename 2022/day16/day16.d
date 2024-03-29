import std.stdio;
import std.algorithm;
import std.file : readText;
import std.conv;
import std.format;
import std.string;
import std.range;
import std.array;
import std.math;

static struct valve
{
    string name;
    string[] edgenames;
    size_t[] edges;
    int flow;
    int mask;
}

int[][] makestate(valve[] cave, int nvalves)
{
    int[][] result = new int[][](cave.length, 1 << nvalves);
    foreach (ref r; result)
        r[] = -1;
    return result;
}

void main(string[] args)
{
    auto input = readText(args[1]).strip.split('\n');

    valve[] cave;
    size_t[string] valveidx;
    // first, read the cave names
    int nvalves = 0;
    foreach (ln; input)
    {
        valve v;
        string edgespec;
        ln.formattedRead("Valve %s has flow rate=%s;%s", &v.name, &v.flow, &edgespec);
        auto edges = edgespec.split(',');
        edges[0] = edges[0].split[$ - 1];
        v.edgenames = edges.map!(e => e.strip).array;
        if (v.flow > 0)
            v.mask = 1 << (nvalves++);
        cave ~= v;
        valveidx[v.name] = cave.length - 1;
    }
    //writeln(cave);

    foreach (ref v; cave)
        v.edges = v.edgenames.map!(en => valveidx[en]).array;

    auto state = makestate(cave, nvalves);
    // part 1
    auto aaidx = valveidx["AA"];
    state[aaidx][0] = 0;
    foreach (m; 0 .. 30)
    {
        //writefln("minute %s state is \n%(%(% 3s%)\n%)", m, state);
        auto newstate = makestate(cave, nvalves);
        foreach (i; 0 .. state.length)
        {
            auto newflow = (29 - m) * cave[i].flow;
            foreach (j; 0 .. state[i].length)
            {
                if (state[i][j] >= 0)
                {
                    if (newflow && !(cave[i].mask & j))
                    {
                        // can turn on this valve this minute
                        auto nm = cave[i].mask | j;
                        newstate[i][nm] = max(newstate[i][nm], state[i][j] + newflow);
                    }

                    // can move to one of the given rooms
                    foreach (e; cave[i].edges)
                    {
                        newstate[e][j] = max(newstate[e][j], state[i][j]);
                    }
                }
            }
        }
        state = newstate;
    }
    int p1;
    foreach (r; state)
        foreach (v; r)
        {
            p1 = max(p1, v);
        }
    writeln("part1: ", p1);

    // part 2
    state = makestate(cave, nvalves);
    state[aaidx][0] = 0;
    foreach (player; 0 .. 2) // me and elephant
    {
        foreach (m; 4 .. 30)
        {
            //writefln("minute %s state is \n%(%(% 3s%)\n%)", m, state);
            auto newstate = makestate(cave, nvalves);
            foreach (i; 0 .. state.length)
            {
                auto newflow = (29 - m) * cave[i].flow;
                foreach (j; 0 .. state[i].length)
                {
                    if (state[i][j] >= 0)
                    {
                        if (newflow && !(cave[i].mask & j))
                        {
                            // can turn on this valve this minute
                            auto nm = cave[i].mask | j;
                            newstate[i][nm] = max(newstate[i][nm], state[i][j] + newflow);
                        }

                        // can move to one of the given rooms
                        foreach (e; cave[i].edges)
                        {
                            newstate[e][j] = max(newstate[e][j], state[i][j]);
                        }
                    }
                }
            }
            state = newstate;
        }

        // the elephant starts at the max value for all states, but must start in room AA
        if (player == 0)
        {
            auto newstate = makestate(cave, nvalves);
            foreach (i; 0 .. state.length)
                foreach (j; 0 .. state[i].length)
                {
                    newstate[aaidx][j] = max(newstate[aaidx][j], state[i][j]);
                }
            state = newstate;
        }
    }

    int p2;
    foreach (r; state)
        foreach (v; r)
        {
            p2 = max(p2, v);
        }
    writeln("part2: ", p2);
}
