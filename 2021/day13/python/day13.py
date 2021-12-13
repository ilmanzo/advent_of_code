
def parse_data():
    input = open('../input.txt').read().split('\n\n')
    points = [tuple(map(int, point.split(','))) for point in input[0].splitlines()]
    folds = [(axis[-1], int(val)) for fold in input[1].splitlines() for axis, val in [fold.split('=')]]
    return points, folds

def fold(points,folds):
    first=True
    for ax, v in folds:
        for i, (x, y) in enumerate(points):
            if ax == 'x' and x > v:
                points[i] = (2 * v - x, y)
            elif ax == 'y' and y > v:
                points[i] = (x, 2 * v - y)
        if first:
            print(len(set(points))) # count unique points after first fold
            first=False    

def draw(points): 
    for y in range(10):
        for x in range(50):
            if (x,y) in points:
                print("#",end='')
            else:
                print(" ",end='')
        print()

points,folds=parse_data()
fold(points,folds)
draw(points)
