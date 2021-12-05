import std/tables
import std/sequtils
import std/strutils
import std/strscans

type Map=CountTable[(int,int)]


proc draw_v(m: var Map,x:int,y1:int,y2:int)=
    for y in y1..y2:
        m.inc (x,y)

proc draw_h(m: var Map,x1:int,x2:int,y:int)=
    for x in x1..x2:
        m.inc (x,y)

proc draw(m: var Map,x1:int,y1:int,x2:int,y2:int)=
    if x1==x2: # vert line
        draw_v(m,x1,min(y1,y2),max(y1,y2))
    if y1==y2: # horiz line
        draw_h(m,min(x1,x2),max(x1,x2),y1)
        

var
    map=initCountTable[(int,int)]()

for input in "../input.txt".readFile.splitLines:
    let (ok, x1, y1, x2, y2) = scanTuple(input, "$i,$i -> $i,$i")
    if not ok:
        echo "error in parsing"
        break
    map.draw(x1,y1,x2,y2)
let overlaps=map.keys.countIt(map[it]>1)
echo overlaps
    
    
