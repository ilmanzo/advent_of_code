require 'set'

def step(dir,x,y)
    case dir
    when "U"
        y += 1
    when "D"
        y -= 1
    when"L"
        x -= 1
    when "R"
        x += 1
    end
    [x,y]
end


def walkp1(path)
  visited = Set.new
  x, y = 0, 0
  path.split(",").each do |instr|
    dir = instr[0]
    steps = instr[1..].to_i
    steps.times do
        (x,y) = step(dir,x,y)
        visited.add [x,y]
    end
  end
  visited
end

def walkp2(path)
  visited = {}
  x, y = 0, 0
  step = 1
  path.split(",").each do |instr|
    dir = instr[0]
    steps = instr[1..].to_i
    steps.times do
      x,y = step(dir,x,y)
      visited[[x,y]] = step unless visited[[x,y]]
      step += 1
    end
  end
  visited
end

def part1(path_a,path_b)
  intersection = walkp1(path_a) & walkp1(path_b)
  intersection.map { |x, y| x.abs + y.abs }.min
end

def part2(path_a,path_b)
  visited_a = walkp2(path_a)
  visited_b = walkp2(path_b)
  intersection = visited_a.keys & visited_b.keys
  intersection.map { |x, y| visited_a[[x,y]] + visited_b[[x,y]] }.min
end 
    
input = File.read("input.txt")
path_a, path_b = input.split("\n")
part1=part1(path_a,path_b)
part2=part2(path_a,path_b)
puts "Part2=#{part2}"


