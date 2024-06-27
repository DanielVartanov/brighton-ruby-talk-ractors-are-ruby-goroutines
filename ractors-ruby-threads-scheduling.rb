require 'etc'

def is_prime(n)
  return false if n <= 1
  (2..Math.sqrt(n).to_i).each do |i|
    return false if n % i == 0
  end
  true
end

def calculate_primes
  num = 2
  largest_prime = num
  loop do
    largest_prime = num if is_prime(num)
    num += 1
  end
end

def wait_for_input
  input = $stdin.gets
end

num_cores = Etc.nprocessors

threads = []

threads += num_cores.times.map do
  Thread.new { calculate_primes }
  Thread.new { wait_for_input }
end

# Wait for all threads
threads.each(&:join)
