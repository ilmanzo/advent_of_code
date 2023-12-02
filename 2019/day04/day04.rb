input = File.read("input.txt")
from, to = input.split("-").map(&:to_i)

count1,count2 = 0,0
(from..to).each do |pw|
  digits = pw.digits
  increasing = digits.each_cons(2).all? { |a, b| a >= b }
  if increasing then
    adjacent = digits.each_cons(2).any? {|a, b| a==b}
    double = digits.chunk(&:itself).any? do |_, chunk|
      chunk.size == 2
    end
    count1 += 1 if adjacent
    count2 += 1 if double
  end
end

puts count1,count2

