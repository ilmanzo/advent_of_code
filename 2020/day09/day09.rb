input = File.read("input.txt").split.map(&:to_i)
part1 = input[25..-1].select.with_index { |n,i| !input[i..i+24].any? {|k| input[i..i+24].include?(n-k) } }.first
part2 = (4..input.count).each { |s| input.each_cons(s) { |a| return p (a.min+a.max) if a.reduce(:+) == part1 } }
puts "Part1=#{part1}"
puts "Part2=#{part2}"

