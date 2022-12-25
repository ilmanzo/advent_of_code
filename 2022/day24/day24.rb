require 'set'

DIRS = [ [1,0], [0,1], [-1,0], [0,-1], [0,0] ]
WRAP = [ [:min,:same], [:same, :min], [:max,:same], [:same,:max] ]
ARROW = [ '>', 'v', '<', '^']



def valid_moves(grid, pos)
    x,y = pos
    maxx, maxy = [grid[0].size-1, grid.size-1]
    valids = []
    DIRS.each do |d|
      nx,ny = x+d[0], y+d[1]
      next if nx < 0 || ny < 0 || nx > maxx || ny > maxy
      valids << [nx,ny] if grid[ny][nx].empty?
    end
    Set.new(valids)
  end
  


def step(grid)
    new_grid = Array.new(grid.size){ Array.new(grid[0].size){[]}}
    max = [new_grid[0].size - 2, new_grid.size - 2]
    
    grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        if cell == '#'
          new_grid[y][x] = '#'
          next
        end
  
        cell.each do |b|
          n = [x + DIRS[b][0], y + DIRS[b][1]]
          if grid[n[1]][n[0]] == '#'
            [0,1].each do |i|
              case WRAP[b][i]
              when :min then n[i] = 1
              when :max then n[i] = max[i]
              end
            end
          end 
          new_grid[n[1]][n[0]] << b
        end
      end
    end
    new_grid
  end

grid = File.open('input.txt', 'r').readlines.map do |line|
  line.strip.split('').map do |cell|
    if cell == '#'
      t = cell
    else
      t = []
      t << ARROW.index(cell) if ARROW.include? cell
    end
    t
  end
end

goal = [grid[0].size-2, grid.size-1]
pos = [[1,0]]

goals = [goal, [1,0], goal]

n = 0
while !goals.empty?
  grid = step(grid)
  newpos = Set.new
  pos.each {|p| newpos = newpos.union(valid_moves(grid, p))}
  
  if newpos.reduce(false){|v,p| v || p == goals[0]}
    puts "FOUND A WAY TO GOAL #{goals[0]}! (TURN #{n+1})"
    pos = [goals.shift]
    n += 1
    next
  end

  newpos.each do |np|
    x,y = np
    puts "WAIT A MINUTE, THERE'S AN OVERLAP" unless grid[y][x].empty?
  end

  pos = newpos
  n += 1
end


