def part1(input)
  found = Set{"0"}
  pending = ["0"]

  while node = pending.pop?
    others = input[node]
    others.each do |other|
      unless found.includes?(other)
        pending << other
        found << other
      end
    end
  end
  found.size
end

def part2(input)
  groups = [] of Set(String)

  input.each_key do |start|
    next if groups.any? &.includes?(start)

    group = Set{start}
    pending = [start]

    while node = pending.pop?
      others = input[node]
      others.each do |other|
        unless group.includes?(other)
          pending << other
          group << other
        end
      end
    end

    groups << group
  end
  groups.size
end

input = File.read("input.txt").strip.each_line.map do |line|
  left, right = line.split("<->").map(&.strip)
  {left, right.split(",").map(&.strip)}
end.to_h

puts "Part1=#{part1(input)}"
puts "Part2=#{part2(input)}"
