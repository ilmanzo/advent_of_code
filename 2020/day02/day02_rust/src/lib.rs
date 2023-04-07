use regex::Regex;
use std::fs;

pub fn part1(input: &str) -> usize {
    let re = Regex::new(r"^(\d+)-(\d+) (.): (.+)$").unwrap();
    input
        .lines()
        .map(|p| re.captures(p).unwrap())
        .filter(|p| {
            let len = p[4].matches(&p[3]).count();
            len >= p[1].parse().unwrap() && len <= p[2].parse().unwrap()
        })
        .count()
}

pub fn part2(input: &str) -> usize {
    let re = Regex::new(r"^(\d+)-(\d+) (.): (.+)$").unwrap();
    input
        .lines()
        .map(|p| re.captures(p).unwrap())
        .filter(|x| {
            let pos1 = x[1].parse::<usize>().unwrap() - 1;
            let pos2 = x[2].parse::<usize>().unwrap() - 1;
            let chartofind = x[3].chars().next();
            let found1 = x[4].chars().nth(pos1) == chartofind;
            let found2 = x[4].chars().nth(pos2) == chartofind;
            found1 ^ found2
        })
        .count()
}

pub fn get_input(filepath: &str) -> String {
    let f = fs::read_to_string(filepath);
    f.expect("could not open input file")
}
