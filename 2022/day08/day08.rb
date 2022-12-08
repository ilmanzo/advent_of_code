def part1(grid)
  grid_t = grid.transpose
  result = grid.length * 4 - 4
  (1..grid.length - 2).each do |y|
    (1..grid.length - 2).each do |x|
      left = grid[y][0...x].all? { |t| t < grid[y][x] }
      right = grid[y][x + 1..-1].all? { |t| t < grid[y][x] }
      up = grid_t[x][0...y].all? { |t| t < grid[y][x] }
      down = grid_t[x][y + 1..-1].all? { |t| t < grid[y][x] }
      result += 1 if left || right || up || down
    end
  end
  result
end

def part2(grid)
  grid_t = grid.transpose
  result = 1
  (1...grid.length - 1).each do |y|
    (1...grid.length - 1).each do |x|
      left = grid[y][0...x].reverse.find_index { |t| t >= grid[y][x] }
      left = left ? left + 1 : grid[y][0...x].length
      right = grid[y][x + 1..-1].find_index { |t| t >= grid[y][x] }
      right = right ? right + 1 : grid[y][x + 1..-1].length
      up = grid_t[x][0...y].reverse.find_index { |t| t >= grid[y][x] }
      up = up ? up + 1 : grid_t[x][0...y].length
      down = grid_t[x][y + 1..-1].find_index { |t| t >= grid[y][x] }
      down = down ? down + 1 : grid_t[x][y + 1..-1].length
      t = left * right * up * down
      result = t if t > result
    end
  end
  result
end

grid = []
File.readlines('input.txt').each do |line|
  break if line == "\n"
  grid << line.chomp.chars.map(&:to_i)
end

p "Part1=#{part1 grid}"
p "Part2=#{part2 grid}"