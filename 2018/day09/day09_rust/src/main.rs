fn main() {
    println!("Part1={}", game(405, 71700));
    println!("Part2={}", game(405, 71700 * 100));
}

#[derive(Copy, Clone)]
struct Marble {
    value: usize,
    next: usize,
    prev: usize,
}

fn new_marble() -> Marble {
    Marble {
        value: 0,
        next: 0,
        prev: 0,
    }
}

fn game(nelves: usize, nmarbles: usize) -> usize {
    let mut marbles = Vec::with_capacity(nmarbles + 1);
    marbles.push(new_marble());
    let mut elves = vec![0; nelves];
    let mut current = 0;

    (1..=nmarbles)
        .zip((0..nelves).cycle())
        .for_each(|(value, e)| {
            if value % 23 == 0 {
                (0..7).for_each(|_| current = marbles[current].prev);
                let marble = marbles[current];
                marbles[marble.next].prev = marble.prev;
                marbles[marble.prev].next = marble.next;
                elves[e] += value + marble.value;
                current = marble.next;
            } else {
                current = marbles[current].next;
                let next = marbles[current].next;
                let prev = current;
                let index = marbles.len();
                marbles.push(Marble { value, next, prev });
                marbles[next].prev = index;
                marbles[prev].next = index;
                current = index;
            }
        });
    *elves.iter().max().unwrap()
}
