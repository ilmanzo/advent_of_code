fn main() {
    println!("Part 1: {:?}", part1(9424));
    println!("Part 2: {:?}", part2(9424));
}

fn part1(serial: usize) -> (usize, usize) {
    let mut max = (0, 0, 0);
    for x in 0..297 {
        for y in 0..297 {
            let mut sum = 0;
            for i in x..x + 3 {
                for j in y..y + 3 {
                    sum += power(i + 1, j + 1, serial);
                }
            }
            if sum > max.0 {
                max = (sum, x + 1, y + 1);
            }
        }
    }
    (max.1, max.2)
}

fn part2(serial: usize) -> (usize, usize, usize) {
    let mut max = (0, 0, 0, 0);
    for dim in 1..=300 {
        for x in 0..300 - dim {
            for y in 0..300 - dim {
                let mut sum = 0;
                for i in x..x + dim {
                    for j in y..y + dim {
                        sum += power(i + 1, j + 1, serial);
                    }
                }
                if sum > max.0 {
                    max = (sum, x + 1, y + 1, dim);
                }
            }
        }
    }

    (max.1, max.2, max.3)
}

fn power(x: usize, y: usize, serial: usize) -> i32 {
    let rack = x + 10;
    let mut pl = rack * y + serial;
    pl *= rack;
    pl = (pl - (pl % 100)) / 100 % 10;
    pl as i32 - 5
}


