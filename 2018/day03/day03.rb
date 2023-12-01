require 'set'

input= File.read("input.txt").lines 

grid = Array.new(1000) { Array.new(1000) {Set.new} }

candidates = Set.new

input.each do |claim|
    id,claim = claim.split("@")
    ord, dim = claim.split(":")
    x, y = ord.split(",").map(&:to_i)
    w, h = dim.split("x").map(&:to_i)
    id = id[1..-1].to_i
    candidates.add id
    w.times do |x1|
      h.times do |y1|
        cell = grid[x+x1][y+y1]
        if cell.any?
          candidates.delete id
          cell.each do |c|
            candidates.delete c
          end
        end
        cell.add id
      end
    end
  end
  
part1= grid.flatten.select { |cell| cell.size > 1 }.count    
puts "Part1=#{part1}"

part2=candidates.to_a
puts "Part2=#{part2}"
