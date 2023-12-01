def fuel(f)
    sum=0
    while f>0 do
        f=f/3-2
        sum+=f if f>0
    end
    sum
end

input=File.read('input.txt').lines 
part1=input.map{ |l| (l.to_i / 3) - 2}.sum 
puts "Part1=#{part1}"

part2=input.map{ |l| fuel(l.to_i)}.sum
puts "Part2=#{part2}"