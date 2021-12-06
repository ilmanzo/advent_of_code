
#keeps track of how many fishes there are for any age
def simulate(fishes,part):
    if part==1:
        loops=80
    elif part==2:
        loops=256
    ages = [0]*9
    for i in fishes:
        ages[i] += 1
    for day in range(0, loops):
        cycle = ages[0]
        for age in range(0, 9):
            ages[age-1] = ages[age]
        ages[6] += cycle
        ages[8] = cycle
    print(sum(ages))



with open('../input.txt') as f:
    fishes = [int(x) for x in f.read().split(',')]

simulate(fishes,1)
simulate(fishes,2)
