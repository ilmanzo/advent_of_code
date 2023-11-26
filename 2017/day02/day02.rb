def getdiff(line)
    numbers=line.split.map(&:to_i)
    numbers.max - numbers.min
end

def get_evenly_divisible(line)
    numbers=line.split.map(&:to_i)
    numbers.each do |i| 
        numbers.each do |j|
            return i/j if (i!=j && i%j==0)
        end
    end
end

input=File.read("input.txt")
#input=File.read("sample.txt")

part1=input.each_line.map { |line| getdiff(line)}.sum
p "part1=#{part1}"

part2=input.each_line.map { |line| get_evenly_divisible(line)}.sum
p "part2=#{part2}"



