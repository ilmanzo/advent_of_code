use std::str::FromStr;

const INPUT: &str = include_str!("../../input.txt");

fn main() {
    // iterate over each submap
    let mut part1 = 0;
    let mut part2 = 0;
    for ascii_map in INPUT.split("\n\n") {
        let map = ascii_map.parse::<Map>().unwrap();
        let p1=map.score(1);
        let p2=map.score(2);
        part1+=p1;
        part2+=p2;
        println!("P1={p1}, P2={p2}");
    }
    println!("Part1={part1}, Part2={part2}");
}

struct Map {
    rock_pos: Vec<usize>,
    cols: usize,
    rows: usize,
}

impl Map {
    // part 1, part 2
    fn score(&self, part: usize) -> usize {
        let mut perfect_reflection_score = 0;
        let mut off_by_one_reflection_score = 0;

        let (perfect, off_by_one) = self.find_h_reflection();
        perfect_reflection_score += perfect.map(|x| x * 100).unwrap_or(0);
        off_by_one_reflection_score += off_by_one.map(|x| x * 100).unwrap_or(0);

        let (perfect, off_by_one) = self.find_v_reflection();
        perfect_reflection_score += perfect.unwrap_or(0);
        off_by_one_reflection_score += off_by_one.unwrap_or(0);

        match part {
            1 => perfect_reflection_score,
            2 => off_by_one_reflection_score,
            _ => panic!("only part 1 or 2"),
        }
    }

    // (line of reflection, line of reflection that's off by one)
    fn find_v_reflection(&self) -> (Option<usize>, Option<usize>) {
        let mut actual_reflection = None;
        let mut off_by_one_reflection = None;

        for before_this_col in 1..self.cols {
            let right_align_offset = (before_this_col > self.cols / 2)
                .then(|| self.cols - 2 * (self.cols - before_this_col));

            let before_cols = if let Some(right_align_offset) = right_align_offset {
                right_align_offset..before_this_col
            } else {
                0..before_this_col
            };

            let after_cols = if right_align_offset.is_some() {
                before_this_col..self.cols
            } else {
                before_this_col..(2 * before_this_col)
            };

            let misreflections = before_cols
                .zip(after_cols.rev())
                .map(|(col_a, col_b)| {
                    (0..self.rows)
                        .filter(|r| self.at(*r, col_a) != self.at(*r, col_b))
                        .count()
                })
                .sum();

            match misreflections {
                0 => actual_reflection = Some(before_this_col),
                1 => off_by_one_reflection = Some(before_this_col),
                _ => {}
            }

            if actual_reflection.is_some() && off_by_one_reflection.is_some() {
                break;
            }
        }

        (actual_reflection, off_by_one_reflection)
    }

    fn find_h_reflection(&self) -> (Option<usize>, Option<usize>) {
        let mut actual_reflection = None;
        let mut off_by_one_reflection = None;

        for before_this_row in 1..self.rows {
            let bottom_align_offset = (before_this_row > self.rows / 2)
                .then(|| self.rows - 2 * (self.rows - before_this_row));

            let before_rows = if let Some(bottom_align_offset) = bottom_align_offset {
                bottom_align_offset..before_this_row
            } else {
                0..before_this_row
            };

            let after_rows = if bottom_align_offset.is_some() {
                before_this_row..self.rows
            } else {
                before_this_row..(2 * before_this_row)
            };
            let misreflections = before_rows
                .zip(after_rows.rev())
                .map(|(row_a, row_b)| {
                    (0..self.cols)
                        .filter(|c| self.at(row_a, *c) != self.at(row_b, *c))
                        .count()
                })
                .sum();
            match misreflections {
                0 => actual_reflection = Some(before_this_row),
                1 => off_by_one_reflection = Some(before_this_row),
                _ => {}
            }

            if actual_reflection.is_some() && off_by_one_reflection.is_some() {
                break;
            }
        }

        (actual_reflection, off_by_one_reflection)
    }

    fn at(&self, row: usize, col: usize) -> bool {
        self.rock_pos
            .binary_search(&(row * self.cols + col))
            .is_ok()
    }
}
impl FromStr for Map {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let cols = s.find('\n').unwrap();
        let rows = s.lines().count();
        let rock_pos = s
            .lines()
            .enumerate()
            .map(|(row, line)| {
                line.chars()
                    .enumerate()
                    .filter_map(move |(col, char)| match char {
                        '#' => Some(row * cols + col),
                        _ => None,
                    })
            })
            .flatten()
            .collect::<Vec<_>>();

        Ok(Self {
            rock_pos,
            cols,
            rows,
        })
    }
}
