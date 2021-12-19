
def parse_input():    
    file_lines=open("../input.txt").read().splitlines()
    return [eval(line) for line in file_lines]


lines=parse_input()
print(lines)