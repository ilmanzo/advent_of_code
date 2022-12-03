def prio(c)
    return c.ord-'a'.ord+1 if c==c.downcase 
    c.ord-'A'.ord+27
end

def part1(lines)
    lines.map do |line|
        l=line.length
        a=line[0..l/2-1].chars
        b=line[l/2..-1].chars
        prio (a&b).pop
    end.sum
end

def part2(lines)
    lines.each_slice(3).map do |group| 
        c=group[0].chars & group[1].chars & group[2].chars 
        prio c.pop
    end.sum
end



input = File.read("input.txt").split("\n")
p part1 input 
p part2 input






