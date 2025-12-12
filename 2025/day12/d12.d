import std;

void main() {
    stdin.byLine
         .drop(30)
         .count!(l => 7 * l[6..$].split.map!(to!int).sum < l[0..2].to!int * l[3..5].to!int)
         .writeln;
}
