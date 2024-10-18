fn main() {
    println!("Part1={}",part1(512,191));
    println!("Part2={}",part2(512,191));
}

#[derive(Debug)]
struct Generator {
    current: usize,
    factor: usize,
}

impl Iterator for Generator {
    type Item = usize;
    fn next(&mut self) -> Option<Self::Item> {
        self.current = self.current * self.factor % 2147483647;
        Some(self.current)
    }
}

fn part1(a: usize, b: usize) -> usize {
    let gen_a = Generator{ current: a, factor: 16807 };
    let gen_b = Generator{ current: b, factor: 48271 };
    gen_a.zip(gen_b).take(40000000).filter(|&(a, b)| a & 0xffff == b & 0xffff).count()
}

fn part2(a: usize, b: usize) -> usize {
    let gen_a = Generator{ current: a, factor: 16807 };
    let gen_b = Generator{ current: b, factor: 48271 };
    gen_a.filter(|x| x % 4 == 0).zip(gen_b.filter(|x| x % 8 == 0)).take(5000000).filter(|&(a, b)| a & 0xffff == b & 0xffff).count()
}

