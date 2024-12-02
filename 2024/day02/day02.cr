def is_safe(row)
   deltas=row.each_cons_pair.map{|a,b| (b-a)}
   deltas.all? { |n| (n>=1 && n<=3) } || deltas.all? { |n| (n>=-3 && n<=-1) }
end

FILENAME="input.txt"
#FILENAME="sample.txt"
input = File.read(FILENAME).lines.map {|l| l.chomp.split.map(&.to_i)}
p input.count{|row| is_safe row}

