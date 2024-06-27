




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

ractors_number = 1000 # Easily!

ractors_number.times do
  Ractor.new { calculate_primes }

  Ractor.new do
    Ractor.receive # Wait for a message
  end
end



sleep # Wait for Ractors forever
