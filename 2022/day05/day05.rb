
def parse_crates(crates)
    stacks=Array.new(LINES) { [] }
    crates.lines.each do |line|
        next if not line.include? "["
        (0..LINES-1).each do |s|
            c=line[1+s*4]
            next if c==" "
            stacks[s].append(c)
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
    def initialize(crates,instructions)
        @stacks=parse_crates(crates)
        @instructions=parse_instructions(instructions)
    end
    def result
        @instructions.each do |n,from,to| 
            n.times do
                c=@stacks[from-1].shift
                @stacks[to-1].unshift c
            end
        end
        @stacks.map {|s| s[0]}.join ""
    end
end


class Part2
    def initialize(crates,instructions)
        @stacks=parse_crates(crates)
        @instructions=parse_instructions(instructions)
    end
    def result
        @instructions.each do |n,from,to| 
            c=@stacks[from-1].slice!(0,n)
            @stacks[to-1].insert(0,*c)
        end
        @stacks.map {|s| s[0]}.join ""
    end
end


LINES=9
crates,instructions = File.read("input.txt").split("\n\n")

#LINES=3
#crates,instructions = File.read("example.txt").split("\n\n")

p1=Part1.new crates,instructions
p "part1: #{p1.result}"

p2=Part2.new crates,instructions
p "part2: #{p2.result}"

