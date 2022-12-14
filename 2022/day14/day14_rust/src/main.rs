use std::fs;

#[derive(Copy, Clone, Debug)]
enum Cell {
    Air,
    Sand,
    Rock,
}

const CAVE_SIZE: usize = 900;

#[derive(Copy, Clone, Debug)]
struct Cave {
    pub cells: [[Cell; CAVE_SIZE]; CAVE_SIZE],
    pub lowest: usize,
}

impl Cave {
    fn new() -> Self {
        Self {
            cells: [[Cell::Air; CAVE_SIZE]; CAVE_SIZE],
            lowest: 0,
        }
    }
}

fn split_on_comma(s: &str) -> Vec<usize> {
    s.split(',').map(|x| x.parse().unwrap()).collect()
}

fn part1(cave: &mut Cave) -> usize {
    let mut count = 0;
    loop {
        let mut x = 500;
        let mut y = 0;
        loop {
            if y > cave.lowest {
                return count;
            }
            if let Cell::Air = cave.cells[x][y + 1] {
                y += 1;
                continue;
            } else if let Cell::Air = cave.cells[x - 1][y + 1] {
                x -= 1;
                y += 1;
                continue;
            } else if let Cell::Air = cave.cells[x + 1][y + 1] {
                x += 1;
                y += 1;
                continue;
            }
            cave.cells[x][y] = Cell::Sand;
            count += 1;
            break;
        }
    }
}

fn part2(cave: &mut Cave) -> usize {
    for i in 0..cave.cells.len() {
        cave.cells[i][cave.lowest + 2] = Cell::Rock;
    }
    println!("lowest: {}", cave.lowest);
    let mut count = 0;

    loop {
        let mut x = 500;
        let mut y = 0;
        loop {
            if let Cell::Air = cave.cells[x][y + 1] {
                y += 1;
                continue;
            } else if let Cell::Air = cave.cells[x - 1][y + 1] {
                x -= 1;
                y += 1;
                continue;
            } else if let Cell::Air = cave.cells[x + 1][y + 1] {
                x += 1;
                y += 1;
                continue;
            } else if let Cell::Sand = cave.cells[x][y] {
                if y == 0 {
                    return count;
                }
            }
            cave.cells[x][y] = Cell::Sand;
            count += 1;
            break;
        }
    }
}

fn main() {
    let input = fs::read_to_string("../input.txt").unwrap();

    let mut cave = Cave::new();

    let lines: Vec<_> = input.lines().collect();

    for line in lines {
        let instructions: Vec<_> = line.split(" -> ").collect();
        for i in 0..instructions.len() - 1 {
            let p1 = split_on_comma(instructions[i]);
            let p2 = split_on_comma(instructions[i + 1]);
            for j in p1[0].min(p2[0])..=p1[0].max(p2[0]) {
                for k in p1[1].min(p2[1])..=p1[1].max(p2[1]) {
                    cave.cells[j][k] = Cell::Rock;
                }
            }
            if p1[1] > cave.lowest {
                cave.lowest = p1[1];
            }
            if p2[1] > cave.lowest {
                cave.lowest = p2[1];
            }
        }
    }
    // TODO: refactor to avoid cloning
    println!("Part1: {}", part1(&mut cave.clone()));
    println!("Part2: {}", part2(&mut cave.clone()));
}
