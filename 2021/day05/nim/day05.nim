import std/tables
import std/sequtils
import std/strutils
import std/strscans
import std/math

type Map=CountTable[(int,int)]

proc draw_v(m: var Map,x:int,y1:int,y2:int)=
    for y in y1..y2:
        m.inc (x,y)

proc draw_h(m: var Map,x1:int,x2:int,y:int)=
    for x in x1..x2:
        m.inc (x,y)

proc draw(m: var Map,part:int,x1:int,y1:int,x2:int,y2:int)=
    if x1==x2: # vert line
        draw_v(m,x1,min(y1,y2),max(y1,y2))
    if y1==y2: # horiz line
        draw_h(m,min(x1,x2),max(x1,x2),y1)
    if part==1:
        return
    let xd=sgn(x2-x1)
    let yd=sgn(y2-y1)
    var (x,y)=(x1,y1)
    while x!=x2:
        m.inc (x1,y1)
        x+=xd
        y+=yd
            
var
    map1=initCountTable[(int,int)]()
    map2=initCountTable[(int,int)]()

for input in "../input.txt".readFile.splitLines:
    let (ok, x1, y1, x2, y2) = scanTuple(input, "$i,$i -> $i,$i")
    if not ok:
        echo "error in parsing"
        break
    map1.draw(1,x1,y1,x2,y2)
    map2.draw(2,x1,y1,x2,y2)
echo "Part1 overlaps:",map1.keys.countIt(map1[it]>1)
echo "Part2 overlaps:",map2.keys.countIt(map2[it]>1)

    
