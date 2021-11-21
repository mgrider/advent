import Foundation

func Day13Part2(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day13_input.txt")
	let testInput = stringArray(fromMultilineString: """
939
7,13,x,x,59,x,31,19
""")
	let input = useTestInput ? testInput : fileInput

	struct Bus {
		var index: Int
		var busId: Int
		var matches: Bool = false
	}
	var buses = [Bus]()

	var index = 0
	var largestBus = 0
	var largestBusIndex = 0
	var secondLargestBus = 0
	var secondLargestBusIndex = 0
	for busId in input[1].split(separator: ",") {
		if busId == "x" {
			index += 1
			continue
		}

		let time = Int(busId) ?? 0
		if time > largestBus {
			secondLargestBus = largestBus
			secondLargestBusIndex = largestBusIndex
			largestBus = time
			largestBusIndex = index
		} else if time > secondLargestBus {
			secondLargestBus = time
			secondLargestBusIndex = index
		}
		buses.append(Bus(index: index, busId: time))
		index += 1
	}

	let a = buses.map { $0.index }
	let n = buses.map { $0.busId }
	//let n = [3,5,7]
	//
	let x = crt(a,n)

	print(x)


	return

	// this code would probably have found it, but would have taken hours if not days
	index = 1
	var nextBigBus = largestBus
	var targetTime = 0
	while true {

		var allMatch = true
		targetTime = nextBigBus - largestBusIndex + secondLargestBusIndex
		if targetTime % secondLargestBus == 0 {
			for i in 0..<buses.count {
				targetTime = nextBigBus - largestBusIndex + buses[i].index
				if targetTime % buses[i].busId == 0 {
					buses[i].matches = true
				}
				else {
					buses[i].matches = false
					allMatch = false
				}
			}
			if allMatch {
				print("earliest timestamp is \(nextBigBus - largestBusIndex)")
				return
			}
		}

		index += 1
		nextBigBus += largestBus
	}
}

func Day13Part1(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day13_input.txt")
	let testInput = stringArray(fromMultilineString: """
939
7,13,x,x,59,x,31,19
""")
	let input = useTestInput ? testInput : fileInput

	let earliestDeparture = Int(input[0]) ?? 0
	var waitsByBusId = [Int: Int]()

	for busId in input[1].split(separator: ",") {

		if busId == "x" {
			continue
		}

		let time = Int(busId) ?? 1
		var totalTime = time
		while totalTime < earliestDeparture {
			totalTime += time
		}

		let wait = totalTime - earliestDeparture
		waitsByBusId[time] = wait
	}

	var shortestTime = Int.max
	var shortestBus = -1
	for (bus, time) in waitsByBusId {
		if time < shortestTime {
			shortestTime = time
			shortestBus = bus
		}
	}

	print("shortest wait \(shortestTime) for bus \(shortestBus) = \(shortestTime * shortestBus)")
}

// CRT lifted from https://rosettacode.org/wiki/Chinese_remainder_theorem#Swift

/*
 * Function: euclid
 * Usage: (r,s) = euclid(m,n)
 * --------------------------
 * The extended Euclidean algorithm subsequently performs
 * Euclidean divisions till the remainder is zero and then
 * returns the Bézout coefficients r and s.
 */

func euclid(_ m:Int, _ n:Int) -> (Int,Int) {
	if m % n == 0 {
		return (0,1)
	} else {
		let rs = euclid(n % m, m)
		let r = rs.1 - rs.0 * (n / m)
		let s = rs.0

		return (r,s)
	}
}

/*
 * Function: gcd
 * Usage: x = gcd(m,n)
 * -------------------
 * The greatest common divisor of two numbers a and b
 * is expressed by ax + by = gcd(a,b) where x and y are
 * the Bézout coefficients as determined by the extended
 * euclidean algorithm.
 */

func gcd(_ m:Int, _ n:Int) -> Int {
	let rs = euclid(m, n)
	return m * rs.0 + n * rs.1
}

func coprime(_ m:Int, _ n:Int) -> Bool {
	return gcd(m,n) == 1 ? true : false
}

//coprime(14,26)
//coprime(2,4)

/*
 * Function: crt
 * Usage: x = crt(a,n)
 * -------------------
 * The Chinese Remainder Theorem supposes that given the
 * integers n_1...n_k that are pairwise co-prime, then for
 * any sequence of integers a_1...a_k there exists an integer
 * x that solves the system of linear congruences:
 *
 *   x === a_1 (mod n_1)
 *   ...
 *   x === a_k (mod n_k)
 */

func crt(_ a_i:[Int], _ n_i:[Int]) -> Int {
	// There is no identity operator for elements of [Int].
	// The offset of the elements of an enumerated sequence
	// can be used instead, to determine if two elements of the same
	// array are the same.
	let divs = n_i.enumerated()

	// Check if elements of n_i are pairwise coprime divs.filter{ $0.0 < n.0 }
	divs.forEach{
		n in divs.filter{ $0.0 < n.0 }.forEach{
			assert(coprime(n.1, $0.1))
		}
	}

	// Calculate factor N
	let N = n_i.map{$0}.reduce(1, *)

	// Euclidean algorithm determines s_i (and r_i)
	var s:[Int] = []

	// Using euclidean algorithm to calculate r_i, s_i
	n_i.forEach{ s += [euclid($0, N / $0).1] }

	// Solve for x
	var x = 0
	a_i.enumerated().forEach{
		x += $0.1 * s[$0.0] * N / n_i[$0.0]
	}

	// Return minimal solution
	return x % N
}

//let a = [2,3,2]
//let n = [3,5,7]
//
//let x = crt(a,n)
//
//print(x)
