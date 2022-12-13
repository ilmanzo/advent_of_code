input = STDIN.read.split("\n\n").map do |pair|
    pair.split("\n").map(&method(:eval))
end
  
def compare(a, b)
    if a.is_a?(Integer) && b.is_a?(Integer)
        a <=> b
    elsif a.is_a?(Array) && b.is_a?(Array)
        (0...[a.length, b.length].min).each { |i|
            c = compare(a[i], b[i])
            return c unless c == 0
        }
        a.length <=> b.length
    else
        if a.is_a?(Integer)
           compare([a], b)
        else
           compare(a, [b])
        end
    end
end

# can be done with map .. sum 
part1=0
input.each_with_index do |pair,i| 
    part1+=i+1 if compare(*pair)==-1
end
p "part1: #{part1}"

divider2 = [[2]]
divider6 = [[6]]
all_pairs = input.flat_map(&:itself) << divider2 << divider6
sorted = all_pairs.sort {|a,b| compare(a,b)}
index2=1+sorted.find_index(divider2)
index6=1+sorted.find_index(divider6)
part2=index2*index6
p "part2: #{part2}"
