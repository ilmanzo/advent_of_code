require_relative './day15'
include Day15

FILENAME="input.txt"
#FILENAME="sample.txt"
grid=Grid.new FILENAME
grid.run
p grid.score