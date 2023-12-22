require 'set'

input=ARGF.readlines
w = h = input.length # a square
dirsteps = {:U => [-1, 0],:D => [1, 0], :R => [0, 1], :L => [0, -1]}
directions=[:U, :D, :R, :L]

pos = [0,0]
rocks = Set.new
input.each_with_index do |line,i|
    line.chars.each_with_index do |ch,j|
        rocks.add [j,i] if ch=='#'
        pos=[j,i] if ch=='S'
    end
end
puts "Starting pos = #{pos}"
circles = Set.new
directions.each do |dir|
    nx = pos[0]+dirsteps[dir][1]
    ny = pos[1]+dirsteps[dir][0]
    circles.add([ny,ny]) unless rocks.include? [nx,ny]
end
64.times do |n|
    result = Set.new
    queue=circles.to_a
    while queue.length>0 do 
      px,py = queue.pop
      directions.each do |dir|
          nx = px+dirsteps[dir][1]
          ny = px+dirsteps[dir][0]
          result.add([nx,ny]) unless rocks.include? [nx % w, ny % h]
      end
    end
    circles=result 
end

puts "Part1=#{circles.length}"