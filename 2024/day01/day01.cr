FILENAME="input.txt"
#FILENAME="sample.txt"
input_pairs = File.read(FILENAME).lines.map {|l| l.chomp.split.map(&.to_i)}
l, r = input_pairs.transpose.map(&.sort)
p1=l.zip(r).sum {|a,b|(a - b).abs}
t = r.tally
p2=l.sum{|x| x * t.fetch(x, 0)}
puts "Part1: #{p1}"
puts "Part2: #{p2}"