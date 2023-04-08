use std::fs;

pub fn get_input(filepath: &str) -> String {
    fs::read_to_string(filepath).expect("can't open input file")
}

const TREE: u8 = 35;

fn count_tree_slopes(grid: &Vec<&[u8]>, dx: usize, dy: usize) -> usize {
    let width = grid[0].len();
    let mut trees = 0;
    let mut x: usize = 0;
    let mut y: usize = 0;
    while y < grid.len() {
        if grid[y][x] == TREE {
            trees += 1
        }
        x = (x + dx) % width;
        y += dy;
    }
    trees
}

pub fn part1(input: &str) -> usize {
    let grid: Vec<_> = input.lines().map(|l| l.as_bytes()).collect();
    count_tree_slopes(&grid, 3, 1)
}

pub fn part2(input: &str) -> usize {
    let grid: Vec<_> = input.lines().map(|l| l.as_bytes()).collect();
    [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        .iter()
        .map(|t| count_tree_slopes(&grid, t.0, t.1))
        .product()
}
