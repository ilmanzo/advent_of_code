input=File.read("input.txt")

sum = 0
digits=input.chars.map(&:to_i)
digits.each_cons(2) do |pair| 
    sum+=pair[0] if pair[0]==pair[1]
end
sum+=digits[0] if digits[0]==input[-1]

p "part1=#{sum}"

sum = 0
len=digits.length
digits.each_with_index do |d,i| 
    sum+=d if d==digits[(i+len/2)%len]
end

p "part2=#{sum}"