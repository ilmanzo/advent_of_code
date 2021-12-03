
import std.array,std.algorithm, std.stdio, std.conv, std.algorithm.searching;

string majorityBits(string[] lines)
{
    auto result="";
    for(auto i=0; i<12;i++) {
        auto ones=0;
        foreach(s; lines) { if (s[i]=='1') ones++; }
        auto bit=(ones>=lines.length/2)? '1' : '0';
        result ~=bit;
    }
    return result;
}

int part1(string[] input)
{
    auto gamma=to!int(majorityBits(input),2);
    auto epsilon=((2^^12-1)-gamma);
    return gamma*epsilon;
}

void main()
{
    auto input=File("../input.txt").byLine().map!(to!string).array;
    input.part1.writeln;
}
