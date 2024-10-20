constellations = []
File.readlines('input.txt').map do |line|
    x,y,z,w = line.split(',').map(&:to_i)
    joined = []
    constellations.each.with_index do |a,i|
        if a.map{|xx,yy,zz,ww| (x-xx).abs + (y-yy).abs + (z-zz).abs + (w-ww).abs <= 3}.any?
            a.push [x,y,z,w]
            joined.push i
        end
    end
    if joined.empty?
        constellations.push [[x,y,z,w]]
    else
        newcons = joined.sort.reverse.flat_map{|i|constellations.delete_at i}
        constellations.push newcons + [[x,y,z,w]]
    end
end
p constellations.size