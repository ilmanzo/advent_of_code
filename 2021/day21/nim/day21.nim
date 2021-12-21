

type Dice = object 
    value : int
    rolls : int

proc roll3(d: var Dice) : int=
    for i in countup(1,3):
        d.rolls+=1
        d.value+=1
        result+=d.value
        if d.value==101:
            d.value=1


var dice: Dice
var turn=0

var players = [6,8] 
var scores = [0,0]

while scores[0]<1000 and scores[1]<1000:
    players[turn]=players[turn]+dice.roll3
    if players[turn]>10:
        players[turn]=1+players[turn] mod 10
    scores[turn]+=players[turn]
    turn=1-turn

echo min(scores)*dice.rolls

