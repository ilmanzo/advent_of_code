import sys
from collections import defaultdict

def hour(event):
	return int(event[1][:event[1].find(':')])

def minute(event):
	return int(event[1][event[1].find(':')+1:-1])

def sum_intervals(intervals):
	return sum(b-a for a, b in intervals)

def times_slept(guard_id, minute):
	return sum(a <= minute < b for a, b in guards[guard_id])

guards = defaultdict(list)
events=sys.stdin.readlines()
events.sort()
for e in events:
	e=e.split()
	if 'begins' in e:
		gid = int(e[3][1:])
		lastw = minute(e) if hour(e) == 0 else 0
	elif 'wakes' in e:
		lastw = minute(e)
		guards[gid].append((lasts, lastw))
	elif 'falls' in e:
		lasts = minute(e)

worst_guard = max(guards, key=lambda g: sum_intervals(guards[g]))
worst_guard_min = max(range(60), key=lambda m: times_slept(worst_guard, m))
ans = worst_guard * worst_guard_min

print('Part 1:', ans)

worst_guard = max(guards, key=lambda g: max(times_slept(g, m) for m in range(60)))
worst_guard_min = max(range(60), key=lambda m: times_slept(worst_guard, m))
ans2 = worst_guard * worst_guard_min

print('Part 2:', ans2)