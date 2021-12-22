
from cuboid import Cuboid


def parse_input():
    result=[]
    with open('../input.txt') as f:
        for line in f.read().splitlines():
            on_off, coords = line.split()
            xrange,yrange,zrange=coords.split(',')
            startx,endx=map(int,xrange[2:].split('..'))
            starty,endy=map(int,yrange[2:].split('..'))
            startz,endz=map(int,zrange[2:].split('..'))
            item=(on_off=='on',[startx,endx,starty,endy,startz,endz])
            result.append(item)
    return result

def part1(commands):
    on = set()
    for is_on, bounds in commands:
        x1, x2, y1, y2, z1, z2 = bounds
        for x in range(max(-50, x1), min(51, x2 + 1)):
            for y in range(max(-50, y1), min(51, y2 + 1)):
                for z in range(max(-50, z1), min(51, z2 + 1)):
                    if is_on:
                        on.add((x, y, z))
                    else:
                        on.discard((x, y, z))
    return len(on)

def part2(commands):
    cuboids = []
    for is_on, bounds in commands:
        for cuboid in cuboids:
            cuboid.remove(bounds)
        if is_on:
            cuboids.append(Cuboid(bounds))
    return sum(cuboid.count_cubes() for cuboid in cuboids)

commands=parse_input()


print(part1(commands))
print(part2(commands))