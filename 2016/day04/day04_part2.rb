def rotate(s, n)
    s.each_char.map do |ch|
        if ch == '-' then ' ' else 
            v=ch.ord-'a'.ord+n
            ((v % 26)+'a'.ord).chr
        end
    end.join
end

STDIN.each_line.map do |line| 
    (input,roomid,crc)=line.chomp.scan(/^(.+)-(\d+)\[(\w+)\]/).first
    p "#{rotate(input, roomid.to_i)} - #{roomid}"
end