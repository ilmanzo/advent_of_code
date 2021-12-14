alias Pair = Tuple(Char, Char)

class Day14
  def initialize(inputfile : String)
    @instructions = Hash(Pair, Char).new
    @template = [] of Char
    @counts = Hash(Pair, UInt64).new(0)
    File.each_line("../input.txt") do |line|
      line = line.chomp.strip
      next if line.size == 0
      if @template.size == 0
        @template = line.chars
      else
        pair, insertion = line.split(" -> ")
        @instructions[{pair[0], pair[1]}] = insertion[0]
      end
    end
    @template.each_cons_pair { |a, b| @counts[{a, b}] += 1 }
  end

  def print_result
    tmp = Hash(Char, UInt64).new(0)
    @counts.each { |k, v| tmp[k[0]] += v } # count only first char in pair
    tmp[@template[-1]] += 1
    p tmp.values.max - tmp.values.min
  end

  def step
    old = @counts.dup
    @counts = Hash(Pair, UInt64).new(0)
    old.each do |(a, b), v|
      found = @instructions[{a, b}]
      @counts[{a, found}] += v
      @counts[{found, b}] += v
    end
  end
end

d14 = Day14.new("../input.txt")

10.times { |s| d14.step }
d14.print_result
30.times { |s| d14.step }
d14.print_result
