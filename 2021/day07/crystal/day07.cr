
def sum_to(n)
    n*(n+1)/2
end

def part1(input)
    (input.min..input.max).map do |i| 
        input.map { |n| (n-i).abs }.sum 
    end.min
end

def part2(input)
    (input.min..input.max).map do |i| 
        input.map { |n| sum_to((n-i).abs) }.sum 
    end.min
end

input=File.read("../input.txt").split(',').map(&.to_i64)
puts part1 input
puts part2 input

