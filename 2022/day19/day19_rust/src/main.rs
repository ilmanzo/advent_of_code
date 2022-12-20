use hashbrown::HashSet;
use std::{collections::VecDeque, time::Duration};

#[derive(Clone, Copy, Debug)]
struct Blueprint {
    ore_ore_cost: i32,
    clay_ore_cost: i32,
    obs_ore_cost: i32,
    obs_clay_cost: i32,
    geo_ore_cost: i32,
    geo_obs_cost: i32,
}

//parse a blueprint from a string
impl From<&str> for Blueprint {
    fn from(s: &str) -> Self {
        let values: Vec<_> = s
            .split(|c: char| !c.is_ascii_digit())
            .filter(|w| !w.is_empty())
            .skip(1)
            .map(|w| w.parse::<i32>().unwrap())
            .collect();
        Self {
            ore_ore_cost: values[0],
            clay_ore_cost: values[1],
            obs_ore_cost: values[2],
            obs_clay_cost: values[3],
            geo_ore_cost: values[4],
            geo_obs_cost: values[5],
        }
    }
}

#[derive(Default, Hash, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Debug)]
struct State {
    ore: i32,
    ore_robots: i32,
    clay: i32,
    clay_robots: i32,
    obsidian: i32,
    obsidian_robots: i32,
    geode: i32,
    geode_robots: i32,
}

impl State {
    // updates a state values with tne next step
    fn next(&self) -> Self {
        State {
            ore: self.ore + self.ore_robots,
            clay: self.clay + self.clay_robots,
            obsidian: self.obsidian + self.obsidian_robots,
            geode: self.geode + self.geode_robots,
            ..*self
        }
    }
}

// use BFS to find out max geodes a blueprint can give
fn max_geodes(bp: &Blueprint, time: i32) -> i32 {
    let max_ore_cost = *[
        bp.ore_ore_cost,
        bp.clay_ore_cost,
        bp.obs_ore_cost,
        bp.geo_ore_cost,
    ]
    .iter()
    .max()
    .unwrap();
    let mut seen = HashSet::new();
    let mut queue = VecDeque::new();
    let initial_state = State {
        ore_robots: 1,
        ..Default::default()
    };
    queue.push_back((0, initial_state));
    let mut ans = 0;
    while let Some((len, state)) = queue.pop_front() {
        if len >= time {
            ans = std::cmp::max(ans, state.geode);
            continue;
        }
        if seen.contains(&state) {
            continue;
        }
        seen.insert(state);
        if state.ore_robots < max_ore_cost && state.ore >= bp.ore_ore_cost {
            let mut new_state = state.next();
            new_state.ore -= bp.ore_ore_cost;
            new_state.ore_robots += 1;
            queue.push_back((len + 1, new_state));
        }
        if state.clay_robots < bp.obs_clay_cost && state.ore >= bp.clay_ore_cost {
            let mut new_state = state.next();
            new_state.ore -= bp.clay_ore_cost;
            new_state.clay_robots += 1;
            queue.push_back((len + 1, new_state));
        }
        if state.obsidian_robots < bp.geo_obs_cost
            && state.ore >= bp.obs_ore_cost
            && state.clay >= bp.obs_clay_cost
        {
            let mut new_state = state.next();
            new_state.ore -= bp.obs_ore_cost;
            new_state.clay -= bp.obs_clay_cost;
            new_state.obsidian_robots += 1;
            queue.push_back((len + 1, new_state));
        }
        if state.ore >= bp.geo_ore_cost && state.obsidian >= bp.geo_obs_cost {
            let mut new_state = state.next();
            new_state.ore -= bp.geo_ore_cost;
            new_state.obsidian -= bp.geo_obs_cost;
            new_state.geode_robots += 1;
            queue.push_back((len + 1, new_state));
        } else {
            queue.push_back((len + 1, state.next()));
        }
    }
    ans
}

fn print_time(elapsed: Duration) {
    if elapsed.as_millis() > 0 {
        println!("Time: {}ms", elapsed.as_millis());
    } else {
        println!("Time: {}μs", elapsed.as_micros());
    }
}

fn main() {
    const INPUT: &str = include_str!("../../input.txt");
    let blueprints: Vec<Blueprint> = INPUT
        .trim_end()
        .lines()
        .map(|l| Blueprint::from(l))
        .collect();
    let now = ::std::time::Instant::now();
    let p1: i32 = blueprints
        .iter()
        .enumerate()
        .map(|(i, &b)| (i as i32 + 1) * max_geodes(&b, 24))
        .sum();
    let elapsed = now.elapsed();
    println!("Part1={p1}");
    print_time(elapsed);
    let now = ::std::time::Instant::now();
    let p2: i32 = blueprints
        .iter()
        .take(3)
        .map(|&b| max_geodes(&b, 32))
        .product();
    let elapsed = now.elapsed();
    println!("Part2={p2}");
    print_time(elapsed);
}
