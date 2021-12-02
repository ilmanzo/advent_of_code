# Advent of Code 2021
# day1 solution in Crystal  https://crystal-lang.org/

def increases(items)
    increases=0
    last_value=UInt32::MAX
    items.each do |i|
        increases+=1 if i>last_value
        last_value=i
    end
    increases
end

def get_sliding_sums(items)
    (2..items.size-1).map{|i| items[i-2..i].sum} 
end

input=File.read_lines("../input.txt").map(&.to_u32)
puts "part1: #{increases input}"
puts "part2: #{increases get_sliding_sums input}"
