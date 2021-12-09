
def part1(lines)
    lines.sum do |(input,outputs)|
        outputs.count(&.size.in?(2,4,3,7))
    end 
end


data=File.read_lines("../input.txt").map(&.split(" | ").map(&.split))
puts part1 data
