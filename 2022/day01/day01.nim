import strutils, algorithm, math

var calories: seq[int]
var sum: int
for line in "input.txt".lines:
    if line.len == 0:
        calories.add(sum)
        sum = 0
    else:
        sum+=line.parseInt

calories = calories.sorted
echo calories[^1]
echo calories[^3..^1].sum

