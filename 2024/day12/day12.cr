FILENAME = "input.txt"
# FILENAME = "sample.txt"
d12_p1 = Day12.new FILENAME, 1
d12_p2 = Day12.new FILENAME, 2
p d12_p1.run
p d12_p2.run

class Day12
  DIRS = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
  alias Point = Tuple(Int32, Int32)
  @grid : Array(Array(Char))
  @part2 : Bool

  def initialize(filename,part)
    @grid = File.read_lines(filename).map(&.chars)
    @height = @grid.size
    @width = @grid.first.size
    @seen = Set(Point).new
    @part2 = part==2
  end

  def peek(x : Int32, y : Int32)
    x < 0 || y < 0 || x >= @width || y >= @height ? '*' : @grid[y][x]
  end

  def score(x : Int32, y : Int32, c : Char)
    return {0, 0} if @seen.includes?({x, y}) || peek(x, y) != c
    @seen.add({x, y})
    area = 1
    perimeter = 0
    DIRS.each do |dx, dy|
      if peek(x + dx, y + dy) != c
        perimeter += 1
        if @part2
          perimeter -= 1 if {dx, dy} == {0, 1} && peek(x + 1, y) == c && peek(x + 1, y + 1) != c
          perimeter -= 1 if {dx, dy} == {0, -1} && peek(x + 1, y) == c && peek(x + 1, y - 1) != c
          perimeter -= 1 if {dx, dy} == {1, 0} && peek(x, y + 1) == c && peek(x + 1, y + 1) != c
          perimeter -= 1 if {dx, dy} == {-1, 0} && peek(x, y + 1) == c && peek(x - 1, y + 1) != c
        end
      else
        partial_area, partial_perimeter = score(x + dx, y + dy, c)
        area += partial_area
        perimeter += partial_perimeter
      end
    end
    {area, perimeter}
  end

  def run
    total = 0
    @height.times do |y|
      @width.times do |x|
        area, perimeter = score(x, y, peek(x, y))
        total += area * perimeter
      end
    end
    total
  end
end
