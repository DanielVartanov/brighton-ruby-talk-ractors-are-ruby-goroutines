




def calculate_primes
  sieve = [] << false << false
  p = 2
  loop do
    if sieve[p]
      (p * p).step(limit, p) { |i| sieve[i] = false }
    end
    p += 1
  end
  sieve.each_with_index.map { |is_prime, num| num if is_prime }.compact
end

Ractor.new { calculate_primes }
Ractor.new { calculate_primes }

sleep # Wait for Ractors forever
