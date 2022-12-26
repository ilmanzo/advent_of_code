use core::fmt;

const INPUT: &str = include_str!("../../input.txt");

fn main() {
    let sum: usize = INPUT
        .trim_end()
        .lines()
        .map(|l| Snafu::from(l))
        .map(|s| <usize>::from(s))
        .sum();
    println!("decimal sum = {} \nsnafu sum = {}", sum, Snafu::from(sum));
}

#[derive(Debug)]
struct Snafu(String);

impl fmt::Display for Snafu {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "SNAFU[{}]", self.0)
    }
}

impl From<&str> for Snafu {
    fn from(s: &str) -> Self {
        Snafu(String::from(s))
    }
}

impl From<usize> for Snafu {
    fn from(n: usize) -> Self {
        let mut num = n;
        let mut result = Vec::with_capacity(25);
        while num > 0 {
            let digit = (num % 5) as u32;
            match digit {
                0 => result.push('0'),
                1 => result.push('1'),
                2 => result.push('2'),
                3 => {
                    result.push('=');
                    num += 2;
                }
                4 => {
                    result.push('-');
                    num += 1;
                }
                _ => panic!("unexpected digit {}", digit),
            }
            num /= 5;
        }
        Self(result.into_iter().rev().collect())
    }
}

impl From<Snafu> for usize {
    fn from(s: Snafu) -> Self {
        let mut result: isize = 0;
        for ch in s.0.chars() {
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
        result as usize
    }
}
