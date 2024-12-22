def mix(x, y) : Int64; x ^ y; end
def prune(x) : Int64; x % 16777216; end

def prices(x)
  result = [x]
  2000.times do
    x = prune(mix(x, 64 * x))
    x = prune(mix(x, x // 32))
    x = prune(mix(x, x * 2048))
    result << x
  end
  result
end

def scores(p, c)
  result = Hash(Array(Int64), Int64).new { |hash, key| hash[key] = 0 }
  (0..c.size - 4).each do |i|
    pattern = [c[i], c[i + 1], c[i + 2], c[i + 3]]
    result[pattern] = p[i + 4] unless result.has_key?(pattern)
  end
  result
end

FILENAME = "input.txt"
#FILENAME = "sample.txt"

part1 = 0_i64
score = Hash(Array(Int64), Int64).new { |hash, key| hash[key] = 0 }
File.read_lines(FILENAME, chomp:true).each do |line|
  p = prices(line.to_i64)
  part1 += p.last
  p = p.map { |x| x % 10 }
  changes = p.each_cons(2).map { |pair| pair[1]-pair[0] }.to_a
  scores(p, changes).each { |k, v| score[k] += v }
end

puts part1
puts score.values.max