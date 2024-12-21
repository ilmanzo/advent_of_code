#FILENAME = "input.txt"
FILENAME = "sample.txt"
input = File.read_lines(FILENAME, chomp:true)
height = input.size
width = input[0].size
# Find start and end positions
start_pos = nil
end_pos = nil
input.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    start_pos = {x, y} if char == 'S'
    end_pos = {x, y} if char == 'E'
  end
end
raise "Start not found!" unless start_pos
raise "End not found!" unless end_pos
# Initialize tracking
track = {start_pos => 0}.to_h
cur = start_pos
curstep = 0
# Traverse the grid
while cur != end_pos
  curstep += 1
  x, y = cur
  [{-1, 0}, {0, -1}, {0, 1}, {1, 0}].each do |dx, dy|
    newx, newy = x + dx, y + dy
    if newx >= 0 && newx < width && newy >= 0 && newy < height && !track.has_key?({newx, newy}) && "SE.".includes?(input[newx][newy])
      cur = {newx, newy}
      track[cur] = curstep
      break
    end
  end
end
p track
count = 0
track.keys.each do |k|
  x,y=k[0],k[1]
  [{-1, 0}, {0, -1}, {0, 1}, {1, 0}].each do |dx, dy|
    if !track.has_key?({x + dx, y + dy}) && track.has_key?({x + 2 * dx, y + 2 * dy}) && track[{x + 2 * dx, y + 2 * dy}] - track[{x, y}] >= 102
      count += 1
    end
  end
end
puts count