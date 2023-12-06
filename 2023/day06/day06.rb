input=File.read("input.txt")
input_t, input_d = input.lines.map { _1.scan(/\d+/).map(&:to_i) }
part1=input_t.zip(input_d).reduce(1) { |tot, (time, distance)|
  tot * (0..time).count { (time - _1) * _1 > distance }
}
puts "Part1=#{part1}"
# part2
time = input_t.join.to_i
distance = input_d.join.to_i
part2=(0..time).count { (time - _1) * _1 > distance }
puts "Part2=#{part2}"