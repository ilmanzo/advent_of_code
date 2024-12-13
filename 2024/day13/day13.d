import std;

alias Point=Tuple!(long, "x", long, "y");

pure long solve(Point a, Point b, Point c) {
		auto a1=a.x, b1=b.x, c1=-c.x;
		auto a2=a.y, b2=b.y, c2=-c.y;
		auto x=b1*c2-c1*b2, y=c1*a2-a1*c2, z=a1*b2-b1*a2;
		if (x % z != 0 || y % z != 0) return 0;
		x /= z; y /= z;
		return (x>=0 && y>=0)?x*3+y:0;
}

void main ()
{
    immutable long P2_OFFSET = 10_000_000_000_000;
	auto input = stdin.byLineCopy.map!(n=>n.matchAll(r"\d+")
      .map!(l=>l.front.to!(long)).array).array.filter!("!a.empty").chunks(3).map!(array).array;
    import std.datetime.stopwatch;
    auto sw = StopWatch(AutoStart.yes);
	auto part1=0L,part2=0L;
	foreach (ref match; input)
	{
		auto btn_a=Point(match[0][0],match[0][1]),btn_b=Point(match[1][0],match[1][1]);
		auto target1 = Point(match[2][0],match[2][1]);
        auto target2 = Point(match[2][0]+P2_OFFSET,match[2][1]+P2_OFFSET);
        part1+=solve(btn_a,btn_b,target1);
        part2+=solve(btn_a,btn_b,target2);
	}
    writeln("Time for part1+2: ", sw.peek());
	writeln(part1," ",part2);
}
