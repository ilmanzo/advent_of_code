use std::{collections::HashMap, ops::Add};

fn main() {
    let path = "../input.txt";
    //let path = "../example.txt";
    let input = std::fs::read_to_string(path).unwrap();
    //let mut elves1 = parse_input(&input);
    println!("Part1={}", part1(&input));
    println!("Part2={}", part2(&input));
}

type Id = usize;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point(isize, isize);

impl Add for Point {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        Point(self.0 + rhs.0, self.1 + rhs.1)
    }
}

#[derive(Debug, Clone, Copy)]
enum Direction {
    North,
    South,
    West,
    East,
}

impl Direction {
    fn deltas_to_check(&self) -> [Point; 3] {
        match self {
            Direction::North => [Point(0, -1), Point(1, -1), Point(-1, -1)],
            Direction::South => [Point(0, 1), Point(1, 1), Point(-1, 1)],
            Direction::West => [Point(-1, 0), Point(-1, 1), Point(-1, -1)],
            Direction::East => [Point(1, 0), Point(1, 1), Point(1, -1)],
        }
    }

    fn new_point(&self, Point(x, y): Point) -> Point {
        match self {
            Direction::South => Point(x, y + 1),
            Direction::North => Point(x, y - 1),
            Direction::West => Point(x - 1, y),
            Direction::East => Point(x + 1, y),
        }
    }
}

struct Elf {
    id: usize,
    position: Point,
    directions: Vec<Direction>,
}

impl Elf {
    fn new(id: Id, position: Point) -> Self {
        Self {
            id,
            position,
            directions: vec![
                Direction::North,
                Direction::South,
                Direction::West,
                Direction::East,
            ],
        }
    }

    fn deltas_around(&self) -> [Point; 8] {
        [
            Point(0, 1),   // S
            Point(1, 1),   // SE
            Point(1, 0),   // E
            Point(1, -1),  // NE
            Point(0, -1),  // N
            Point(-1, -1), // NW
            Point(-1, 0),  // W
            Point(-1, 1),  // SW
        ]
    }

    fn any_elves_around(&self, elves: &[Elf]) -> bool {
        self.deltas_around().into_iter().any(|delta| {
            let new = self.position + delta;
            elves.iter().any(|elf| elf.position == new)
        })
    }

    fn propose(&self, elves: &[Elf], proposed: &mut HashMap<Point, Vec<Id>>) {
        if self.any_elves_around(elves) {
            for direction in &self.directions {
                if direction.deltas_to_check().into_iter().all(|delta| {
                    let new = self.position + delta;
                    elves.iter().all(|elf| elf.position != new)
                }) {
                    // can propose
                    let new = direction.new_point(self.position);
                    proposed.entry(new).or_default().push(self.id);
                    break;
                }
            }
        }
    }

    fn cycle_directions(&mut self) {
        let dir = self.directions.remove(0);
        self.directions.push(dir);
    }
}

fn part1(input: &str) -> usize {
    let mut elves = parse_input(input);
    for _round in 0..10 {
        // first half
        let mut proposed = HashMap::new();
        for elf in &elves {
            elf.propose(&elves, &mut proposed);
        }

        // second half
        for (point, elf_ids) in proposed {
            if let [elf_id] = elf_ids.as_slice() {
                elves[*elf_id].position = point
            };
        }
        for elf in &mut elves {
            elf.cycle_directions();
        }
    }
    // display_elves(&elves);
    let min_x = elves.iter().map(|elf| elf.position.0).min().unwrap();
    let max_x = elves.iter().map(|elf| elf.position.0).max().unwrap();
    let min_y = elves.iter().map(|elf| elf.position.1).min().unwrap();
    let max_y = elves.iter().map(|elf| elf.position.1).max().unwrap();

    let width = min_x.abs_diff(max_x) + 1;
    let length = min_y.abs_diff(max_y) + 1;
    let area = width * length;

    area - elves.len()
}

fn part2(input: &str) -> usize {
    let mut elves = parse_input(input);
    let mut round = 1;
    loop {
        // first half
        let mut proposed = HashMap::new();
        for elf in &elves {
            elf.propose(&elves, &mut proposed);
        }

        if proposed.is_empty() {
            break round;
        }

        // second half
        for (point, elf_ids) in proposed {
            if let [elf_id] = elf_ids.as_slice() {
                elves[*elf_id].position = point
            }
        }
        for elf in &mut elves {
            elf.cycle_directions();
        }
        round += 1;
    }
}

fn parse_input(input: &str) -> Vec<Elf> {
    let mut elves = Vec::new();
    let mut id = 0;
    for (y, row) in input.lines().enumerate() {
        for (x, tile) in row.chars().enumerate() {
            if tile == '#' {
                let elf = Elf::new(id, Point(x as isize, y as isize));
                elves.push(elf);
                id += 1;
            }
        }
    }
    elves
}

// used for debug

/* fn display_elves(elves: &HashMap<Id, Elf>) {
    let min_x = elves.values().map(|elf| elf.position.0).min().unwrap();
    let max_x = elves.values().map(|elf| elf.position.0).max().unwrap();
    let min_y = elves.values().map(|elf| elf.position.1).min().unwrap();
    let max_y = elves.values().map(|elf| elf.position.1).max().unwrap();

    for y in min_y..=max_y {
        for x in min_x..=max_x {
            if elves.values().any(|elf| elf.position == Point(x, y)) {
                print!("#");
            } else {
                print!(".");
            }
        }
        println!();
    }
}
 */
