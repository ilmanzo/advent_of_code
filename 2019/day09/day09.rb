def run(program,input)
  ip = 0
  rb = 0 # relative base
  loc = lambda {|i|
    case (program[ip]/10**(i+1))%10
    when 0
      program[ip+i]
    when 1
      ip+i
    when 2
      program[ip+i]+rb
    end
  }
  param = lambda {|i| program[loc[i]] || 0 }
  output = []
  while true
    case program[ip]%100
    when 1
      program[loc[3]] = param[1] + param[2]
      ip += 4
    when 2
      program[loc[3]] = param[1] * param[2]
      ip += 4
    when 3
      program[loc[1]] = input.pop
      ip += 2
    when 4
      output << param[1]
      ip += 2
    when 5
      ip = (param[1] != 0 ? param[2] : ip+3)
    when 6
      ip = (param[1] == 0 ? param[2] : ip+3)
    when 7
      program[loc[3]] = (param[1] < param[2] ? 1 : 0)
      ip += 4
    when 8
      program[loc[3]] = (param[1] == param[2] ? 1 : 0)
      ip += 4
    when 9
      rb += param[1]
      ip += 2
    when 99
      break
    end
  end
  output
end

program = open("input.txt").read.scan(/-?\d+/).map {|x| x.to_i}
puts run(program,[1])
puts run(program,[2])