steps = 12459852

a, b, c, d, e, f = range(6)
left, right = 0, 1

tm = {
    (a, 0): (1, right, b),
    (a, 1): (1, left, e),

    (b, 0): (1, right, c),
    (b, 1): (1, right, f),

    (c, 0): (1, left, d),
    (c, 1): (0, right, b),

    (d, 0): (1, right, e),
    (d, 1): (0, left, c),

    (e, 0): (1, left, a),
    (e, 1): (0, right, d),

    (f, 0): (1, right, a),
    (f, 1): (1, right, c),
}

tape = {}
head, state = 0, a

for i in range(steps):
    val = tape.get(head, 0)
    wval, move, nextstate = tm.get((state, val))
    tape[head] = wval
    if move == right:
        head += 1
    else:
        head -= 1
    state = nextstate

print(sum(tape.values()))
