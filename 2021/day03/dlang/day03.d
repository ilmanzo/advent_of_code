
import std.array,std.algorithm, std.stdio, std.conv, std.algorithm.searching;

string majorityBits(string[] lines, bool flag)
{
    auto result="";
    for(auto i=0; i<12;i++) {
        auto ones=0;
        foreach(s; lines) { if (s[i]=='1') ones++; }
        char bit;
        if (flag) {
            bit=(ones>=lines.length/2)? '1':'0';
        } else {
            bit=(ones<lines.length/2)? '1':'0';
        }
        result ~=bit;

    }
    return result;
}

int part1(string[] input)
{
    auto gamma=to!int(majorityBits(input,true),2);
    //auto epsilon=((2^^12-1)-gamma);   // can be also calculated
    auto epsilon=to!int(majorityBits(input,false),2);
    return gamma*epsilon;
}

string reduce(string[] input, bool flag)
{
    auto result=input.dup;
    auto i=0;
    while(result.length>1) {
        auto bitstring=majorityBits(result,flag);
        result=filter!((s) => s[i]==bitstring[i])(result).array;   
        i++;
    }
    return result[0];
}

// TODO needs some debugging
int part2(string[] input)
{
    auto oxygen=to!int(reduce(input,true),2);
    auto co2=to!int(reduce(input,false),2);
    return oxygen*co2;
}

void main()
{
    auto input=File("../input.txt").byLine().map!(to!string).array;
    input.part1.writeln;
    //input.part2.writeln;
}
