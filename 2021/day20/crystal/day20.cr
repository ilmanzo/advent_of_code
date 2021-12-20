data=File.read_lines("../input.txt").map(&.chomp.strip)
alias Point=Tuple(Int32,Int32)

alg=data[0]
img=data[2..]
h=img.size
w=img[0].size

#populate the litset, set of points already lit
litset=Set(Point).new
(0...h).each do |y|
    (0...w).each do |x|
        if img[y][x]=='#'
            litset << {x,y}
        end
    end
end

#compute the binary number represented by 3x3 square at coords x,y in the image
def calc_index(x,y,i,alg,img,litset)
    h=img.size+N
    w=img[0].size+N    
    result=0
    (y-1..y+1).each do |yy|
        (x-1..x+1).each do |xx|
            result*=2
            if xx< (-N) || xx>(w-1) || yy< (-N) || yy > (h-1)
                result+=1 if i.odd? && alg[0]=='#'
            elsif litset.includes?({xx,yy})
                result+=1
            end
        end
    end
    result
end

N=50
h,w = h+N, w+N
(1..N).each do |i|
    newlits=Set(Point).new
    (-N...h).each do |y|
        (-N...w).each do |x|
            j=calc_index(x,y,i,alg,img,litset)
            newlits << {x,y} if alg[j]=='#'
        end
    end
    litset=newlits
    puts "Part1: #{litset.size}" if i==1
end
puts "Part2: #{litset.size}" 


                    




