NORTH=0
EAST=1
SUD=2
WEST=3

facing=NORTH
posx=0
posy=0
deltax=[0,1,0,-1]
deltay=[1,0,-1,0]


STDIN.read.split(", ").each do |direction|
#  puts direction,posx,posy
  #p facing
  case direction[0]
    when "R" then
        facing=(facing+1)%3
    when "L" then
        facing==0?3:facing-1
    else
        puts "error"
  end
  dist=direction[1..].to_i
  p dist 
  posx+=dist*deltax[facing]
  posy+=dist*deltay[facing]
end 

p "distance=#{posx.abs+posy.abs}"









