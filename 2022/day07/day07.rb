current_path=[]
foldersize={"/" => 0}

File.read("input.txt").each_line do |line|
    line=line.strip
    case line
    when /\.\./ then
        current_path.pop
    when /\$ cd \w+/ then
        current_path.push line[5..]
        foldersize["/"+current_path.join('/')]=0
    when /^\d+/ then 
        size=line.split.first.to_i
        foldersize["/"]+=size
        tmp=current_path.dup
        while tmp.length>0
            foldersize["/"+tmp.join('/')]+=size
            tmp.pop
        end
    end
end

p "part1=#{foldersize.values.filter {|v| v<=100000}.sum}"
minimum_to_free = foldersize["/"] + 30000000 - 70000000
p "part2=#{foldersize.values.sort.filter {|v| v>minimum_to_free}.first}"
