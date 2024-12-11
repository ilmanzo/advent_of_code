FILENAME="input.txt"
#FILENAME="sample.txt"
input = File.read_lines(FILENAME).map(&.chomp.chars.map(&.to_i))
DIRS=[{-1,0},{0,1},{1,0},{0,-1}]
alias Point=Tuple(Int32,Int32)
def path(input,sx,sy)
    heigth=input.size
    width=input[0].size
    q=Deque.new([{sx,sy}])
    result=0
    seen=Set(Point).new
    while q.size>0
        puts q # debug
        p=q.pop
        x,y=p[0],p[1]
        next if seen.includes?({x,y})
        seen.add({x,y})
        result+=1 if input[y][x]==0
        DIRS.each do |d|
            xx,yy=x+d[0],y+d[1]
            q.push({xx,yy}) if xx>=0 && yy>=0 && xx<width && yy<heigth && input[yy][xx]==input[y][x]-1
        end
    end
    result
end

part1=0
(0..input.size).each do |r|
    (0..r).each do |c|
        part1+=path(input,c,r) if input[r][c]==9
    end
end

p part1

