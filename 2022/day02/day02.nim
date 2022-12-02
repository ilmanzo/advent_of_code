import strutils, sequtils
# 0 = rock, 1=paper, 2=scissors
const
    A = ord('A')
    X = ord('X')

# returns the move I need to do in order to win m
proc win(m: int): int = (m+1) mod 3

# returns the move I need to do in order to lose m
proc lose(m: int): int =
    result = 2
    if m > 0: result = m-1

proc score(other, me: int): int =
    result = me+1 # base value is my move
    if other == me:
        result+=3 # draw match
    elif win(other) == me:
        result+=6 # won match

proc part1(pl: seq[char]): int =
    score(int(pl[0])-A, int(pl[1])-X)

# X = lose, Y=draw, Z=win
proc part2(pl: seq[char]): int =
    let other = int(pl[0])-A
    case pl[1]:
        of 'X': return score(other, other.lose)
        of 'Y': return score(other, other)
        of 'Z': return score(other, other.win)
        else: discard

var total1, total2: int
for line in "input.txt".lines:
    let players = line.split.mapIt(char(it[0]))
    total1+=players.part1
    total2+=players.part2

echo "part1=", total1
echo "part2=", total2
