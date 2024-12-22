import std;

pure long next(const long value) @nogc nothrow
{
    auto result = (value ^ (value << 6)) & 0xFFFFFF;
    result = (result ^ (value >> 5)) & 0xFFFFFF;
    result = (result ^ (value << 11)) & 0xFFFFFF;
    return result;
}

pure long part1(long[] input) @nogc nothrow
{
    long part1 = 0;
	foreach (n; input) {
		for(int i=0; i<2000; i++) n=n.next;
		part1 += n;
	}
    return part1;
}

void main()
{
    auto input=stdin.byLineCopy.map!(to!(long)).array;
    input.part1.writeln;
}

