import std;
import std.datetime.stopwatch;

//immutable W=11,H=7; //test
immutable auto W=101,H=103;
immutable auto cX=W/2,cY=H/2; // center

struct Robot { 
    int x; 
    int y; 
    int vx; 
    int vy; 

    void move(int t) {
		this.x=(((this.x+this.vx*t)%W)+W)%W;
		this.y=(((this.y+this.vy*t)%H)+H)%H;
    }
}

void main ()
{
    auto robots=parseinput();
    auto sw = StopWatch(AutoStart.yes);
    robots.part1.writeln;
    writeln("Time for part1: ",sw.peek);
    sw.reset;
    robots.part2.writeln;
    writeln("Time for part2: ",sw.peek);
    robots.dump;
}

auto parseinput() {
	auto input = stdin.byLineCopy.map!(l=>l.matchAll(r"\-?\d+").array).array;
	Robot[] robots;
	foreach (ref line; input)
	{
		auto match=line.map!(x=>x.front.to!(int)).array;
		robots~= Robot(match[0], match[1], match[2], match[3]);
	}
    return robots;
}

auto part1(Robot[] robots) {
	auto quadrants=new int[][](2,2);
    robots.each!((ref r)=>r.move(100));
	foreach (ref r; robots) if (r.x!=cX && r.y!=cY) quadrants[r.x/(cX+1)][r.y/(cY+1)]+=1;
	return quadrants.map!(v=>v.fold!("a*b")(1L)).fold!("a*b")(1L);
}

auto part2(Robot[] robots) {
    alias Point=Tuple!(int,int);
    // start from 101 because we already did 100 steps in part1.
    // limit iterations to 1M to stop after a reasonable time
    for(auto t=101;t<1_000_000;t++) {
        robots.each!((ref r)=>r.move(1));
        bool[Point] count;
        robots.each!(r=>count[Point(r.x,r.y)]=true);
        if (count.length==robots.length) return t;
    }
    return 0;
}

void dump(Robot[] robots) {
    auto board = new char [][](W, H);
	foreach (ref line; board) line[] = '.';
	foreach (ref r; robots) board[r.x][r.y] = '#';
	writefln !("%-(%s\n%)") (board);
}