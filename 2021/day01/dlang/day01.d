import std.algorithm, std.stdio, std.string, std.conv, std.range;

pure int increases(const int[] arr) {
    auto prev=int.max;
    auto increases=0;
    foreach(n;arr) {
        if (n>prev) increases++;
        prev=n;
    }
    return increases;
}

pure int part1(const int[] numbers) {
    return numbers.increases;
}

pure int part2(const int[] numbers) {
    int[] sums;
    for (int i=2;i<numbers.length;i++) {
        sums~=numbers[i-2]+numbers[i-1]+numbers[i];
    }
    return sums.increases;

}

void main()
{
    auto numbers=File("../input.txt")
        .byLine()
        .map!(to!int).array;
    writeln(part1(numbers));
    writeln(part2(numbers));
}