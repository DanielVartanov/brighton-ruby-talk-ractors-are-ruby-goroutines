package main

import (
	"math"
)

func isPrime(n int) bool {
	if n <= 1 {
		return false
	}
	for i := 2; i <= int(math.Sqrt(float64(n))); i++ {
		if n%i == 0 {
			return false
		}
	}
	return true
}

func calculatePrimes() {
	num := 2
	for {
		if isPrime(num) {

		}
		num++
	}
}

func main() {
	ch := make(chan struct{})

	const tooMany = 1000;

	for i := 0; i < tooMany; i++ {
		go calculatePrimes()
		go func() { <-ch }()
	}

	// Wait indefinitely
	select {}
}
