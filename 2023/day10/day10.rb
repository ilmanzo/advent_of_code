#TODO: refactor 

# input=ARGF.readlines(chomp:true)
# start=nil
# neigh=Hash.new{|h,k| h[k]=[]}
# input.each_with_index do |row,i|
#   row.chars.each_with_index do |cell,j|
#     n=[]
#     case cell
#       when '|' then n=[[i-1,j],[i+1,j]]
#       when '-' then n=[[i,j-1],[i,j+1]]
#       when 'L' then n=[[i-1,j],[i,j+1]]
#       when 'J' then n=[[i-1,j],[i,j-1]]
#       when '7' then n=[[i+1,j],[i,j-1]]
#       when 'F' then n=[[i+1,j],[i,j+1]]
#       when 'S' then start=[i,j]
#     end
#     n.each do |(x,y)| 
#         neigh[[i,j]].append([x,y]) if x>=0 && x<row.length && y>=0 && y<input.length
#     end
#   end
# end

# start_neigh=[]
# neigh.keys.each do |n|
# 	neigh[n].each do |v|
# 		start_neigh << v if v==start 
# 	end
# end

# inf=input.length*input.length

# dst=Hash.new(inf)
# bfs_q=[]
# bfs_q.append start
# dst[start]=0
# ans=[0,start]
# while bfs_q.length > 0 do 
# 	curcell = bfs_q.shift
#     puts "curcell=#{curcell} dst=#{dst[curcell]}"
# 	neigh[curcell].each do  |nxt|
#         if dst[nxt] == INF then
#             dst[nxt] = dst[curcell] + 1
#             ans = [ans, [dst[nxt], nxt]].max
#             bfs_q.append nxt
# 		end
# 	end
# end

# p ans
