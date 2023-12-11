require 'set'

def get_star_positions(input) 
  input.flat_map.with_index do |l, j|
   l.chars.map.with_index { [_1, _2] }.select { |c, _| c == ?# }.map { [_2, j] }
  end
end

def get_empty_x(pos)
    xset = pos.map {|p| p[0] }.to_set 
    (0.. xset.max).select { |x| !xset.include?(x) }.to_set
end

def get_empty_y(pos)
    yset = pos.map {|p| p[1] }.to_set 
    (0..yset.max).select { |y| !yset.include?(y) }.to_set
end

def dist(a, b, ex,ey, factor)
    x1, x2, y1, y2 = a[0], b[0], a[1], b[1]
    x_min, x_max = [x1, x2].minmax
    y_min, y_max = [y1, y2].minmax
    edx = (x_min..x_max).count { |x| ex.include? x }
    edy = (y_min..y_max).count { |y| ey.include? y }
    dist = (x1 - x2).abs + (y1 - y2).abs
    dist + edx * factor + edy * factor
end

input=ARGF.readlines(chomp:true)
pos=get_star_positions(input)
ex=get_empty_x(pos)
ey=get_empty_y(pos)

part1=pos.combination(2).map { |a,b| dist(a,b,ex,ey,1)}.sum
part2=pos.combination(2).map { |a,b| dist(a,b,ex,ey,999999)}.sum

puts "Part1=#{part1}"
puts "Part2=#{part2}"