def predict(list, part)
  diffs = list.each_cons(2).map {|a, b| b - a}
  diffs.all?(&:zero?) ? list.first : list[part] + predict(diffs,part) 
end
input = File.read("input.txt").lines.map {|l| l.split.map(&:to_i)}
(1..2).each{ |part| p "Part#{part}=",input.map {|l| predict(l,part-2)}.sum}