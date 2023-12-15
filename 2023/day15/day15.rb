def part2(input)
    boxes = {}
    input.each do |op|
        if(op =~ /(\w+)(=|-)(\d?)/)
        h = hash(Regexp.last_match(1))
        boxes[h] ||= {}
        case(Regexp.last_match(2))
            when ?=
                boxes[h][Regexp.last_match(1)] = Regexp.last_match(3)
            when ?-
                boxes[h].delete(Regexp.last_match(1))
            end
        end
    end
    sum = 0
    boxes.keys.each do |k|
        v=(k.to_i+1) * (boxes[k].map.with_index { |l, idx| (idx+1)*(l[1].to_i) }.sum)
        sum+=v if (boxes[k] && boxes[k].size>0)
    end
    sum 
end

def hash(str)
    str.chars.reduce(0) { |acc, c| ((acc + c.ord)*17) & 0xFF }
end


input=ARGF.readline.split(',')
part1=input.sum {|s| hash(s)}
part2=part2(input)

puts "Part1=#{part1}"
puts "Part2=#{part2}"
