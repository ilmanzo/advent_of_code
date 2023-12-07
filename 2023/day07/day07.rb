
def hand_tally(str) = str.chars.tally.values.sort
def five_of_a_kind?(str) = hand_tally(str) == [5]
def four_of_a_kind?(str) = hand_tally(str) == [1, 4]
def full_house?(str) = hand_tally(str) == [2, 3]
def three_of_a_kind?(str) = hand_tally(str) == [1, 1, 3]
def two_pair?(str) = hand_tally(str) == [1, 2, 2]
def one_pair?(str) = hand_tally(str) == [1, 1, 1, 2]
def high_card?(str) = hand_tally(str) == [1, 1, 1, 1, 1]

order = "23456789TJQKA".chars 
types = [:high_card?, :one_pair?, :two_pair?, :three_of_a_kind?, :full_house?, :four_of_a_kind?, :five_of_a_kind?]  

hands = Array.new
input = File.read("input.txt").lines
input.each do |line|
  hand, bid = line.split(' ')
  rank = [-1]
  types.each_with_index do |pred, index|
    if send(pred, hand)
      rank = [[index, rank[0]].max]
    end
  end

  line.chars.each do |c|
    rank << order.index(c)
  end

  puts "Hand #{hand} Bid #{bid} #{rank}"
  hands << [rank, bid.to_i]
end
hands.sort!
part1=hands.each_with_index.map{|value,idx| (idx + 1) * value[1]}.sum
puts "Part1=#{part1}"
