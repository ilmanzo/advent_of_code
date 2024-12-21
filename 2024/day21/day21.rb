require_relative "day21_class"
d21=Day21.new readlines.grep(/\d{3}A/).map(&:chomp)
p d21.solve 2
p d21.solve 25