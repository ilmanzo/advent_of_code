use std::fs;

pub fn get_input(filepath: &str) -> String {
    fs::read_to_string(filepath).expect("can't open input file")
}

// get the 'value' of a seat given a string BFFFBBFRRR -> 567
fn seat_id(s: &str) -> usize {
    let mut seat = 0;
    let mut pow = 1;
    for c in s.chars().rev() {
        if c == 'B' || c == 'R' {
            seat += pow;
        }
        pow *= 2;
    }
    seat
}

pub fn part1(input: &str) -> usize {
    input.split('\n').map(seat_id).max().unwrap()
}

pub fn part2(input: &str) -> usize {
    let mut places = [false; 1024];
    for id in input.split('\n').map(seat_id) {
        places[id] = true;
    }
    for (id, seat) in places.iter().enumerate() {
        if !seat && id > 0 && places[id - 1] && places[id + 1] {
            return id;
        };
    }
    0
}
