input = File.read("input.txt").split("\n")
elves = Array(Int32).new
sum = 0
input.each do |line|
  if line.empty?
    elves.push sum
    sum = 0
  else
    sum += line.to_i
  end
end

puts "part1=#{elves.max}"
elves.sort!
best3 = elves[-1] + elves[-2] + elves[-3]
puts "part2=#{best3}"
