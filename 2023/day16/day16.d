import std.stdio;
import std.file : readText;
import std.algorithm;
import std.range;
import std.conv;
import std.string;
import std.format;
import std.ascii;
import std.traits;

import vector;

void main(string[] args)
{
    auto input = readText("input.txt").splitter('\n').filter!(v => !v.empty).array;
    auto part1 = energize(input, Beam(Vector(0, 0), Vector(1, 0)));
    writeln("Part1=", part1);
    writeln("Part2=", part2(input));
}

struct Beam
{
    Vector pos;
    Vector velocity;
    pure Beam move()
    {
        return Beam(pos + velocity, velocity);
    }

    pure Beam move(Vector newv)
    {
        return Beam(pos + newv, newv);
    }
}

size_t part2(const string[] input)
{
    auto height = input.length;
    auto width = input[0].length;
    // TODO instead of collecting all the results, we can also keep the running max value
    size_t[] results;
    foreach (i; 0 .. height)
    {
        results ~= energize(input, Beam(Vector(0, i), Vector(1, 0)));
        results ~= energize(input, Beam(Vector(width - 1, i), Vector(-1, 0)));
    }
    foreach (i; 0 .. width)
    {
        results ~= energize(input, Beam(Vector(i, 0), Vector(0, 1)));
        results ~= energize(input, Beam(Vector(i, height - 1), Vector(0, -1)));
    }
    return results.reduce!(max);

}

size_t energize(const string[] input, const Beam start)
{
    auto height = input.length;
    auto width = input[0].length;

    bool[Beam] visited;
    bool[Vector] energized;
    Beam[] edges = [start];
    visited[start] = true;
    energized[start.pos] = true;
    while (edges.length > 0)
    {
        Beam[] newEdges;
        void addEdge(Beam s)
        {
            if (s.pos.x >= 0 && s.pos.x < width && s.pos.y >= 0 && s.pos.y < height && !(s in visited))
            {
                visited[s] = true;
                energized[s.pos] = true;
                newEdges ~= s;
            }
        }

        foreach (s; edges)
        {
            auto passthru = true;
            switch (input[s.pos.y][s.pos.x])
            {
            case '\\':
                passthru = false;
                addEdge(s.move(s.velocity.x != 0 ? s.velocity.right : s.velocity.left));
                break;
            case '/':
                passthru = false;
                addEdge(s.move(s.velocity.x != 0 ? s.velocity.left : s.velocity.right));
                break;
            case '-':
                if (s.velocity.y != 0)
                {
                    passthru = false;
                    addEdge(s.move(Dir.left));
                    addEdge(s.move(Dir.right));
                }
                break;
            case '|':
                if (s.velocity.x != 0)
                {
                    passthru = false;
                    addEdge(s.move(Dir.up));
                    addEdge(s.move(Dir.down));
                }
                break;
            default:
                break;
            }
            if (passthru)
                addEdge(s.move);
        }
        edges = newEdges;
    }
    return energized.length;
}
