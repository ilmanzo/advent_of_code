use std::ops::{Index, IndexMut};

#[derive(Debug, Clone)]
pub struct Grid {
    pub grid: Vec<Tile>,
    pub rows: usize,
    pub columns: usize,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Direction {
    Up,
    Down,
    Left,
    Right,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Tile {
    Path,
    Forest,
    Slope(Direction),
    Walked,
}

impl TryFrom<char> for Tile {
    type Error = ();

    fn try_from(value: char) -> Result<Self, Self::Error> {
        match value {
            '.' => Ok(Self::Path),
            '#' => Ok(Self::Forest),
            '^' => Ok(Self::Slope(Direction::Up)),
            'v' => Ok(Self::Slope(Direction::Down)),
            '<' => Ok(Self::Slope(Direction::Left)),
            '>' => Ok(Self::Slope(Direction::Right)),
            _ => Err(()),
        }
    }
}

impl Grid {
    pub fn from_input(input: &str) -> Self {
        let trimmed = input.trim();

        let rows = trimmed.lines().count();

        let first_line = trimmed.lines().next().unwrap();
        let columns = first_line.len();

        let mut grid = Vec::with_capacity(rows * columns);

        for line in trimmed.lines() {
            if line.len() != columns {
                panic!("not a grid")
            }

            grid.extend(line.chars().map(|c| Tile::try_from(c).unwrap()));
        }

        Grid {
            grid,
            rows,
            columns,
        }
    }

    #[allow(unused)]
    fn lines(&self) -> GridIterator {
        GridIterator {
            grid: self,
            current_row: 0,
        }
    }

    #[allow(unused)]
    fn get(&self, (x, y): (usize, usize)) -> Option<Tile> {
        if x < self.columns && y < self.rows {
            Some(self.grid[y * self.columns + x])
        } else {
            None
        }
    }

    #[allow(unused)]
    fn get_mut(&mut self, (x, y): (usize, usize)) -> Option<&mut Tile> {
        if x < self.columns && y < self.rows {
            Some(&mut self.grid[y * self.columns + x])
        } else {
            None
        }
    }
}

struct GridIterator<'a> {
    grid: &'a Grid,
    current_row: usize,
}

impl<'a> Iterator for GridIterator<'a> {
    type Item = &'a [Tile];

    fn next(&mut self) -> Option<Self::Item> {
        if self.current_row < self.grid.rows {
            let r = Some(&self.grid[self.current_row]);
            self.current_row += 1;
            r
        } else {
            None
        }
    }
}

impl Index<usize> for Grid {
    type Output = [Tile];

    fn index(&self, index: usize) -> &Self::Output {
        &self.grid[index * self.columns..index * self.columns + self.columns]
    }
}

impl IndexMut<usize> for Grid {
    fn index_mut(&mut self, index: usize) -> &mut Self::Output {
        &mut self.grid[index * self.columns..index * self.columns + self.columns]
    }
}
