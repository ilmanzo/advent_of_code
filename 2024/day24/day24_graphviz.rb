v = ARGF.each_line
    .take_while { |line| !line.strip.empty? }
    .map { |line| line.strip.split(": ") }
    .to_h { |k, v| [k, v.to_i] }

Record = Struct.new(:arg1, :arg2, :res, :op)

puts "Digraph G {"
ARGF.each_line
    .take_while { |line| !line.strip.empty? }
    .map { |line| line.strip.split }
    .each do |src1, op, src2, _, dest|
        raise "Result already exists" if v.key?(dest)
        v[dest] = -1
        puts "#{src1} -> #{dest} [name = #{op}]"
        puts "#{src2} -> #{dest} [name = #{op}]"
    end
puts "}\n"

puts "paste this to https://dreampuf.github.io/GraphvizOnline/"
