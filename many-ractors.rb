require 'prime'

# Define the number of Ractors
num_ractors = 2000

# Define the limit up to which primes are calculated
prime_limit = 100_000_000

# Method to calculate primes using Sieve of Eratosthenes
def calculate_primes(limit)
  sieve = Array.new(limit + 1, true)
  sieve[0] = sieve[1] = false
  p = 2
  while p * p <= limit
    if sieve[p]
      (p * p).step(limit, p) { |i| sieve[i] = false }
    end
    p += 1
  end
  sieve.each_with_index.map { |is_prime, num| num if is_prime }.compact
end

ractors = num_ractors.times.map do
  Ractor.new() do
    Ractor.receive # Analog to Go's `<-ch`
  end

  Ractor.new(prime_limit) do |limit|
    calculate_primes(limit)
  end
end

# Collect results from Ractors
results = ractors.map(&:take)

# Optional: Output the results
results.each_with_index do |primes, index|
  puts "Ractor #{index + 1} calculated #{primes.size} primes up to #{prime_limit}"
end

# !!!!!!!!!!!!!! "To support blocking operations, more than N native threads can be used."
