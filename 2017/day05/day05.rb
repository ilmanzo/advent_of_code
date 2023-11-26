input = File.read("input.txt")
codep1 = input.strip.lines.map(&:to_i)
codep2=codep1.dup

pc = 0
steps = 0
while pc.between?(0, codep1.size-1)
  jump = codep1[pc]
  codep1[pc] += 1
  pc += jump
  steps += 1
end
p "part1=#{steps}"

pc = 0
steps = 0
while pc.between?(0, codep2.size-1)
  jump = codep2[pc]
  if jump >= 3
    codep2[pc] -= 1
  else
    codep2[pc] += 1
  end
  pc += jump
  steps += 1
end
p "part2=#{steps}"