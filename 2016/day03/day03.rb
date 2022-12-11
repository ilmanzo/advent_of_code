triangles=0

def is_triangle(a,b,c)
    (a+b)>c and (a+c)>b and (b+c)>a 
end
input=File.readlines('input.txt').map{|l| l.split.map(&:to_i)}
part1=input.filter { |t| is_triangle(t[0],t[1],t[2])}.count 

p "part1=#{part1}"

part2=0
input.each_slice(3) do |i| 
    part2+=1 if is_triangle i[0][0],i[1][0],i[2][0]
    part2+=1 if is_triangle i[0][1],i[1][1],i[2][1]
    part2+=1 if is_triangle i[0][2],i[1][2],i[2][2]
end

p "part2=#{part2}"