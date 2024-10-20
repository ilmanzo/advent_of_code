use lazy_static::lazy_static;
use regex::Regex;
use std::collections::HashSet;
use std::time::Instant;

#[derive(Debug)]
struct Bot {
	x: [i32; 3],
	r: i32,
}

fn parse(input: &str) -> Vec<Bot> {
	lazy_static! {
		static ref RE: Regex = Regex::new(r"(?m)^pos=<(-?\d+),(-?\d+),(-?\d+)>, r=(\d+)$").unwrap();
	}
	RE.captures_iter(input)
		.map(|c| Bot {
			x: [
				c[1].parse().unwrap(),
				c[2].parse().unwrap(),
				c[3].parse().unwrap(),
			],
			r: c[4].parse().unwrap(),
		})
		.collect()
}

fn solve(input: &str) -> usize {
	let bots = parse(&input);

	let mut max = 0;
	for (i, b) in bots.iter().enumerate() {
		if b.r > bots[max].r {
			max = i;
		}
	}
	bots.iter()
		.filter(|b| {
			b.x.iter()
				.zip(bots[max].x.iter())
				.map(|(&u, &v)| (u - v).abs())
				.sum::<i32>()
				<= bots[max].r
		})
		.count()
}

fn main() {
	let time = Instant::now();
	let input = include_str!("../../input.txt");
	println!("{}", solve(input));
	println!("{:?}", time.elapsed());
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn test_1() {
		let input = include_str!("../example.txt");
		assert_eq!(_solve1(&input), 7);
	}

	#[test]
	fn test_2() {
		let input = include_str!("../example2.txt");
		assert_eq!(_solve2(&input), 36);
	}
}