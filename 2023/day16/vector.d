import std.math;

struct Vector
{
    long x;
    long y;

    Vector opBinary(string op : "+")(Vector o) => Vector(x + o.x, y + o.y);
    Vector opBinary(string op : "-")(Vector o) => Vector(x - o.x, y - o.y);
    Vector opBinary(string op : "*")(long o) => Vector(x * o, y * o);
    Vector opUnary(string op : "-")() => Vector(-x, -y);
    Vector left() => Vector(y, -x);
    Vector right() => Vector(-y, x);
    long length() => abs(x) + abs(y);
}

enum Dir : Vector
{
    up = Vector(0, -1),
    down = Vector(0, 1),
    left = Vector(-1, 0),
    right = Vector(1, 0)
}
