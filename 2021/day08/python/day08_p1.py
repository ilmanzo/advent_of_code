import pprint

def part1(data):
    count=0
    for line in data:
        values = line.split('|')[-1].split()
        count+=len([n for n in values if len(n) in (2,4,3,7)])
    return count

with open('../input.txt', 'r') as f:
    data = f.read().splitlines()
print(part1(data))