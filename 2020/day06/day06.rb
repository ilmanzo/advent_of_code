require 'set'

input=ARGF.readlines(chomp:true)

def part1(input)
    answers=Set.new
    sum=0
    input.each do |l|
        l.chars.each { |c| answers << c} 
        if l.empty? 
            sum+=answers.length 
            answers.clear
        end
    end
    sum+answers.length 
end

def part2(input)
    sum=0
    answers=Array.new
    input.each do |l|
        if l.empty?
          s=Set.new("abcdefhijklmnopqrstuvwxyz".chars)
          answers.each do |a|
            s=s.intersection(a)
          end   
          p "reduced=#{s}"
          sum+=s.length
          answers.clear
          next
        end
        answers << l.chars.to_set
        p "answers=#{answers}"
    end          
    s=Set.new("abcdefhijklmnopqrstuvwxyz".chars)
    answers.each do |a|
      s=s.intersection(a)
    end   
    sum + s.length
end

p part1 input
p part2 input



