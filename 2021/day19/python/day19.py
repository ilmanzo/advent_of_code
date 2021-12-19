class Scanner:
    def __init__(self,beacons):
        self.beacons=beacons


def parse(s):
	out = []
	for line in s.split("\n")[1:]:
		a, b, c = line.split(",")
		out.append((int(a), int(b), int(c)))
	return out

def parse_input():
    file_lines=open("../input.txt").read()
    return list(map(parse, file_lines.split("\n\n")))

def squared_distance(a,b):
    dx,dy,dz=(a[0]-b[0]),(a[1]-b[1]),(a[2]-b[2])
    return (dx*dx+dy*dy+dz*dz)

data=parse_input()
ref=data[0]
#print(ref)
#assume first sensor is correct, calculate all "signature" distance of the other beacons
#compare other beacons' data to match the one at the same distance
for sensor_index,sensor in enumerate(data):
    if sensor_index==0:
        continue
    for beacon_index,beacon in enumerate(sensor):
        distance=squared_distance(ref[beacon_index],beacon)
        print(distance)        
    