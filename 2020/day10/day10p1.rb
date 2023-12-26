input=ARGF.readlines(chomp:true).map(&:to_i).sort
deltas=input.each_cons(2).map{|a,b| b-a}.tally
p deltas[1]*deltas[3]


