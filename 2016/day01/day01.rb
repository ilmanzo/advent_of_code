require 'set'

NORTH=0
EAST=1
SUD=2
WEST=3

facing=NORTH
posx=0
posy=0
deltax=[0, 1,0,-1]
deltay=[-1,0,1,0]

visited=Set.new

STDIN.read.split(", ").each do |direction|
#  puts direction,posx,posy
  p facing
  case direction[0]
    when "R" then
        facing=(facing+1)%4
    when "L" then
        facing=(facing-1)%4
    else
        puts "error"
  end
  dist=direction[1..].to_i
  #p dist 
  dist.times do
    posx+=deltax[facing]
    posy+=deltay[facing]
    if visited.include?([posx,posy])
      p "p2 distance=#{posx.abs+posy.abs}"
      break
    else
      visited.add([posx,posy])
    end
  end
end 

p "p1 distance=#{posx.abs+posy.abs}"









