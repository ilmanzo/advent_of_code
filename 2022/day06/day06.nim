import std/sets

func isunique(s: string): bool =
    s.toHashSet.len == s.len

proc findStartOfPacket(input: string, n: int): int =
    let start = n-1
    for i in start..input.len:
        if isunique(input[i-start..i]):
            return i+1

let input = readFile("input.txt")
echo "Part1=", findStartOfPacket(input, 4)
echo "Part2=", findStartOfPacket(input, 14)
