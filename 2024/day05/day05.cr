#FILENAME="sample.txt"
FILENAME="input.txt"

rules, pagelists = [] of Array(Int32), [] of Array(Int32)
File.read_lines(FILENAME).each do |line|
    rules << line.chomp.split("|").map(&.to_i) if line.includes? "|"
    pagelists << line.chomp.split(",").map(&.to_i) if line.includes? ","
end

# returns 0 for a bad pagelist, mid value for a good one
def value(plist,rules)
    rules.each do |rule|
        a,b=rule.map{|r| plist.index r}
        next if a.nil? || b.nil?
        return 0 if (a>=0 && b>=0 && a>b)
    end
    plist[plist.size//2]
end

# sum median value for good page lists
p1=pagelists.map{|p|value(p,rules)}.sum
puts "part1=#{p1}"
# iterate on wrong page lists
p2=0
pagelists.select{|p| value(p,rules)==0}.each do |p|
    while value(p,rules)==0
        rules.each do |rule|
            a,b=rule.map{|r| p.index r}
            next if a.nil? || b.nil?
            p.swap a,b if (a>=0 && b>=0 && a>b)
        end
    end
    p2+=p[p.size//2]
end
puts "part2=#{p2}"