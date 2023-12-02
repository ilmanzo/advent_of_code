def get_counts(line)
    counts = { "blue" => 0, "green" => 0, "red" => 0 }
    line.split(": ").last.split(/[;,] /).each do |c|
        count, color = c.split(" ")
        counts[color] = count.to_i if counts[color] < count.to_i
    end
    counts
end

def part1(input)
  input.map do |line|
    game_id = line[/\d+/].to_i
    counts=get_counts line
    counts["red"] <= 12 && counts["green"] <= 13 && counts["blue"] <= 14 ? game_id : 0
  end.sum
end

def part2(input)
  input.map do |line|
    counts = get_counts line
    counts.values.reduce(1, &:*)
  end.sum
end

input = File.read("input.txt").lines
#input = File.read("sample.txt").lines
puts "Part1=", part1(input)
puts "Part2=", part2(input)
