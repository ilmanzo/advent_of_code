def part2(input)
    seen=Hash.new {false}
    freq=0
    while true do
        input.each do |f|
            freq+=f 
            return freq if seen[freq]
            seen[freq]=true
        end
    end
end

input=File.read("input.txt").lines.map {|x| x.to_i}
p "Part1=#{input.sum}"
#p "Part2=#{part2(input)}"
part2=part2(input)
p part2