# nimble install unpack
import unpack, strutils, intsets, strformat

type
    Instr = tuple[op: string, arg: int]

var
    insts = newSeq[Instr](0)

for line in "input.txt".lines:
    [op, arg] <- split(line)
    insts.add((op, parseInt(arg)))

proc hack(instr: Instr, i: int, n: int): Instr =
    if i != n:
        return instr
    elif instr.op == "nop":
        return ("jmp", instr.arg)
    elif instr.op == "jmp":
        return ("nop", instr.arg)
    else:
        return instr

proc run(n: int): (bool, int) =
    var
        accum = 0
        i = 0
        ran = initIntSet()

    while true:
        if i == len(insts):
            return (true, accum)
        elif ran.contains(i):
            return (false, accum)
        ran.incl(i)

        var inst = insts[i]
        inst = hack(inst, i, n)

        if inst.op == "nop":
            i += 1
        elif inst.op == "jmp":
            i += inst.arg
        elif inst.op == "acc":
            accum += inst.arg
            i += 1
        else:
            raise newException(Exception, "Unknown op")

var (ok, accum) = run(-1)
echo fmt"Part1: {ok=} {accum=}"

for i in 0 .. len(insts):
    var (ok, accum) = run(i)
    if ok:
        echo fmt"Part2: {i=} {ok=} {accum=}"