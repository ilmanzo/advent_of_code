
SYMBOL_TABLE={'A'=> :rock,'B'=>:paper, 'C'=> :scissors, 'X'=>:rock,'Y'=>:paper,'Z'=>:scissors }
SCORE_TABLE={:rock => 1,:paper=>2, :scissors=>3}
LOSE_TABLE={:rock => :scissors, :paper=> :rock, :scissors=>:paper}
WIN_TABLE={:rock=>:paper, :paper=>:scissors, :scissors=>:rock}

def score(other,me)
    return 3+SCORE_TABLE[me] if other==me
    result=SCORE_TABLE[me]
    result+=6 if WIN_TABLE[other]==me
    result
end

def part1(p1,p2)
    score(SYMBOL_TABLE[p1],SYMBOL_TABLE[p2])
end

def part2(p1,p2)
    other=SYMBOL_TABLE[p1]
    # X = lose, Y=draw, Z=win 
    case p2
        when 'X' then score(other,LOSE_TABLE[other])
        when 'Y' then score(other,other) # play same move
        when 'Z' then score(other,WIN_TABLE[other])
    end
end

total1, total2=0,0
File.read("input.txt").split("\n").each do |line|
    p1,p2=line.split 
    total1+=part1(p1,p2)
    total2+=part2(p1,p2)
end
puts total1,total2