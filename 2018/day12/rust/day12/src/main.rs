fn main() {
    let (initial_state, rules) = parse();
    println!("Part1: {}", solve(&initial_state, &rules, 20));
    println!("Part2: {}", solve(&initial_state, &rules, 50_000_000_000));
}

fn parse() -> (Vec<u32>, Vec<u8>) {
    let input = include_str!("../../../input.txt");
    let mut lines = input.trim().lines();
    let first_line = lines.next().unwrap();
    let initial_state: Vec<_> = first_line[15..]
        .chars()
        .enumerate()
        .filter(|&(_i, c)| c == '#')
        .map(|(i, _c)| i as u32)
        .collect();
    assert!(lines.next().unwrap().is_empty());
    let rules = lines
        .filter(|line| line.chars().nth(9).unwrap() == '#')
        .map(|line| {
            line.chars().take(5).map(|c| c == '#').fold(0, |acc, b| {
                if b {
                    return acc * 2 + 1;
                }
                acc * 2
            })
        })
        .collect();
    (initial_state, rules)
}

fn solve(initial_state: &[u32], rules: &[u8], generations: usize) -> i64 {
    let mut prev_state: Vec<_> = initial_state.iter().map(|&x| x as i64).collect();
    let mut rules = rules.to_owned();
    rules.sort();
    for current_gen in 1..=generations {
        let mut new_state = vec![];
        let first_filled_pot = prev_state[0];
        let last_filled_pot = prev_state[prev_state.len() - 1];
        for pot_number in (first_filled_pot - 2)..=(last_filled_pot + 2) {
            let sequence = ((pot_number - 2)..=(pot_number + 2)).fold(0, |acc, i| {
                if i >= first_filled_pot
                    && i <= last_filled_pot
                    && prev_state.binary_search(&i).is_ok()
                {
                    return acc * 2 + 1;
                }
                acc * 2
            });
            if rules.binary_search(&sequence).is_ok() {
                new_state.push(pot_number);
            }
        }
        let prev_sum: i64 = prev_state.iter().sum();
        let new_sum: i64 = new_state.iter().sum();
        if prev_sum - (prev_state[0] * prev_state.len() as i64)
            == new_sum - (new_state[0] * new_state.len() as i64)
        {
            let generation_change = new_sum - prev_sum;
            return new_sum + generation_change * (generations - current_gen) as i64;
        }
        prev_state = new_state;
    }
    prev_state.iter().sum()
}
