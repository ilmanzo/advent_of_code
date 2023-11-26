input=File.read("input.txt")

def is_valid(line, part=1)
    items=line.split
    hash = Hash.new(0)
    if part==1 then
        items.each {|key| hash[key]+=1}
    else
        items.each {|key| hash[key.chars.sort.join]+=1}
    end
    hash.values.all? {|v| v==1}
end

part1=input.each_line.select { |line| is_valid(line,1) }.count
p "part1=#{part1}"

part2=input.each_line.select { |line| is_valid(line,2) }.count
p "part2=#{part2}"
