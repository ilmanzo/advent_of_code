import std/strutils

type SubmarineP1 = ref object of RootObj
    depth, position: int

type SubmarineP2 = ref object of SubmarineP1
    aim: int

method forward(s: var SubmarineP1, x: int) {.base.} =
    s.position+=x

method up(s: var SubmarineP1, x: int) {.base.} =
    s.depth-=x

method down(s: var SubmarineP1, x: int) {.base.} =
    s.depth+=x

method forward(s: var SubmarineP2, x: int) =
    s.position+=x
    s.depth+=s.aim*x

method up(s: var SubmarineP2, x: int) =
    s.aim-=x

method down(s: var SubmarineP2, x: int) =
    s.aim+=x


var parts = @[SubmarineP1(), SubmarineP2()]


for line in lines "../input.txt":
    let tokens = line.split
    let direction = tokens[0]
    let amount = tokens[1].parseInt
    for p in parts.mitems:
        case direction:
            of "forward":
                p.forward amount
            of "down":
                p.down amount
            of "up":
                p.up amount

echo "Part1 = ", parts[0].position*parts[0].depth
echo "Part2 = ", parts[1].position*parts[1].depth
