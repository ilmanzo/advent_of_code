#FILENAME = "input.txt"
FILENAME = "sample.txt"
input = File.read(FILENAME).split("\n\n")
patterns,towels = input[0].split(", "),input[1].split
def valid?(towel : String, patterns : Array(String))
  towel.empty? ? true : patterns.select { |p| towel.starts_with?(p) }.any? { |p| valid?(towel[p.size..], patterns) }
end
def ways(towel : String, patterns : Array(String), cache = {} of String => Int32)
  return 1 if towel.empty?
  return cache[towel] if cache.has_key?(towel)
  cache[towel]=patterns.select { |p| towel.starts_with?(p) }.sum { |p| ways(towel[p.size..], patterns, cache) }
end
puts towels.count { |towel| valid?(towel, patterns) }
puts towels.sum { |towel| ways(towel, patterns) }