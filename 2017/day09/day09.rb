total,score, removed = 0, 0,0
skip_next = false
in_garbage = false
ARGF.readline.chomp.each_char do |c| 
  if skip_next
      skip_next = false
      next
  end
  if c == '!'
    skip_next = true
  elsif in_garbage
    if c== '>' then 
      in_garbage = false
    else 
      removed+=1
    end
  elsif c == '{'
    score += 1
    total += score
  elsif c == '}'
    score -= 1
  elsif c == '<'
    in_garbage = true
  end    
end
puts total, removed
