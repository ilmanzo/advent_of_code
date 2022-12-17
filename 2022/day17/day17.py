import sys
from typing import Dict

HLINE = ((0, 0), (1, 0), (2, 0), (3, 0))
PLUS = ((1, 0), (0, 1), (1, 1), (2, 1), (1, 2))
LSHAPE = ((0, 0), (1, 0), (2, 0), (2, 1), (2, 2))
VLINE = ((0, 0), (0, 1), (0, 2), (0, 3))
SQUARE = ((0, 0), (1, 0), (0, 1), (1, 1))

pieces = (HLINE, PLUS, LSHAPE, VLINE, SQUARE)

input_moves = sys.stdin.read().strip()
step = 0

chamber = {(i, 0) for i in range(7)}
# we keep a map of move nr, piece -> piece nr, height
# in order to recognize if we already saw the same piece at the same move step
cache: Dict[tuple, tuple] = {}
cached_step, cached_shape = None, None
for npiece in range(1000000000000):
    height = max(y for x, y in chamber)
    if npiece == 2022:
        print("Part1:", height)
    curx = 2
    cury = height + 4
    curshape = npiece % len(pieces)
    if (step, curshape) in cache:
        cached_shape = npiece - cache[(step, curshape)][0]
        cached_step = height - cache[(step, curshape)][1]
    cache[(step, curshape)] = (npiece, height)
    if cached_step and cached_shape and (1000000000000 - npiece) % cached_shape == 0:
        height += (1000000000000 - npiece) // cached_shape * cached_step
        print("Part2:", height)
        break
    while True:
        dx = 1 if input_moves[step] == ">" else -1
        step = (step + 1) % len(input_moves)
        if all((curx + i + dx, cury + j) not in chamber and 0 <= curx + i + dx < 7
               for i, j in pieces[curshape]):
            curx += dx
        if any((curx + i, cury + j - 1) in chamber for i, j in pieces[curshape]):
            break
        cury -= 1
    chamber.update((curx + i, cury + j) for i, j in pieces[curshape])
    # if npiece % 100 == 0:
    #    print(v)
