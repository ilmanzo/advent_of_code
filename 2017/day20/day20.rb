particles = File.readlines("input.txt").map do |l|
  l.scan(/-?\d+/).map(&:to_i).each_slice(3).to_a
end

# Pick an arbitrary large time and hope it gives the right result?
T = 10000
# Simply comparing magnitudes is fraught with peril:
# p 0 0 0 v  1 0 0 a 1 0 0
# p 0 0 0 v -2 0 0 a 1 0 0
puts particles.each_with_index.min_by { |(p, v, a), _|
  p.zip(v, a).map { |p0, v0, a0| (p0 + v0 * T + a0 * T * T / 2).abs }.sum
}.last

GIVE_UP_AFTER = 50
cycles_since_last_collision = 0
last_size = particles.size

puts loop {
  particles.each { |p, v, a|
    [0, 1, 2].each { |x|
      v[x] += a[x]
      p[x] += v[x]
    }
  }
  particles = particles.group_by(&:first).select { |k, v|
    v.size == 1
  }.values.flatten(1)
  cycles_since_last_collision = 0 if particles.size != last_size
  break particles.size if (cycles_since_last_collision += 1) > GIVE_UP_AFTER
  last_size = particles.size
}

