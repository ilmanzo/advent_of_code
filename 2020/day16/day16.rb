rules, your, nearby = File.read("input.txt").split("\n\n")
rules = rules.lines.map do |l|
  l.scan(/(\d+)-(\d+)/).map { |x| Range.new(*x.map(&:to_i)) }
end
your = your.scan(/\d+/).map(&:to_i)
nearby = nearby.lines.map { |l| l.scan(/\d+/).map(&:to_i) }.select(&:present?)
p nearby.flatten.select { |v| rules.flatten.none? { |r| r === v } }.sum
# remove failures
nearby = nearby.reject do |tix|
  tix.any? { |v| rules.flatten.none? { |r| r === v } }
end
# which columns matches?
matches = rules.each.with_index.map do |rule, ri|
  columns = nearby.first.each_index.select do |ii|
    nearby.all? { |tix| rule.any? { |r| r === tix[ii] } }
  end
  [ ri, columns ]
end
map = []
until matches.blank?
  done, matches = matches.partition { |m| m[1].length == 1 }
  done.each do |ri, cols|
    map[ri] = cols.first
    matches.each { |m| m[1].delete(cols.first) }
  end
end
# multiply
p (0..5).map { |r| your[map[r]] }.inject(&:*)