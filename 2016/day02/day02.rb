
#start on center
posx=1
posy=1

input=File.readlines("input.txt")

p "part1:"

keypad=[[1,2,3],[4,5,6],[7,8,9]]
input.each do |line|
    line.chars.each do |ch|
        case ch
            when "U" then 
                posy-=1 if posy>0
            when "R" then 
                posx+=1 if posx<2
            when "L" then 
                posx-=1 if posx>0
            when "D" then 
                posy+=1 if posy<2
        end 
    end
    p keypad[posy][posx]
end


keypad=[
    [0,0,1,0,0],
    [0,2,3,4,0],
    [5,6,7,8,9],
    [0,'A','B','C',0],
    [0,0,'D',0,0,],
    ]

p "part2:"    
posx=0
posy=2
input.each do |line|
    line.chars.each do |ch|
        newx=posx
        newy=posy
        case ch
            when "U" then 
                newy=posy-1 
            when "R" then 
                newx=posx+1
            when "L" then 
                newx=posx-1
            when "D" then 
                newy=posy+1
        end
        if (newx>=0 and newx<=4 and newy>=0 and newy<=4)  
            posx=newx if keypad[newy][newx]!=0
            posy=newy if keypad[newy][newx]!=0
        end
          
    end
    p keypad[posy][posx]
end


