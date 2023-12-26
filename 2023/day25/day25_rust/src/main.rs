use hashbrown::{HashMap, HashSet};
use itertools::Itertools;

fn main() {
    let input = include_str!("../../input.txt");
    //let input = include_str!("../../sample.txt");
    let mut graph = HashMap::<_, HashSet<_>>::new();
    let mut edges = HashSet::new();
    for l in input.split('\n') {
        let (a, rest) = l.split_once(": ").unwrap();
        for b in rest.split(' ') {
            graph.entry(a).or_default().insert(b);
            graph.entry(b).or_default().insert(a);
            edges.insert(if a < b { (a, b) } else { (b, a) });
        }
    }
    let mut dot = String::from("graph {\n");
    for (a, b) in edges.iter().sorted() {
        dot += &format!("  {} -- {};\n", a, b);
    }
    dot += "}";
    println!("Run '$dot -Tsvg -Kneato out.dot > out.svg' and find 3 edges");
    std::fs::write("out.dot", dot).unwrap();
    for (a, b) in [("tnr", "vzb"), ("krx", "lmg"), ("tqn", "tvf")] {
        graph.get_mut(a).unwrap().remove(b);
        graph.get_mut(b).unwrap().remove(a);
    }
    let size = component_size(&graph, "qqq");
    println!("Part1={}", (graph.len() - size) * size);
}

fn component_size(graph: &HashMap<&str, HashSet<&str>>, a: &str) -> usize {
    let (mut seen, mut s) = (HashSet::new(), vec![a]);
    while let Some(x) = s.pop() {
        if seen.insert(x) {
            s.extend(&graph[x]);
        }
    }
    seen.len()
}
