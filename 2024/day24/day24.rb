require 'set'

def evaluate(op, values, gates, cache = {})
  cache[op] ||= if values.key?(op)
    values[op]
  else
    op1, operator, op2 = gates[op]
    a, b = evaluate(op1, values, gates, cache), evaluate(op2, values, gates, cache)
    case operator
      when "AND" then a & b
      when "OR"  then a | b
      when "XOR" then a ^ b
      else raise "Unknown operation: #{operator}"
    end
  end
end

z_ops,values,gates = Set.new,{},{}
inputs,outputs=STDIN.read.split("\n\n").map {|blk| blk.strip.split("\n") }
inputs.map(&:split).each do |op,val|
    values[op[0..-2]] = val.to_i
    z_ops.add(op[0..-2]) if op.start_with?("z")
end
outputs.map(&:split).each do |op1,op,op2,x,out_op|
    gates[out_op] = [op1, op, op2]
    z_ops.add(out_op) if out_op.start_with?("z")
end
digits = {}
z_ops.each { |op| digits[op[1..-1].to_i] = evaluate(op,values,gates) }
puts digits.sort.reverse.reduce(0) { |acc, (_, bit)| (acc << 1) | bit }