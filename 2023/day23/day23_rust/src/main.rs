use std::io::Read;

mod grid;
use grid::{Direction, Grid, Tile};

enum Part {
    One,
    Two,
}

fn solve(input: &str, part: Part) -> usize {
    let mut grid = Grid::from_input(input);

    let start_index = grid[0]
        .iter()
        .enumerate()
        .find(|&(_, &t)| t == Tile::Path)
        .unwrap()
        .0;

    grid[0][start_index] = Tile::Walked;

    let (x, y) = (start_index, 1usize);

    let mut result = Vec::new();
    match part {
        Part::One => walk1(&mut grid, (x, y), 1, &mut result),
        Part::Two => walk2(&mut grid, (x, y), 1, &mut result),
    }

    *result.iter().max().unwrap()
}

fn walk1(grid: &mut Grid, (x, y): (usize, usize), path: usize, paths: &mut Vec<usize>) {
    if y == grid.rows - 1 {
        paths.push(path);
        return;
    }

    // up
    match grid[y - 1][x] {
        Tile::Path | Tile::Slope(Direction::Up) => {
            let tile_before = grid[y - 1][x];
            grid[y - 1][x] = Tile::Walked;
            walk1(grid, (x, y - 1), path + 1, paths);
            grid[y - 1][x] = tile_before;
        }
        _ => {}
    }

    // down
    match grid[y + 1][x] {
        Tile::Path | Tile::Slope(Direction::Down) => {
            let tile_before = grid[y + 1][x];
            grid[y + 1][x] = Tile::Walked;
            walk1(grid, (x, y + 1), path + 1, paths);
            grid[y + 1][x] = tile_before;
        }
        _ => {}
    }

    // left
    match grid[y][x - 1] {
        Tile::Path | Tile::Slope(Direction::Left) => {
            let tile_before = grid[y][x - 1];
            grid[y][x - 1] = Tile::Walked;
            walk1(grid, (x - 1, y), path + 1, paths);
            grid[y][x - 1] = tile_before;
        }
        _ => {}
    }

    // right
    match grid[y][x + 1] {
        Tile::Path | Tile::Slope(Direction::Right) => {
            let tile_before = grid[y][x + 1];
            grid[y][x + 1] = Tile::Walked;
            walk1(grid, (x + 1, y), path + 1, paths);
            grid[y][x + 1] = tile_before;
        }
        _ => {}
    }
}

fn walk2(grid: &mut Grid, (x, y): (usize, usize), path: usize, paths: &mut Vec<usize>) {
    if y == grid.rows - 1 {
        paths.push(path);
        return;
    }

    // check up
    match grid[y - 1][x] {
        Tile::Path | Tile::Slope(_) => {
            let tile_before = grid[y - 1][x];
            grid[y - 1][x] = Tile::Walked;
            walk2(grid, (x, y - 1), path + 1, paths);
            grid[y - 1][x] = tile_before;
        }
        _ => {}
    }

    // check down
    match grid[y + 1][x] {
        Tile::Path | Tile::Slope(_) => {
            let tile_before = grid[y + 1][x];
            grid[y + 1][x] = Tile::Walked;
            walk2(grid, (x, y + 1), path + 1, paths);
            grid[y + 1][x] = tile_before;
        }
        _ => {}
    }

    // check left
    match grid[y][x - 1] {
        Tile::Path | Tile::Slope(_) => {
            let tile_before = grid[y][x - 1];
            grid[y][x - 1] = Tile::Walked;
            walk2(grid, (x - 1, y), path + 1, paths);
            grid[y][x - 1] = tile_before;
        }
        _ => {}
    }

    // check right
    match grid[y][x + 1] {
        Tile::Path | Tile::Slope(_) => {
            let tile_before = grid[y][x + 1];
            grid[y][x + 1] = Tile::Walked;
            walk2(grid, (x + 1, y), path + 1, paths);
            grid[y][x + 1] = tile_before;
        }
        _ => {}
    }
}

fn main() -> Result<(), std::io::Error> {
    let mut input = String::new();
    let _ = std::io::stdin().read_to_string(&mut input)?;

    println!("Part 1: {}", solve(&input, Part::One));
    println!("Part 2: {}", solve(&input, Part::Two));

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    const EXAMPLE: &str = "#.#####################
#.......#########...###
#######.#########.#.###
###.....#.>.>.###.#.###
###v#####.#v#.###.#.###
###.>...#.#.#.....#...#
###v###.#.#.#########.#
###...#.#.#.......#...#
#####.#.#.#######.#.###
#.....#.#.#.......#...#
#.#####.#.#.#########v#
#.#...#...#...###...>.#
#.#.#v#######v###.###v#
#...#.>.#...>.>.#.###.#
#####v#.#.###v#.#.###.#
#.....#...#...#.#.#...#
#.#########.###.#.#.###
#...###...#...#...#.###
###.###.#.###v#####v###
#...#...#.#.>.>.#.>.###
#.###.###.#.###.#.#v###
#.....###...###...#...#
#####################.#
";

    #[test]
    fn test_part1() {
        let expected = 94;
        let actual = solve(EXAMPLE, Part::One);

        assert_eq!(expected, actual);
    }

    #[test]
    fn test_part2() {
        let expected = 154;
        let actual = solve(EXAMPLE, Part::Two);

        assert_eq!(expected, actual);
    }
}
