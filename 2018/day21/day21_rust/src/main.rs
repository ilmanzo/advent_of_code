use std::collections::HashSet;

#[derive(Copy, Clone, Debug)]
struct Registers {
    ip: usize,
    registers: [usize; 6],
}

impl Registers {
    fn new() -> Registers {
        Registers {
            ip: 0,
            registers: [0; 6],
        }
    }
}

#[derive(Clone, Debug)]
struct Instruction {
    opcode: String,
    a: usize,
    b: usize,
    c: usize,
}

impl Instruction {
    fn new(s: &str) -> Instruction {
        let mut iter = s.split_whitespace();

        Instruction {
            opcode: iter.next().unwrap().into(),
            a: iter.next().unwrap().parse().unwrap(),
            b: iter.next().unwrap().parse().unwrap(),
            c: iter.next().unwrap().parse().unwrap(),
        }
    }
}

fn execute(inst: &Instruction, regs: &mut Registers) {
    let reg = &mut regs.registers;

    match inst.opcode.as_str() {
    "addr" => reg[inst.c] = reg[inst.a] + reg[inst.b],
    "addi" => reg[inst.c] = reg[inst.a] + inst.b,
    "mulr" => reg[inst.c] = reg[inst.a] * reg[inst.b],
    "muli" => reg[inst.c] = reg[inst.a] * inst.b,
    "banr" => reg[inst.c] = reg[inst.a] & reg[inst.b],
    "bani" => reg[inst.c] = reg[inst.a] & inst.b,
    "borr" => reg[inst.c] = reg[inst.a] | reg[inst.b],
    "bori" => reg[inst.c] = reg[inst.a] | inst.b,
    "setr" => reg[inst.c] = reg[inst.a],
    "seti" => reg[inst.c] = inst.a,
    "gtir" => reg[inst.c] = (inst.a > reg[inst.b]) as usize,
    "gtri" => reg[inst.c] = (reg[inst.a] > inst.b) as usize,
    "gtrr" => reg[inst.c] = (reg[inst.a] > reg[inst.b]) as usize,
    "eqir" => reg[inst.c] = (inst.a == reg[inst.b]) as usize,
    "eqri" => reg[inst.c] = (reg[inst.a] == inst.b) as usize,
    "eqrr" => reg[inst.c] = (reg[inst.a] == reg[inst.b]) as usize,
    _ => panic!("unkown instruction {}", inst.opcode.as_str()),
    }
}

fn parse_instructions() -> Vec<Instruction> 
{
    let input = include_str!("../../input.txt");
    let mut insts = Vec::new();
    for line in input.lines() {
        if !line.starts_with("#") {
            insts.push(Instruction::new(&line));
        }
    }
    insts
}


fn part1() {
    let mut reg = Registers::new();
    let insts = parse_instructions();
    let mut ip = 0;
    reg.ip=3;

    while ip < insts.len() {
        reg.registers[reg.ip] = ip;
        execute(&insts[reg.registers[reg.ip]], &mut reg);
        ip = reg.registers[reg.ip] + 1;

        if reg.registers[reg.ip] == 28 {
            break;
        }
    }

    println!("{}", reg.registers[1]);
}

fn part2() {
    let mut reg = Registers::new();
    let insts = parse_instructions();
    let mut ip = 0;
    let mut seen = HashSet::new();
    let mut last = 0;
    reg.ip=3;

    while ip < insts.len() {
        reg.registers[reg.ip] = ip;
        execute(&insts[reg.registers[reg.ip]], &mut reg);
        ip = reg.registers[reg.ip] + 1;

        if reg.registers[reg.ip] == 28 {
            if seen.get(&reg.registers[1]).is_some() {
                break;
            }

            seen.insert(reg.registers[1]);
            last = reg.registers[1];
        }
    }

    println!("{}", last);
}


fn main() {
    part1();
    part2();
}