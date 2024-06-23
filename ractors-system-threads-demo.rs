use std::thread;
use std::time::Duration;
use std::io::{self, Write};

fn is_prime(n: u64) -> bool {
    if n <= 1 {
        return false;
    }
    for i in 2..=((n as f64).sqrt() as u64) {
        if n % i == 0 {
            return false;
        }
    }
    true
}

fn calculate_primes() {
    let mut num = 2;
    loop {
        if is_prime(num) {

        }
        num += 1;
    }
}

fn wait_for_input() {
    loop {
        io::stdout().flush().unwrap();
        let mut input = String::new();
        io::stdin().read_line(&mut input).unwrap();
    }
}

fn main() {
    let cpu_cores_number = thread::available_parallelism().unwrap().get();

    for _ in 0..cpu_cores_number {
        thread::spawn(move || { calculate_primes(); });
        thread::spawn(move || { wait_for_input(); });
    }

    // Wait for all threads
    loop { thread::sleep(Duration::from_secs(60)); }
}
