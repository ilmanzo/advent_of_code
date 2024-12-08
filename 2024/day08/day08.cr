require "set"

alias Point=Tuple(Int32,Int32)

def part1(antennas,w,h)
    antinodes = Set(Point).new
    antennas.each do | char, coords |
    coords.each_permutation(2,reuse:true) do | item | 
        x1,y1=item[0]
        x2,y2=item[1]
        dx, dy = x2 - x1, y2 - y1
        x, y = x1 - dx, y1 - dy
        antinodes.add({x, y}) if x>=0 && x<w && y>=0 && y<h 
    end
    end
    antinodes.size
end

def part2(antennas,w,h)
    antinodes = Set(Point).new
    antennas.each do | char, coords |
        coords.each_permutation(2,reuse:true) do | item | 
            x1,y1=item[0]
            x2,y2=item[1]
            dx, dy = x2 - x1, y2 - y1
            x, y = x1 + dx, y1 + dy
            while x>=0 && x<w && y>=0 && y<h
                antinodes.add({x, y})
                x+=dx
                y+=dy
            end
        end
    end
    antinodes.size
end

FILENAME="input.txt"
#FILENAME="sample.txt"

antennas = Hash(Char,Array(Point)).new{|h, k| h[k] = [] of Point }
input = File.read_lines(FILENAME).map(&.chomp).map(&.chars)
w,h=input.first.size,input.size
input.each_with_index do | row, y |
  row.each_with_index do | char, x |
    antennas[char] << {x, y} unless char == '.'
  end
end

puts part1(antennas,w,h)
puts part2(antennas,w,h)
