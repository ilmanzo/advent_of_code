
input = File.read("input.txt").lines.map(&:chomp)
#input = File.read("sample.txt").lines.map(&:chomp)

def symbol_neighbor?(input,y,x0,x1,num,gears)
    (y-1..y+1).each do |yc|
        (x0-1..x1+1).each do |xc|
            if xc>=0 && yc>=0 && yc<input.length && xc<input[yc].length then
                gears[[yc,xc]].push(num) if input[yc][xc]=='*'
                return true unless "0123456789.".include?(input[yc][xc])
            end
        end
    end
    false
end

rows=input.length
total=0
gears=Hash.new { |hash, key| hash[key] = [] }
(0...rows).each do |row|
  input[row].scan(/\d+/) do |match|
    x_start=input[row].index(match)
    x_end=x_start+match.length
    if symbol_neighbor?(input,row,x_start,x_end,match.to_i,gears) then
        puts "found part_number: #{match}"
        total+=match.to_i
    end
  end
end

puts "Part1=#{total}"
part2=0
gears.each do |k,v| 
    part2+=v[0]*v[1] if v.length==2
end
puts "Part2=#{part2}"