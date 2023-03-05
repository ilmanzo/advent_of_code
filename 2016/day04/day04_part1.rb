part1=STDIN.each_line.map do |line| 
    (input,roomid,crc)=line.chomp.scan(/^(.+)-(\d+)\[(\w+)\]/).first
    freq=input.chars.filter{|c| c!="-"}.tally.sort_by {|k,v| [v,255-k.ord]}.reverse[..4]
    crc==freq.map{|f|f[0]}.join('') ? roomid.to_i : 0
end.sum

p part1 

    