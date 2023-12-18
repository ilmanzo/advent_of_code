
def is_infinite(grid, x_max, y_max, px, py) = [grid[0][px], grid[y_max][px], grid[py][0], grid[py][x_max]].include?([px, py])
def dist_to_points(points, b) = points.sum { |a| manhattan_distance(a, b) }
def manhattan_distance(p1, p2) = (p1[0]-p2[0]).abs + (p1[1]-p2[1]).abs
def area(grid, _x_max, _y_max, point) = grid.flatten(1).count {|p| p == point}
    
def closest_point(points, x, y)
    distances = points.map { |p| [manhattan_distance(p, [x, y]), p] }
    min_dist_point = distances.min_by(&:first)
    points = distances.select { |d, _p| d == min_dist_point[0] }
    points.length > 1 ? nil : min_dist_point[1]
end
 
input = ARGF.each_line.map { |l| l.split.map(&:to_i) }
x_max = input.map(&:first).max
y_max = input.map(&:last).max
  
grid = Array.new(y_max + 1)
(0...grid.length).each do |y|
  grid[y] = Array.new(x_max + 1)
  (0...grid[0].length).each do |x|
    grid[y][x] = closest_point(input, x, y)
  end
end
  
finite_points = input.reject { |x, y| is_infinite(grid, x_max, y_max, x, y) }
puts finite_points.map { |p| area(grid, x_max, y_max, p) }.max

MAX_DIST = 10_000

region = (0..y_max).sum do |y|
  (0..x_max).count do |x|
    dist_to_points(input, [x, y]) < MAX_DIST
  end
end
puts region