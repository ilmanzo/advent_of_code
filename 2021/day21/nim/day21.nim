var turn=0
var players = [6,8] 
var scores = [0,0]
var rolls=0
var dice=0

while true:
    rolls+=3
    var n = -1
    for i in countup(1,3):
        dice+=1
        if dice==101:
            dice=1
        n+=dice
    players[turn]=1+(players[turn]+n) mod 10
    scores[turn]+=players[turn]
    if scores[turn]>=1000:
        break
    turn=1-turn

echo min(scores)*rolls
