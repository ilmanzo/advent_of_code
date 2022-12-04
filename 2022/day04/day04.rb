# true if one range overlaps another
def overlap?(r1,r2)
    !(r1.first > r2.last || r1.last < r2.first)
end

input = File.read("input.txt").lines.map {|l| l.scan(/(\d+)-(\d+),(\d+)-(\d+)/).map{|x| x.map(&:to_i)}}
part1,part2=0,0
input.each do |sect| s=sect.pop
    r1=Range.new s[0],s[1]
    r2=Range.new s[2],s[3]
    part1+=1 if r1.cover?(r2) or r2.cover?(r1)
    part2+=1 if overlap?(r1,r2)
end
puts "part1=#{part1},part2=#{part2}"
