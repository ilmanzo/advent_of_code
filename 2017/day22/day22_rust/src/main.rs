use std::collections::HashMap;

#[derive(Clone)]
enum State {
    Clean,
    Infected,
    Weakened,
    Flagged,
}

fn part(grid: &[(i32, i32)], pos: &(i32, i32), n: usize, step2: bool) -> usize {
    use State::*;
    let mut state = grid
        .iter()
        .map(|&(r, c)| ((r, c), Infected))
        .collect::<HashMap<_, _>>();
    let mut pos = *pos;
    let mut dir = (-1, 0);
    let mut infect_count = 0;
    for _ in 0..n {
        let e = state.entry(pos).or_insert(Clean);
        match e.clone() {
            Infected => {
                dir = (dir.1, -dir.0);
                *e = if step2 { Flagged } else { Clean }
            }
            Flagged => {
                dir = (-dir.0, -dir.1);
                *e = Clean;
            }
            Weakened => {
                *e = Infected;
                infect_count += 1;
            }
            Clean => {
                dir = (-dir.1, dir.0);
                *e = if step2 {
                    Weakened
                } else {
                    infect_count += 1;
                    Infected
                }
            }
        }
        pos = (pos.0 + dir.0, pos.1 + dir.1);
    }
    infect_count
}

fn main() {
    let input = include_str!("../../input.txt");
    let width = input.chars().position(|c| c == '\n').unwrap();
    let height = input.len() / (width + 1);
    let start = ((height / 2) as i32, (width / 2) as i32);
    let grid = input
        .lines()
        .enumerate()
        .flat_map(|(r, line)| {
            line.chars().enumerate().filter_map(move |(c, ch)| {
                if ch == '#' {
                    Some((r as i32, c as i32))
                } else {
                    None
                }
            })
        })
        .collect::<Vec<(i32, i32)>>();
    println!("Part 1: {}", part(&grid, &start, 10_000, false));
    println!("Part 2: {}", part(&grid, &start, 10_000_000, true));
}