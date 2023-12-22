input=ARGF.read.split(',')
dist = max_dist = x = y = z = 0
steps={'n'=> [0,1,-1] , 's'=>[0,-1,1], 'ne'=> [1,0,-1], 'sw'=>[-1,0,1], 'nw'=>[-1,1,0],'se'=>[1,-1,0]}
input.each do |d|
    x,y,z=x+steps[d][0],y+steps[d][1],z+steps[d][2]
    dist = (x.abs + y.abs + z.abs)/2
    max_dist=dist if max_dist<dist
end 

puts "Part1=#{dist}"
puts "Part2=#{max_dist}"

