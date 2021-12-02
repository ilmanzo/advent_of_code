import std/strutils
import std/sequtils

proc count_increases(items : seq[int]) : int = 
  for i in 1 .. items.high:
    if items[i] > items[i - 1]:
      inc result

proc get_sums(items: seq[int]) : seq[int] =
    for i in countup(2,items.len-1):
        result.add(items[i-2]+items[i-1]+items[i])

let input: seq[int] = "../input.txt".lines.toSeq.map(parseInt)
echo "Part1: ",input.count_increases()
echo "Part2: ",input.get_sums().count_increases()

