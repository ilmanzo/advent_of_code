require 'set'

def part1(cubes)
    commonfaces=0
    cubes.each do |c| 
        (x,y,z)=*c
        commonfaces+=1 if cubes.include?([x-1,y,z]) 
        commonfaces+=1 if cubes.include?([x+1,y,z]) 
        commonfaces+=1 if cubes.include?([x,y-1,z]) 
        commonfaces+=1 if cubes.include?([x,y+1,z])
        commonfaces+=1 if cubes.include?([x,y,z-1])
        commonfaces+=1 if cubes.include?([x,y,z+1])
    end
    6*cubes.length-commonfaces
end

def part2(cubes)
    max_x=cubes.map{|c|c[0]}.max
    max_y=cubes.map{|c|c[1]}.max
    max_z=cubes.map{|c|c[2]}.max
    d=1+[max_x,max_y,max_z].max
    #create 3d big cube of N*N*N
    space=Array.new(d*d*d,false)
    cubes.each do |c| 
        (x,y,z)=*c
        space[x+y*d+z*d*d]=true
    end
    faces=0
    # count cubes who have an empty space
    state=:outside
    prevstate=:outside
    (0..d).each do |z|
        (0..d).each do |y|
            (0..d).each do |x|
                pos=x+y*d+z*d*d
                if space[pos]
                    if prevstate==:outside
                        newstate=:inside
                        faces+=1
                    end                        
                else 
                    if prevstate==:inside 
                        newstate=:outside
                    end
                end
                newstate=prevstate
            end
        end
    end
    faces
end

#read and parse input
cubes=STDIN.each_line.map do |l|
    l.split(",").map(&:to_i)
end.to_set 

p1=part1(cubes)
p2=part2(cubes)
p "Part1: #{p1}"
p "Part2: #{p2}"

