instr_cycles = { 'addx' => 2, 'noop' => 1 }
x = [1]

File.readlines('input.txt').each do |line|
  instr, value = line.strip.split
  cycles = instr_cycles[instr]
  1.upto(cycles) do |c|
    x << (c == cycles ? x.last + value.to_i : x.last)
  end
end

signals = [20, 60, 100, 140, 180, 220].map { |i| x[i - 1] * i }
p "Part 1: #{signals.sum}"

p "Part 2:"
x.each_with_index do |s, i|
  pos = i % 40
  print ((s - 1..s + 1).to_a.include?(pos) ? '#' : ' ')
  print "\n" if pos == 39
end