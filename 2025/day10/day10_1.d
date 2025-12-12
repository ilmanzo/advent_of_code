import std.stdio;
import std.file;
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.range;
import std.typecons : Tuple, tuple;
import core.bitop : popcnt;

auto parseInput(char[] line)
{
    auto parts = line.strip.split(" ");

    auto endStrView = parts[0].strip("()");
    assert(endStrView.length <= 32, "Input exceeds 32 bits, use ulong or BitArray");

    uint finalState = endStrView
        .enumerate
        .filter!(a => a.value == '#')
        .map!(a => 1u << a.index)
        .fold!((a, b) => a | b)(0u);

    auto buttonMasks = parts[1 .. $-1]
        .map!(rawBtn => rawBtn.strip("()")
                              .splitter(',')
                              .map!(s => s.to!int)
                              .map!(idx => 1u << idx)
                              .fold!((a, b) => a | b)(0u))
        .array;

    return tuple!("finalState", "buttonMasks")(finalState, buttonMasks);
}

int part1(uint finalState, const uint[] buttonMasks)
{
    auto numButtons = buttonMasks.length;
    int minPresses = int.max;

    // Iterate through every possible combination of button presses (2^numButtons).
    // 'i' is a bitmap where each bit represents a button.
    foreach (i; 0u .. (1u << numButtons))
    {
        // Calculate the resulting state by XORing the masks of pressed buttons.
        uint resultState = iota(numButtons)
            .filter!(j => (i >> j) & 1)
            .map!(j => buttonMasks[j])
            .fold!((a, b) => a ^ b)(0u);

        if (resultState == finalState)
        {
            // If we found a solution, see if it's better than the best one so far.
            minPresses = min(minPresses, popcnt(i));
        }
    }

    return minPresses;
}

void main()
{
    auto p1 = File("sample.txt")
        .byLine
        .filter!(line => !line.strip.empty)
        .map!(line => parseInput(line))
        .map!(input => part1(input.finalState, input.buttonMasks))
        .sum;
    p1.writeln;
}