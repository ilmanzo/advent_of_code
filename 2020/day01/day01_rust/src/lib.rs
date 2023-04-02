pub fn part1_1(input: &[usize]) -> usize {
    for i in input {
        for j in input {
            if i+j==2020 { 
                return i*j;
            }
        }
    }
    0
}

pub fn part1_2(input: &[usize]) -> usize {
    for n in input {
        if input.contains(&(2020 - n)) {
            return n * (2020 - n);
        }
    }
    0
}

pub fn part1_3(input: &[usize]) -> usize {
    let mut seen = std::collections::HashSet::new();
    for n in input {
        if seen.contains(&(2020-n)) {
            return n * (2020 - n);
        }
        seen.insert(n);
    }
    0
}



pub fn part2(input: &[usize]) -> usize {
    for a in input {
        for b in input {
            for c in input {
                if a + b + c == 2020 {
                    return a * b * c;
                }
            }
        }
    }
    0
}

pub fn get_input() -> Vec<usize> {
    include_str!("../../input.txt")
    .lines()
    .map(|i| i.parse::<usize>().unwrap())
    .collect()
}
