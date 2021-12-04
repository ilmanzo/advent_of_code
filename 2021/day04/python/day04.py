import pprint


def parse_input():
    boards=[]
    with open("../input.txt") as f:
        extractions=[int(x) for x in f.readline().strip().split(',')]
        f.readline()
        while True:
            boards.append([[int(x) for x in f.readline().split()] for i in range(5)])
            if not f.readline():
                break
        return boards,extractions

def winner(b,extracted):
    # board wins when any row or colum contains all extracted numbers
    if any(all(n in extracted for n in row) for row in b):
        return True
    if any(all(n in extracted for n in col) for col in zip(*b)):
        return True


def score(b,extracted):
    # calc sum of board multiplied by last extraction
    newboard=b[:] # put as 0 when a number was extracted
    for x in range(5):
        for y in range(5):
            if newboard[x][y] in extracted:
                newboard[x][y]=0
    return sum(sum(newboard[x]) for x in range(5))


boards,extractions=parse_input()
extracted=set()
winners=set()
for n in extractions:
    extracted.add(n)
    for (i, b) in enumerate(boards):
        if i in winners:
            continue
        if winner(b,extracted):
            winners.add(i)
            if len(winners) == 1 or len(winners) == len(boards):
                print(score(b,extracted)*n)
