use day04::{get_input, part1, part2};

fn main() {
    let input = get_input("../input.txt");
    let part1 = part1(&input);
    //let part2 = part2(&input);
    println!("Part1: {part1}");
    //println!("Part2: {part2}");
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn test_part1() {
        let input = get_input("../sample.txt");
        assert_eq!(part1(&input), 2);
    }
}
