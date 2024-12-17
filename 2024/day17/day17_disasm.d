import std;

long parse(string input, string regexp) {
    return input.strip.findSplitAfter(regexp)[1].to !(long);
}

string decode(int x) {
    final switch(x) {
        case 0,1,2,3: return x.to!string;
        case 4: return "a";
        case 5: return "b";
        case 6: return "c";
    }
}

void print(string fmt, string arg) {
    writeln(format(fmt,arg));
}

void print(string fmt, int arg) {
    writeln(format(fmt,arg));
}

void main ()
{
	auto a = parse(readln,"Register A: ");
	auto b = parse(readln,"Register B: ");
	auto c = parse(readln,"Register C: ");
	readln;
	auto prog = readln.strip.findSplitAfter("Program: ")[1].split(",").map!(to!(int)).array;
	int pc = 0;
	while (pc < prog.length)
	{
        std.stdio.write(pc.to!string, " ");
		auto cmd = prog[pc], arg=prog[pc+1];
		pc += 2;
		switch (cmd)
		{
            case 0: print("a = a >> %s",decode(arg)); break;
            case 1: print("b = b XOR %s",arg); break;
            case 2: print("b = %s AND 7",decode(arg)); break;
            case 3: print("IF (a!=0) GOTO %s",arg); break;
            case 4: print("b = b XOR c %s",""); break;
            case 5: print("PRINT %s AND 7",decode(arg)); break;
            case 6: print("b = a >> %s",decode(arg)); break;
            case 7: print("c = a >> %s",decode(arg)); break;
            default: assert (false); // never happens!
		}
	}
}