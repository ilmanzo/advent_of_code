def distance(x1, y1, x2, y2) = Math.sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
def angle(x1, y1, x2, y2) = Math.atan2(x2-x1, -(y2-y1)) % (2*Math::PI)

input = ARGF.each_line.with_index.flat_map do |line, linenum|
    line.each_char.with_index.flat_map do |char, charnum|
        char == '#' ?  [[charnum, linenum]] : []
    end
end

location, lines_of_sight = input.map do |ast|
    others = input - ast
    lines = others.group_by { |other| angle(*ast, *other) }
    [ast, lines]
end.max_by { |_, lines| lines.size }

puts "Part1=#{lines_of_sight.size}"

part2=lines_of_sight.sort[199].last.min_by { |ast| distance(*location, *ast) }.then { |x,y| x*100+y }

puts "Part2=#{part2}"