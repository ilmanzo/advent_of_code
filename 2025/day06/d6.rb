*lines, ops = $stdin.readlines(chomp: true)
ops = ops.split
p lines.map(&:split).transpose.map{_1.map(&:to_i)}.zip(ops).sum{|c,o|o=='+'?c.sum: c.reduce(:*)}
p lines.map(&:chars).transpose.map(&:join).chunk { _1.strip.empty? }.reject(&:first).map { _2.map(&:to_i) }.zip(ops).sum { |c, o| o == '+' ? c.sum : c.reduce(:*) }