def part1(boxes, limit = 1000)
  parent = Hash.new { |h, k| h[k] = k }
  find = ->(x) { parent[x] == x ? x : parent[x] = find[parent[x]] }
  boxes.take(limit).each do |_, a, b|
    root_a, root_b = find[a], find[b]
    parent[root_a] = root_b if root_a != root_b
  end
  boxes.map(&find).tally.values.max(3).reduce(1, :*)
end

def part2(boxes)
  parent = Hash.new { |h, k| h[k] = k }
  find = ->(x) { parent[x] == x ? x : parent[x] = find[parent[x]] }
  clusters = boxes.size
  boxes.each do |_, a, b|
    root_a, root_b = find[a], find[b]
    next if root_a == root_b
    parent[root_a] = root_b
    clusters -= 1
    return a[0] * b[0] if clusters == 1
  end
end

boxes=readlines.map { |line| line.split(',').map(&:to_i) }.combination(2).map do |a, b|
  dist = Math.sqrt(a.zip(b).sum { |u, v| (u - v)**2 })
  [dist, a, b]
end.sort

p part1(boxes)
p part2(boxes)
