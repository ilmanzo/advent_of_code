import utils,part1, part2


data=utils.get_input()
bin_data=utils.hex2bin(data)
part1.parse(bin_data)
print(part1.sumofversions)
print(part2.parse(bin_data))
