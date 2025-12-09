import std.stdio;
import std.file;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.math : abs;

struct Point { int x; int y; }

Point[] parseInput(string filename) {
    return File(filename).byLine.map!((line) {
            auto parts = line.split(',');
            return Point(parts[0].strip.to!int, parts[1].strip.to!int);
        })
        .array;
}

long part1(Point[] points) {
    long maxArea = 0;
    for (auto i = 0; i < points.length - 1; ++i) {
        for (auto j = i + 1; j < points.length; ++j) {
            immutable p1 = points[i];
            immutable p2 = points[j];
            immutable area = (abs(p1.x - p2.x) + 1L) * (abs(p1.y - p2.y) + 1L);
            maxArea = max(maxArea, area);
        }
    }
    return maxArea;
}

void main() {
    auto points = parseInput("input.txt");
    points.part1().writeln;
}