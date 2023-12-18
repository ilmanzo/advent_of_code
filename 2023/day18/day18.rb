require 'pp'

def area(polygon)
    area = 0
    polygon.each_cons(2) do |item|
        (a,b)=item 
        area += a[0]*b[1]
        area -= b[0]*a[1]
    end
    area.abs / 2 
end

def part1(input)
  x,y=0,0
  dirmap={"R" => [1,0], "D" => [0,1], "L"=> [-1,0], "U"=> [0,1]}
  lines=[[0,0]]
  len=0
  input.each do |l|
    items=l.split ' '
    o=dirmap[items[0]]
    r=items[1].to_i
    x,y=x+o[0]*r,y+o[1]*r 
    lines.push([x,y])
    len+=r
  end
  area(lines) + len/2 +1
end


input=ARGF.readlines
puts part1(input)