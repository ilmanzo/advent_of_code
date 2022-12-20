
def mix(data)
    data.size.times do |n|    
        idx = data.find_index {_2 == n}
        val = data.delete_at(idx)
        data.insert((idx + val[0]) % data.size, val)
    end
    data
end

def part1(input)
    data = input.each_with_index.map { |n, i| [n,i] }
    mix(data)
end

def part2(input)
  data = input.each_with_index.map { |n, i| [n * 811589153, i] }
  10.times {mix(data)}
  data
end

input = STDIN.readlines.map(&:to_i)
sz=input.size

[part1(input),part2(input)].each do |decoded|
    zidx = decoded.find_index { _1[0] == 0 }
    n1 = decoded[(zidx + 1000) % sz][0]
    n2 = decoded[(zidx + 2000) % sz][0]
    n3 = decoded[(zidx + 3000) % sz][0]
    #p n1,n2,n3
    p "Sum=#{n1+n2+n3}"
end
