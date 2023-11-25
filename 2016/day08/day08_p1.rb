WIDTH = 50
HEIGHT = 6

OFF = '.'
ON = '#'

class Part1 
    attr_reader :display

    def initialize
        @display = Array.new(HEIGHT) { Array.new(WIDTH, OFF) }
    end

    def rectangle(a,b)
        (0...b).each do |row|
            (0...a).each do |col|
              @display[row][col] = ON
            end
        end    
    end

    def rotate_row(row,count)
        @display[row].rotate!(-count)    
    end

    def rotate_column(col,count)
        @display = @display.transpose
        @display[col].rotate!(-count)
        @display = @display.transpose    
    end

    def execute(line)
        params=line.split
        case params[0]
        in "rect" 
            a,b=params[1].split("x").map(&:to_i)
            rectangle(a,b)
        in "rotate"
            if params[1]=="row" then
                row=params[2]
                count=params[4]
                rotate_row(row[2..].to_i,count.to_i)
            elsif params[2]=="column"
                column=params[2]
                count=params[4]
                rotate_column(column[2..].to_i,count.to_i)
            end
        else "puts ERROR: #{params}"
        end        
    end
end

input=File.read("input.txt")
p1=Part1.new
input.each_line { |line| p1.execute(line)}
puts p1.display.sum {|row| row.count {|c| c == ON }}

