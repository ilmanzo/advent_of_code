input = File.read("input.txt").lines

instructions=input.first.chomp.chars
input_nodes=input.drop(2)

nodes = {}
input_nodes.each do |line|
  node, left, right = line.gsub(/[(]|[)]|,|=/, '').split
  nodes[node] = {'L'=> left, 'R'=> right}
end

def count_steps(nodes, instructions, start, &condition)
  current_node = start
  steps = 0
  loop do
    instructions.each do |instruction|
      return steps if condition.call(current_node)
      current_node = nodes[current_node][instruction]
      steps += 1
    end
  end
end

def part1(nodes, instructions)
  count_steps(nodes, instructions, 'AAA') { _1 == 'ZZZ' }
end

def part2(nodes, instructions)
  nodes.keys.filter { _1.end_with?('A') }.map do |node|
    count_steps(nodes, instructions, node) { _1.end_with?('Z') }
  end.reduce(&:lcm)
end

puts part1(nodes, instructions) 
puts part2(nodes, instructions) 