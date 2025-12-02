import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.range; 

bool isInvalidId1(string id)
{
    auto mid = id.length / 2;
    return id.length > 0 && id.length % 2 == 0 && id[0 .. mid] == id[mid .. $];
}

bool isInvalidId2(string id)
{
    auto m = id.length;
    foreach (k; 2 .. m + 1)
    {
        if (m % k == 0)
        {
            auto firstToken = id[0 .. m / k];
            if (firstToken.replicate(k).equal(id)) return true;
        }
    }
    return false;
}

void main()
{
    auto ranges = stdin.readln().strip.split(',').map!(pair => pair.split('-').map!(to!long));
    auto numbers = ranges.map!(r => iota(r[0], r[1] + 1).map!(to!string)).joiner;
    writeln(numbers.filter!isInvalidId1.map!(to!long).sum);
    writeln(numbers.filter!isInvalidId2.map!(to!long).sum);
}
