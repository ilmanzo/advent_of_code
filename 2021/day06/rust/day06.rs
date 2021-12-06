use std::fs;

fn simulate(input: Vec<usize>) {
    
    let mut ages: [usize; 9] = [0; 9];
    for i in input { ages[i] += 1; }

    for day in 0..257 {
        if day == 80 {
            let result: usize=ages.iter().sum();
            println!("{}",result);
        }
        if day == 256 {
            let result: usize=ages.iter().sum();
            println!("{}",result);
            break;
        }
        ages[(day + 7) % 9] += ages[day % 9];
    }
}

fn read_input(filename: &str) -> Vec<usize> {
    fs::read_to_string(filename)
        .expect("Error on reading input file")
        .split(',')
        .map(|n| n.parse::<usize>().unwrap())
        .collect()
}


fn main() {
    let input=read_input("../input.txt");
    simulate(input);
}
