input = File.read("input.txt").lines

# returns a tuple with card id (string), winning numbers (int array) and my numbers (int array)
def parse_input(line)
  row=line.split(" | ")
  r=row[0].split(':')
  card_id=r.first.split.last.to_i
  winning=r.last.split.map(&:to_i)
  my_numbers=row[1].strip.split.map(&:to_i)
  [card_id,winning,my_numbers]
end

#debug
#p parse_input("Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11")

part1=input.map do |line| 
    card,winning,my_numbers=parse_input line
    count=(my_numbers & winning).length
    count == 0 ? 0 : (2 ** (count-1))
end.sum
p "Part1=#{part1}"

#part2
card_instances = Array.new(input.length, 1)
input.each_with_index do |line,i|
  card,winning,my_numbers=parse_input line
  win_count=(my_numbers & winning).length
  win_count.times do |j|
    card_instances[i+j+1] += card_instances[i]
  end
end
p "Part2=#{card_instances.sum}"

