require 'pp'

letters=Array.new(8) {Hash.new(0)} 

input=File.read("input.txt")
input.lines.each do |line|
    line.strip.each_char.with_index do |c, i|
        letters[i][c]=letters[i][c]?letters[i][c]+1:1
    end
end 
puts "Part1:"
letters.each do |h|
    p h.sort_by {|k,v| v}.reverse.first
end
puts "Part2:"
letters.each do |h|
    p h.sort_by {|k,v| v}.first
end 


    

