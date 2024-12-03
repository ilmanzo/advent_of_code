FILENAME="input.txt"
#FILENAME="sample1.txt"
#FILENAME="sample2.txt"

def part1(data)
    data.scan(/mul\((\d+),(\d+)\)/).map do |match| 
        a,b=match.captures[0],match.captures[1]
        next if a.nil? || b.nil?
        a.to_i * b.to_i    
    end.compact.sum
end

def part2(data)
    part1 data.gsub("don't\(\).*?do\(\)", "")
end

data=File.read(FILENAME)
p part1(data)
p part2(data)