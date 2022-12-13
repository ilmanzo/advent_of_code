MAX_DIST = 99999999  # our concept of 'infinite'

def add(a, b):
    return a[0] + b[0], a[1] + b[1]


def is_reachable(a: str, b: str) -> bool:
    a = a.replace('S', 'a').replace('E', 'z')
    b = b.replace('S', 'a').replace('E', 'z')
    diff = ord(b) - ord(a)
    return diff <= 1


def add_nodes(pos, grid, distances):
    result = []
    candidates = [add(pos, o) for o in [(0, 1), (0, -1), (1, 0), (-1, 0)]]
    for c in candidates:
        # fall outside grid
        if c[0] < 0 or c[1] < 0 or c[0] >= len(grid) or c[1] >= len(grid[0]):
            continue
        # Target has already same or lower distance
        if distances[c[0]][c[1]] <= distances[pos[0]][pos[1]] - 1:
            continue
        # Target not reachable
        if not is_reachable(grid[pos[0]][pos[1]], grid[c[0]][c[1]]):
            continue
        result.append(c)
    return result


def init_distances(w, h):
    return [[MAX_DIST for x in range(w)] for y in range(h)]


def search_letter(s: str, data):
    pos = (0, 0)
    for y in range(len(data)):
        if s in data[y]:
            x = data[y].index(s)
            pos = (y, x)
    return pos


def search_all_letters(s: str, data):
    positions = []
    for y in range(len(data)):
        if s in data[y]:
            x = data[y].index(s)
            positions.append((y, x))
    return positions


def part1(data, w, h):
    # Search start
    start = search_letter('S', data)
    end = search_letter('E', data)
    distances = init_distances(w, h)
    queue = [(start, 0)]
    while len(queue) > 0:
        pos, distance = queue.pop(0)
        # Check if entry is a viable
        if distance >= distances[pos[0]][pos[1]]:
            continue
        distances[pos[0]][pos[1]] = distance
        # print('Initial distance:', distances[pos[0]][pos[1]])
        queue.extend([((n[0], n[1]), distance + 1)
                     for n in add_nodes(pos, data, distances)])
    return distances[end[0]][end[1]]


def part2(data, w, h):
    # Search start
    end = search_letter('E', data)
    starts = search_all_letters('a', data)
    shortest_path_candidates = []

    for start in starts:
        distances = init_distances(w, h)
        queue = [(start, 0)]
        while len(queue) > 0:
            pos, distance = queue.pop(0)
            # Check if entry is a viable
            if distance >= distances[pos[0]][pos[1]]:
                continue
            distances[pos[0]][pos[1]] = distance
            queue.extend([((n[0], n[1]), distance + 1)
                         for n in add_nodes(pos, data, distances)])
            shortest_path_candidates.append(distances[end[0]][end[1]])
    return min(shortest_path_candidates)


with open('input.txt') as f:
    data = [x.strip() for x in f.readlines()]

w = len(data[0])
h = len(data)

print('Part1:', part1(data, w, h))
print('Part2:', part2(data, w, h))
