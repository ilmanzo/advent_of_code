struct Elfrecipe {
    recipes: Vec<usize>,
    elf1: usize,
    elf2: usize,
}

impl Elfrecipe {
    fn new() -> Self {
        Elfrecipe {
            recipes: vec![3, 7],
            elf1: 0,
            elf2: 1,
        }
    }
    fn advance(&mut self) {
        let s = self.recipes[self.elf1] + self.recipes[self.elf2];
        if s >= 10 {
            self.recipes.push(s / 10);
        }
        self.recipes.push(s % 10);
        self.elf1 = (self.elf1 + self.recipes[self.elf1] + 1) % self.recipes.len();
        self.elf2 = (self.elf2 + self.recipes[self.elf2] + 1) % self.recipes.len();
    }
    fn len(&self) -> usize {
        self.recipes.len()
    }
    fn recipes(&self, a: usize, b: usize) -> &[usize] {
        &self.recipes[a..b]
    }
}

fn part1(num: usize) {
    let mut r = Elfrecipe::new();

    while r.len() < num + 10 {
        r.advance();
    }

    println!("Part1: {:?}", r.recipes(num, num + 10));
}

fn part2() {
    let mut r = Elfrecipe::new();
    let sequence = &[9, 0, 9, 4, 4, 1];
    const S_LEN: usize = 6;

    loop {
        r.advance();
        if r.len() > S_LEN + 1 && (r.recipes(r.len() - 1 - S_LEN, r.len() - 1) == sequence) {
            println!("Part2: {}", r.len() - 1 - S_LEN);
            break;
        }
    }
}

fn main() {
    part1(909441);
    part2();
}
