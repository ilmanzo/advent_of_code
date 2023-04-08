use std::fs;

pub fn get_input(filepath: &str) -> String {
    fs::read_to_string(filepath).expect("can't open input file")
}

const REQUIRED_FIELDS: [&'static str; 7] = ["byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"];

fn passport_valid(passport: &str) -> bool {
    REQUIRED_FIELDS.iter().all(|field| passport.contains(field))
}

pub fn part1(input: &str) -> usize {
    let passports = input.split("\n\n");
    passports.filter(|p| passport_valid(p)).count()
}

pub fn part2(input: &str) -> usize {
    unimplemented!()
}
