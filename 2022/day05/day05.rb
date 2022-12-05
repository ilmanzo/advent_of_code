def parse_crates(crates)
    stacks=Array.new(LINES) { [] }
    crates.lines.each do |line|
        next if not line.include? "["
        (0..LINES-1).each do |s|
            c=line[1+s*4]
            stacks[s] << c if c!=" "
        end
    end
    stacks
end

def parse_instructions(instructions)
    instructions.lines.map do |line|
      line.scan(/move (\d+) from (\d+) to (\d+)/)[0].map(&:to_i)
    end
end

class Part1
    def initialize(crates)
        @stacks=parse_crates(crates)
    end
    def apply(instructions)
        instructions.each do |n,from,to| 
            n.times do
                c=@stacks[from-1].shift
                @stacks[to-1].unshift c
            end
        end
        @stacks.map {|s| s[0]}.join ""
    end
end


class Part2
    def initialize(crates)
        @stacks=parse_crates(crates)
    end
    def apply(instructions)
        instructions.each do |n,from,to| 
            c=@stacks[from-1].slice!(0,n)
            @stacks[to-1].insert(0,*c)
        end
        @stacks.map {|s| s[0]}.join ""
    end
end


LINES=9
crates,instr = File.read("input.txt").split("\n\n")
instructions=parse_instructions instr

#LINES=3
#crates,instructions = File.read("example.txt").split("\n\n")

p1=Part1.new crates
p "part1: #{p1.apply(instructions)}"

p2=Part2.new crates
p "part2: #{p2.apply(instructions)}"

