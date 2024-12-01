FILENAME="input.txt"
#FILENAME="sample.txt"
input_pairs = File.read(FILENAME).lines.map {|l| l.chomp.split.map(&.to_i)}
l,r = input_pairs.transpose.map(&.sort)
p l.zip(r).sum {|a,b|(a-b).abs}
p l.sum{|x| x * r.tally.fetch(x,0)}
