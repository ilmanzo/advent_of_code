use criterion::{black_box, criterion_group, criterion_main, BenchmarkId, Criterion};
use day01::{get_input, part1_1, part1_2, part1_3};

/*
fn criterion_benchmark(c: &mut Criterion) {
    let input = get_input();
    c.bench_function("part1_1", |b| b.iter(|| part1_1(black_box(&input))));
    c.bench_function("part1_2", |b| b.iter(|| part1_2(black_box(&input))));
    c.bench_function("part1_3", |b| b.iter(|| part1_3(black_box(&input))));
    //c.bench_function("part2", |b| b.iter(|| part2(black_box(&input))));
}
 */

fn bench_part1(c: &mut Criterion) {
    let input = get_input();
    let mut group = c.benchmark_group("Day01");
    group.bench_function(BenchmarkId::new("first", "1"), |b| {
        b.iter(|| part1_1(black_box(&input)))
    });
    group.bench_function(BenchmarkId::new("second", "2"), |b| {
        b.iter(|| part1_2(black_box(&input)))
    });
    group.bench_function(BenchmarkId::new("third", "3"), |b| {
        b.iter(|| part1_3(black_box(&input)))
    });
}

criterion_group!(benches, bench_part1);
criterion_main!(benches);
