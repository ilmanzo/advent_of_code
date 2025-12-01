p, p1, p2 = 50, 0, 0
ARGF.each do |l|
  t = l[1..].to_i
  d = l[0] == 'L' ? -1 : 1
  p2 += ((100 + d * p) % 100 + t) / 100
  p = (p + d * t) % 100
  p1 += 1 if p == 0
end
puts "Part 1: #{p1}"
puts "Part 2: #{p2}"