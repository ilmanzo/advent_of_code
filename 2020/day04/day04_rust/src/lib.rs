use std::collections::HashMap;
use std::fs;

pub fn get_input(filepath: &str) -> String {
    fs::read_to_string(filepath).expect("can't open input file")
}

const REQUIRED_FIELDS: [&str; 7] = ["byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:"];
const VALID_EYE_COLORS: [&str; 7] = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];

// check all required fields are present
fn passport_valid1(passport: &str) -> bool {
    REQUIRED_FIELDS.iter().all(|field| passport.contains(field))
}

fn validate_field(key: &str, value: &str) -> bool {
    match key {
        "byr" => value.parse::<usize>().unwrap().wrapping_sub(1920) <= 82,
        "iyr" => value.parse::<usize>().unwrap().wrapping_sub(2010) <= 10,
        "eyr" => value.parse::<usize>().unwrap().wrapping_sub(2020) <= 10,
        "hgt" => {
            if value.ends_with("cm") && value.len() == 5 {
                value[0..3].parse::<usize>().unwrap().wrapping_sub(150) <= 43
            } else if value.ends_with("in") && value.len() == 4 {
                value[0..2].parse::<usize>().unwrap().wrapping_sub(59) <= 27
            } else {
                false
            }
        }
        "hcl" => value.len() == 7,
        "ecl" => VALID_EYE_COLORS.iter().any(|v| v == &value),
        "pid" => value.len() == 9,
        "cid" => true,
        _ => panic!("unknown field type"),
    }
}

// check fields value
fn passport_valid2(passport: &str) -> bool {
    let fields = passport
        .split_ascii_whitespace()
        .map(|field| field.split_once(':').unwrap())
        .collect::<HashMap<_, _>>();
    fields.iter().all(|(k, v)| validate_field(k, v))
}

pub fn part1(input: &str) -> usize {
    input.split("\n\n").filter(|p| passport_valid1(p)).count()
}

pub fn part2(input: &str) -> usize {
    input
        .split("\n\n")
        .filter(|p| passport_valid1(p) && passport_valid2(p))
        .count()
}
