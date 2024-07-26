def zeros(length)
  '0' * length
end

def mem_sum(mem)
  sum = 0
  mem.each_value do |mem_val|
      sum += mem_val.to_i(2)
  end
  return sum
end


def mem_binary(mask, mem_val)
  mem_val_bin = mem_val.to_i.to_s(2)
  zeros = zeros(mask.length - mem_val_bin.length - 1)
  return "#{zeros}#{mem_val_bin}"
end


def possible_bin_combinations(length)
    combinations = []
    for i in 0..2**length - 1 do
        combination = i.to_s(2)
        if combination.length < length
            combination = "#{zeros(length - combination.length)}#{combination}"
        end
        combinations << combination
    end
    return combinations
end

def apply_mask_p2(mask, target)
    result = zeros(mask.length - 1)
    mask.chars.each_with_index do |bit, i|
        if bit == '0'
            result[i] = target[i]
        elsif bit == '1'
            result[i] = '1'
        elsif bit == 'X'
            result[i] = 'X'
        end
    end
    return result
end

def apply_mask_p1(mask, target)
    result = zeros(mask.length - 1)
    mask.chars.each_with_index do |bit, i|
        if bit == 'X'
            result[i] = target[i]
        else
            result[i] = bit
        end
    end
    return result
end

def part_2(mask, mem, mem_pos, mem_val)
    mem_pos_bin = mem_binary(mask, mem_pos)
    mem_pos_result = apply_mask_p2(mask, mem_pos_bin)
    mem_val_bin = mem_binary(mask, mem_val)
    mem_pos_bin_comb = possible_bin_combinations(mem_pos_result.count('X'))
    mem_pos_bin_comb.each do |comb|
        mem_pos_mask = mem_pos_result.dup
        comb.chars.each do |num|
            x_pos = -1
            mem_pos_mask.chars.each_with_index do |bit, i|
                if bit == 'X'
                    x_pos = i
                    break
                end
            end
            mem_pos_mask[x_pos] = num
        end
        mem[mem_pos_mask] = mem_val_bin
    end
end


def solve_part1(input)
  mem = {}
  mask = ""
  input.each do |line|
      if line.start_with?("mask")
          mask = line[7..]
      else
          mem_pos, mem_val = line[4..].split("] = ")
          mem_val_bin = mem_binary(mask, mem_val)
          mem[mem_pos] = apply_mask_p1(mask, mem_val_bin)
      end
  end
  puts "Part1: #{mem_sum(mem)}"
end

def solve_part2(input)
  mem = {}
  mask = ""
  input.each do |line|
      if line.start_with?("mask")
          mask = line[7..]
      else
          mem_pos, mem_val = line[4..].split("] = ")
          part_2(mask, mem, mem_pos, mem_val)
      end
  end
  puts "Part2: #{mem_sum(mem)}"
end

input = IO.readlines('input.txt')

solve_part1(input)
solve_part2(input)