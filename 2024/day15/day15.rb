require 'matrix'

module Day15 

BOX,WALL,EMPTY,L_BOX,R_BOX = 'O','#','.','[',']'
DIRS = { '^' => Vector[0, -1],'>' => Vector[1, 0],'v' => Vector[0, 1],'<' => Vector[-1, 0]}.freeze

class Grid
    def initialize(filename)
        @grid = []
        @commands = []
        mov = false 
        File.readlines(FILENAME,chomp:true).each_with_index do |line|
            if mov
                @commands.concat line.chars
                next
            end
            if line.strip.empty?
                mov=true
            else
                @grid << line.chars
            end
        end
    end

    def score
        result = 0
        @grid.each_with_index do |row, y|
            row.each_with_index do |cell, x|
                result += x + y * 100 if cell==BOX || cell==L_BOX
            end
        end
        result
    end

    def run
        robot=nil
        @grid.each_with_index do |row, y|
            row.each_with_index do |cell, x|
               if cell=='@'
                  robot=Vector[x,y]
                  break
                end
            end
            break unless robot.nil?
        end
        @commands.each {|c| robot = move(robot, robot + DIRS[c])}
    end


    def transform
        @grid=@grid.map do |row|
            row.flat_map do |cell|
                case cell
                    when '.' then ['.', '.']
                    when 'O' then ['[', ']']
                    when '#' then ['#', '#']
                    when '@' then ['@', '.']
                end
            end
        end
    end
      

    # moves from position a to b and return new position
    def move(a, b)
        obj = get_cell(a)
        case get_cell(b)
        when EMPTY
            set_cell(b, obj)
            set_cell(a, EMPTY)
            b
        when WALL
            a
        when BOX
            if b != move(b, b + (b - a)) 
                set_cell(b, obj)
                set_cell(a, EMPTY)
                b
            else
                a
            end
        else
            d = b - a
            if d == DIRS['<'] or d == DIRS['>']
                if b != move(b, b + d)
                    set_cell(b, obj)
                    set_cell(a, EMPTY)
                    b
                else
                    a
                end
            else 
                other_half =
                    if get_cell(b) == L_BOX
                        b + DIRS['>']
                    else
                        b + DIRS['<']
                    end
                if can_move?(b, b + d) and can_move?(other_half, other_half+d)
                    move(b, b + d)
                    move(other_half, other_half + d)
                    set_cell(a, EMPTY)
                    set_cell(b, obj)
                    set_cell(other_half, EMPTY)
                    b
                else
                    a
                end
            end
        end
    end
    
    # return true if can move from position a to position b
    def can_move?(a, b)
        case get_cell(b)
        when EMPTY
            true
        when WALL
            false
        else # LEFT_BOX, RIGHT_BOX
            d = b - a
            if d == DIRS['<'] or d == DIRS['>'] 
                can_move?(b, b + d)
            else
                other_half = get_cell(b) == L_BOX ? b + DIRS['>'] : b + DIRS['<']
                can_move?(b, b + d) and can_move?(other_half, other_half + d)
            end
        end
    end

    def set_cell(v, x) = @grid[v[1]][v[0]] = x
    def get_cell(v) = @grid[v[1]][v[0]]
end

end #module