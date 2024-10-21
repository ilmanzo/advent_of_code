players = File.read("input.txt").split("\n\n").map { |s| s.lines[1..].join.to_i }

loop {
  top = players.map(&:shift)
  (top[0] > top[1]) ? players[0] += top : players[1] += top.reverse
  if loser = players.find_index(&:empty?)
    p players[1 - loser].reverse.map.with_index { |c, ii| c * (ii + 1) }.sum
    exit
  end
}
