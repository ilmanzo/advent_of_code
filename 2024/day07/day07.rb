def part1(result,nums)=recurse(result, 0, nums, concat:false)
def part2(result,nums)=recurse(result, 0, nums, concat:true)
    
def recurse(result, partial, nums, concat:)
  return false if partial > result
  return partial == result if nums.empty?
  head,tail = nums.first, nums[1..]
  recurse(result, partial + head, tail, concat:) ||
  recurse(result, partial * head, tail, concat:) ||
  (concat && recurse(result, (partial.to_s+head.to_s).to_i,tail, concat:))
end

FILENAME="sample.txt"
#FILENAME="input.txt"
input=File.read(FILENAME).lines.map {|l|l.sub!(':',' ').split.map(&:to_i)}
p input.sum{|result, *nums| part1(result, nums)? result : 0 }
p input.sum{|result, *nums| part2(result, nums)? result : 0 }