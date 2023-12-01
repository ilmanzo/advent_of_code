input=File.read("input.txt").split(",").map(&:to_i)

def run(input,noun,verb)
    codes=input.dup
    codes[1]=noun
    codes[2]=verb
    i = 0
    loop do
      case codes[i]
      when 1
        codes[codes[i+3]]=codes[codes[i+1]]+codes[codes[i+2]]
      when 2
        codes[codes[i+3]]=codes[codes[i+1]]*codes[codes[i+2]]
      when 99
        return codes[0]
        exit
      end
      i += 4
    end
end

puts "Part1=#{run(input,12,2)}"

100.times do |n|
    100.times do |v|
      result = run(input,n, v)
      if result == 19690720
        puts "Part2=#{100 * n + v}"
        exit
      end
    end
  end

#puts "Part2=#{part2(input)}"

    
