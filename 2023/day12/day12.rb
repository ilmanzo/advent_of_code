
def solve(s, w, v)
    if s.empty? then
        return 1 if w.nil? && v.length==0
        return 1 if v.length==1 and !w.nil? && w==v[0]
        return 0
    end
    p=s.chars.count {|c| c=='#'|| c=='?'}
    return 0 if !w.nil? && (p+w)<v.sum 
    return 0 if !w.nil? && v.length==0
    return 0 if w.nil? && p<v.sum
    return 0 if s[0]=='.' && !w.nil? && w!=v[0]
    poss=0
    poss+=solve(s[1..],nil,v[1..]) if s[0]=='.' && !w.nil?
    poss+=solve(s[1..],nil,v[1..]) if s[0]=='?' && !w.nil? && w!=v[0]
    poss+=solve(s[1..],w+1,v) if (s[0]=='#' || s[0]=='?') && !w.nil?
    poss+=solve(s[1..],1,v) if (s[0]=='#' || s[0]=='?') && w.nil?
    poss+=solve(s[1..],nil,v) if (s[0]=='?' || s[0]=='.') && w.nil?
    poss
end

part1=0
input=ARGF.readlines(chomp:true)
input.each do |l|
    item=l.split(' ')
    v=item.last.split(',').map(&:to_i)
    part1+=solve(item.first,nil,v)
end
puts part1


