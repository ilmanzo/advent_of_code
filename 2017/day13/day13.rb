def scan(height,time)
    offset=time % ((height-1)*2)
    offset>height-1 ? 2*(height-1)-offset : offset
end

input=ARGF.readlines(chomp:true).map { |line| line.split ': '}.to_h {|a,b| [a.to_i, b.to_i]}
#p input

part1=input.select{|t,h| scan(h,t)==0}.map{|k,v| k*v}.sum

p part1

