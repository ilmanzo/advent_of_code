class Cucumbers:
    def __init__(self,filename) -> None:
        txt=open('../input.txt').read().split('\n')
        self.width,self.height=len(txt[0]),len(txt)
        self.est,self.sud=set(),set()
        for x in range(self.width):
            for y in range(self.height):
                if txt[y][x]=='>':
                    self.est.add((x,y))
                elif txt[y][x]=='v':
                    self.sud.add((x,y))

    def simulate(self):
        steps=0
        while True:
            steps+=1
            count,est2,sud2=0,set(),set()
            for c in self.est:
                c2=((c[0]+1)%self.width,c[1])
                if c2 not in self.est and c2 not in self.sud:
                    est2.add(c2)
                    count+=1
                else:
                    est2.add(c)
            for c in self.sud:
                c2=(c[0],(c[1]+1)%self.height)
                if c2 not in est2 and c2 not in self.sud:
                    sud2.add(c2)
                    count+=1
                else:
                    sud2.add(c)
            if count==0:
                break
            else:
                self.est,self.sud=est2,sud2
        return steps

field=Cucumbers("../input.txt")
print(field.simulate())