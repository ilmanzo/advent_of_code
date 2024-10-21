value, loop_size = 1, 0
CARD_PUBLIC_KEY=15113849
DOOR_PUBLIC_KEY=4206373
while value != CARD_PUBLIC_KEY do
    value = value * 7 % 20201227
    loop_size += 1
end

p "loop size= #{loop_size}"
# do exponentiation by iterating
result=1
loop_size.times do
    result*=DOOR_PUBLIC_KEY
    result=result % 20201227
end
p "Solution=#{result}"

