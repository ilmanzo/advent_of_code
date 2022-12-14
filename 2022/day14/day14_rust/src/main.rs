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
    fn init_from_input() -> Self {
        let input = fs::read_to_string("../input.txt").unwrap();
        let mut cave = Self {
            cells: [[Cell::Air; CAVE_SIZE]; CAVE_SIZE],
            lowest: 0,
        };
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
        cave
    }
}

fn split_on_comma(s: &str) -> Vec<usize> {
    s.split(',').map(|x| x.parse().unwrap()).collect()
}

fn part1() -> usize {
    let mut cave = Cave::init_from_input();
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

fn part2() -> usize {
    let mut cave = Cave::init_from_input();
    for i in 0..cave.cells.len() {
        cave.cells[i][cave.lowest + 2] = Cell::Rock;
    }
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
    println!("Part1: {}", part1());
    println!("Part2: {}", part2());
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn test_part1() {
        assert_eq!(part1(), 672);
    }
    #[test]
    fn test_part2() {
        assert_eq!(part2(), 26831);
    }
}
