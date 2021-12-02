import std.array,std.algorithm, std.stdio, std.conv, std.typecons;

alias Instruction=Tuple!(string,"direction",int,"value");

auto parseLine(string line) {
    Instruction instr;
    auto tokens=line.split();
    instr.direction=tokens[0];
    instr.value=tokens[1].to!int;
    return instr;
}

int part1(string[] lines) {
    auto position=0;
    auto depth=0;
    foreach (l ; lines) {
        auto instr=l.parseLine;
        switch (instr.direction) {
            case "up":
                depth-=instr.value;
                break;
            case "down":
                depth+=instr.value;
                break;
            case "forward":
                position+=instr.value;
                break;
            default:
                break;
        }
    }
    return position*depth;
}

int part2(string[] lines) {
    auto position=0;
    auto depth=0;
    auto aim=0;
    foreach (l ; lines) {
        auto instr=l.parseLine;
        switch (instr.direction) {
            case "up":
                aim-=instr.value;
                break;
            case "down":
                aim+=instr.value;
                break;
            case "forward":
                position+=instr.value;
                depth+=aim*instr.value;
                break;
            default:
                break;
        }
    }
    return position*depth;
}

void main()
{
    auto lines=File("../input.txt").byLine().map!(to!string).array;
    writeln(part1(lines));
    writeln(part2(lines));
}