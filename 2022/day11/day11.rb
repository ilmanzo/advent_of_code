
require 'pry'

MCM=2*3*5*7*11*13*17*19 # maximum common Monkey :) 

class Monkey
    attr_accessor :items
    attr_reader :count

    def initialize(items,op,divisor,monkey_a,monkey_b)
        @items,@op,@divisor,@monkey_a,@monkey_b=items,op,divisor,monkey_a,monkey_b
        @count=0
    end

    def inspect
        while @items.length>0
            @count+=1
            item=@items.shift
            item=@op.call(item) % MCM
            target=(item % @divisor)==0 ? @monkey_a : @monkey_b
            $monkeys[target].items << item 
        end
    end

    def to_s
        "count: #{@count} - items: #{@items} - op: #{@op}"
    end
end

# hardcoded input instead of parsing
def init_monkeys
    [
        Monkey.new([50, 70, 54, 83, 52, 78],         lambda{|x| x*3 }, 11, 2, 7),
        Monkey.new([71, 52, 58, 60, 71],             lambda{|x| x*x },  7, 0, 2),
        Monkey.new([66, 56, 56, 94, 60, 86, 73],     lambda{|x| x+1 },  3, 7, 5),
        Monkey.new([83, 99],                         lambda{|x| x+8 },  5, 6, 4),
        Monkey.new([98, 98, 79],                     lambda{|x| x+3 }, 17, 1, 0),
        Monkey.new([76,],                            lambda{|x| x+4 }, 13, 6, 3),
        Monkey.new([52, 51, 84, 54],                 lambda{|x| x*17}, 19, 4, 1),
        Monkey.new([82, 86, 91, 79, 94, 92, 59, 94] ,lambda{|x| x+7 },  2, 5, 3),
    ]
end


#part1
$monkeys=init_monkeys()
binding.pry
20.times { $monkeys.each { |m| m.inspect } }
counts=$monkeys.map{|m| m.count}.sort
p counts[-1]*counts[-2]

#part2
$monkeys=init_monkeys()
10000.times{ $monkeys.each { |m| m.inspect }}
counts=$monkeys.map{|m| m.count}.sort
p counts[-1]*counts[-2]
