FILENAME="sample.txt"
#FILENAME="input.txt"

rules, pagelists = [] of Array(Int32), [] of Array(Int32)
File.read_lines(FILENAME).each do |line|
    rules << line.chomp.split("|").map(&.to_i).to_a if line.includes? "|"
    pagelists << line.chomp.split(",").map(&.to_i).to_a if line.includes? ","
end

part1=pagelists.map do |plist|
    v=plist[plist.size//2]
    rules.each do |rule|
        a,b=rule.map{|r| plist.index r}
        next if a.nil? || b.nil?
        v=0 if a>=0 && b>=0 && a>b
    end
    v
end.sum
puts "part1=#{part1}"