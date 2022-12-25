const INPUT: &str = include_str!("../../input.txt");

fn main() {
    let sum = INPUT.trim_end().lines().map(|l| snafu_to_dec(l)).sum();
    println!("decimal sum = {} \nsnafu sum = {}", sum, dec_to_snafu(sum));
}

// TODO: implement proper traits to manage and display snafu numbers

// converts a snafu string into a decimal number
fn snafu_to_dec(l: &str) -> u64 {
    let mut result: i64 = 0;
    for ch in l.chars() {
        result *= 5;
        result += match ch {
            '0' => 0,
            '1' => 1,
            '2' => 2,
            '-' => -1,
            '=' => -2,
            _ => panic!("unexpected digit {}", ch),
        }
    }
    result as u64
}

// converts a decimal number into a string with snafu notation
fn dec_to_snafu(mut num: u64) -> String {
    let mut res = Vec::with_capacity(25);
    while num > 0 {
        let digit = (num % 5) as u32;
        match digit {
            0 => res.push('0'),
            1 => res.push('1'),
            2 => res.push('2'),
            3 => {
                res.push('=');
                num += 2;
            }
            4 => {
                res.push('-');
                num += 1;
            }
            _ => panic!("unexpected digit {}", digit),
        }
        num /= 5;
    }
    res.into_iter().rev().collect()
}
