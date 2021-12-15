import heapq   

def parse_input():
    grid=[]
    for x in open("../input.txt").read().strip().split('\n'):
        grid.append([int(y) for y in x])
    return grid


# Dijkstra's algorithm
def get_lower_cost_path(grid):
    WIDTH=len(grid)
    HEIGHT=len(grid[0])
    queue = [(0, 0, 0)]
    costs = {}
    while True:
        cost,x,y = heapq.heappop(queue)
        if x==WIDTH-1 and y==HEIGHT-1: 
            print(cost)
            break
        for xx,yy in [(x+1,y),(x-1,y),(x,y-1),(x,y+1)]:
            if xx in range(WIDTH) and yy in range(HEIGHT):
                new_cost = cost + grid[xx][yy]
                if (xx,yy) in costs and costs[(xx,yy)]<=new_cost:
                    continue
                costs[(xx,yy)]=new_cost
                heapq.heappush(queue,(new_cost,xx,yy))

def part1(grid):
    get_lower_cost_path(grid)

def part2(grid):
    WIDTH=len(grid)
    HEIGHT=len(grid[0])
    #create bigger grid by copying old one and increase numbers
    expanded = [[0 for x in range(HEIGHT*5)] for y in range(WIDTH*5)]
    for x in range(WIDTH*5):
        for y in range(HEIGHT*5):
            dist = x//WIDTH + y//HEIGHT
            newval = grid[x%WIDTH][y%HEIGHT]
            for i in range(dist):
                newval+=1
                if newval==10:
                    newval=1
            expanded[x][y] = newval
    get_lower_cost_path(expanded)
    

grid=parse_input()
part1(grid)
part2(grid) 

# part2 was a bit slow, I optimized with a priority queue 