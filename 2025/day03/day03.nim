import std/strutils
import std/sequtils
import std/math
import std/tables
import std/monotimes
import std/times

template benchmark(code: untyped) =
  block:
    let t0 = getMonoTime()
    code
    let elapsed = getMonoTime() - t0
    echo "Time ", elapsed.inMilliseconds(), " ms"

proc part1(data: seq[int]): int =
  for i in 0 ..< data.len - 1:
    let currentVal = 10 * data[i] + data[i + 1 .. ^1].max
    result = max(result, currentVal)

proc part2(digits: seq[int]): int =
  let n = digits.len
  var cache = initTable[tuple[index: int, k: int], int]()

  proc dp(index, k: int): int =
    if cache.hasKey((index, k)):
      return cache[(index, k)]
    if k == 0:
      result = 0
    elif n - index < k: 
      result = low(int) 
    elif n - index == k:
      result = digits[index] * int(pow(10.0, float(k - 1))) + dp(index + 1, k - 1)
    else:
      let pick = digits[index] * int(pow(10.0, float(k - 1))) + dp(index + 1, k - 1)
      let skip = dp(index + 1, k)
      result = max(pick, skip)
    cache[(index, k)] = result

  return dp(0, 12)

var input: seq[seq[int]]
for line in stdin.lines:
  input.add line.map(proc(c: char): int = parseInt($c))

benchmark:
  echo "Part 1: ", input.map(part1).sum
benchmark:
  echo "Part 2: ", input.map(part2).sum
