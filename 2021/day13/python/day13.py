
def parse_data():
    input = open('../input.txt').read().split('\n\n')
    points = [tuple(map(int, point.split(','))) for point in input[0].splitlines()]
    folds = [(axis[-1], int(val)) for fold in input[1].splitlines() for axis, val in [fold.split('=')]]
    return points, folds

def fold(points,axis,pos):
    for i, (x,y) in enumerate(points):
        if axis=='x' and x>pos:
            points[i] = (2*pos-x,y)
            continue
        if axis=='y' and y>pos:
            points[i] = (x,2*pos-y)



def draw(points): 
    for y in range(10):
        for x in range(50):
            if (x,y) in points:
                print("#",end='')
            else:
                print(" ",end='')
        print()

points,folds=parse_data()
first=True
for axis, pos in folds:
    fold(points,axis,pos)
    # count unique points after first fold
    if first:
        print(len(set(points))) 
        first=False    
draw(points)
