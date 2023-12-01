def first_last(line)
    nrs=line.chars.select { |c| c=~/\d/} 
    (nrs.first+nrs.last).to_i
end

input = File.read("input.txt").lines

part1=input.map{|l| first_last l}.sum
p "Part1=#{part1}"

part2=input.map do |l| 
    l.gsub! "zero", "0"
    l.gsub! "one","1"
    l.gsub! "two", "2"
    l.gsub! "three", "3"
    l.gsub! "four", "4"
    l.gsub! "five", "5"
    l.gsub! "six", "6"
    l.gsub! "seven", "7"
    l.gsub! "eight", "8"
    l.gsub! "nine", "9"
    first_last l
end.sum
p "Part2=#{part2}"