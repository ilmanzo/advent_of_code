IMG_W = 25
IMG_H = 6

input=File.read("input.txt").chomp.chars.map(&:to_i)

part1 = input.each_slice(IMG_W * IMG_H).min_by do |layer|
  layer.count { |d| d.zero? }
end.tally.reject { |k, _v| k == 0 }.values.inject(&:*)
puts "Part1=#{part1}"

COLOR_TRANS = 2
PRINT_MAP = { 0 => ' ', 1 => '#' }

image = input.each_slice(IMG_W * IMG_H).reverse_each.reduce do |img, layer|
  img.length.times do |i|
    img[i] = layer[i] unless layer[i] == COLOR_TRANS
  end
  img
end

puts "Part2:"
image.map { |d| PRINT_MAP[d] }.each_slice(IMG_W) do |row|
  puts row.join
end
