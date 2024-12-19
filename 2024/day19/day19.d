import std;
import std.datetime.stopwatch;

string [] patterns;

void main ()
{
	patterns=readln.strip.split(", ");
	readln;
	auto towels=stdin.byLineCopy.array;
    auto sw = StopWatch(AutoStart.yes);
	towels.count!(t=> t.can_make).writeln;
    writeln("Time for part1: ",sw.peek);
	sw.reset();
	towels.map!(t => t.howMany).sum.writeln;
	writeln("Time for part2: ",sw.peek);
}

alias can_make=memoize!(can_makeImpl);
bool can_makeImpl(const string s) {
	if (s.empty) return true;
	foreach (ref p; patterns) if (s.startsWith(p) && can_make(s[p.length..$])) return true;
	return false;
}

alias howMany=memoize!(howManyImpl);
long howManyImpl(const string s) {
	if (s.empty) return 1;
	long total = 0;
	patterns.each!(p => total+=s.startsWith(p)?howMany(s[p.length..$]):0);
	return total;
}

