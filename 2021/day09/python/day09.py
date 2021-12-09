#day09 https://adventofcode.com/2021/day/9
import math

def near_cells(input,x,y):
    result = []
    if x+1 < len(input[0]):
        result.append(input[y][x+1])
    if x-1 >= 0:
        result.append(input[y][x-1])
    if y+1 < len(input):
        result.append(input[y+1][x])
    if y-1 >= 0:
        result.append(input[y-1][x])
    return result

def part1(input):
    result = 0
    for y in range(0, len(input)):
        for x in range(0, len(input[0])):
            if input[y][x] < min(near_cells(input,x,y)):
                result += (input[y][x]+1)
    return result


def count_basins(input, basins, x,y, first_pass=False):
    if y < 0 or y >= len(input):
        return
    if x < 0 or x >= len(input[0]):
        return
    if input[y][x] == 9 or input[y][x] == -1:
        return
    if first_pass:
        basins.append(0)
    else:
        basins[len(basins)-1] += 1
        input[y][x] = -1
    count_basins(input,basins,x-1,y)
    count_basins(input,basins,x+1,y)
    count_basins(input,basins,x,y-1)
    count_basins(input,basins,x,y+1)


def part2(input):
    basins = []
    for i in range(0, len(input)):
        for j in range(0, len(input[0])):
            count_basins(input,basins,j,i, True)
    basins.sort()
    return(math.prod(basins[-3:])) # after sorting, last 3 are the bigger

if __name__=="__main__":
    with open('../input.txt', 'r') as f:
        data = f.read().split('\n')
    input = [[ int(c) for c in line ] for line in data]
    print(part1(input))
    print(part2(input))
