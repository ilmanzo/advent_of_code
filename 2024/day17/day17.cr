def decode(a : Int64, b : Int64, c : Int64, val : Int64) : Int64
  case val
    when 0, 1, 2, 3 then val
    when 4 then a
    when 5 then b
    when 6 then c
    else -1_i64
  end
end

def run_program(a : Int64, b : Int64, c : Int64, prog : Array(Int64))
  output = [] of Int64
  i = 0
  while i < prog.size
    next_i = i + 2
    opcode, operand = prog[i], prog[i + 1]
    case opcode
    when 0 then a = (a / (2 ** decode(a, b, c, operand))).to_i64
    when 1 then b = b ^ operand
    when 2 then b = decode(a, b, c, operand) % 8_i64
    when 3 then next_i = operand if a != 0
    when 4 then b = b ^ c
    when 5 then output << decode(a, b, c, operand) % 8_i64
    when 6 then b = (a / (2 ** decode(a, b, c, operand))).to_i64
    when 7 then c = (a / (2 ** decode(a, b, c, operand))).to_i64
    end
    i = next_i
  end
  output
end

FILENAME = "input.txt"
#FILENAME = "sample.txt"
input = File.read_lines(FILENAME)
a = input[0].split(": ")[1].to_i
b = input[1].split(": ")[1].to_i
c = input[2].split(": ")[1].to_i
prog = input[4].split(": ")[1].split(",").map(&.to_i64)
#part1 = run_program(a, b, c, prog)
#puts part1
todo = [{prog, prog.size-1, 0}]
while todo.size > 0
  prog, off, val = todo.shift
  puts "STEP prog=#{prog} off=#{off} val=#{val}"
  (0..8).each do |cur|
    next_val = (val << 3) + cur
    if run_program(next_val, 0, 0, prog) == prog[off..]
      #puts "prog=#{new_program} next_val=#{next_val} off=#{off}"
      break if off==0
      todo << {prog, off - 1, next_val}
    end
  end
end