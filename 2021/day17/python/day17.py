class Target:
    # a bullet coords hit the target
    def hit(self,x,y):
        return x in range(self.x0,self.x1+1) and y in range(self.y0,self.y1+1)
    # a bullet goes over the target
    def miss(self,x,y):
        return x>self.x1 or y<self.y0
    def __init__(self,filename):
        with open(filename, "r") as input:
            line = input.read()[15:]
            line = line.split(", y=")
            xrange = line[0].split("..")
            yrange = line[1].split("..")
            (self.x0,self.x1)=map(int,xrange)
            (self.y0,self.y1)=map(int,yrange)

    
target=Target("../input.txt")


#Part1
max_vert_velocity = target.y0
max_height = (max_vert_velocity)*(max_vert_velocity+1)/2

print(int(max_height))

#Part2
possible_velocities =0
for x in range(200):
    for y in range(400):
        xvel = x + 6
        yvel = 250 - y
        xpos,ypos = 0,0
        y1 = yvel
        for t in range(400):
            xpos += xvel
            ypos += yvel
            if xvel > 0:
                xvel -= 1
            yvel -= 1
            if target.hit(xpos,ypos):
                possible_velocities+=1
                break
            if target.miss(xpos,ypos):
                break

print(possible_velocities)

