import Foundation

func Day15Part1(useTestInput: Bool) {

	let fileInput = "11,0,1,10,5,19".split(separator: ",").map { Int($0) }
	let testInput = "0,3,6".split(separator: ",").map { Int($0) }
	var input = useTestInput ? testInput : fileInput

	var turnIndex = input.count - 1
	var lastNumber = input.last ?? 6

	while turnIndex < 2019 {

		var countdownIndex = turnIndex - 1
		var found = false
		while countdownIndex >= 0 {
			if input[countdownIndex] == lastNumber {
				lastNumber = turnIndex - countdownIndex
				found = true
				break
			}
			countdownIndex -= 1
		}
		if found {
			input.append(lastNumber)
		} else {
			lastNumber = 0
			input.append(0)
		}

		turnIndex += 1
	}

	print("last number spoken: \(input.last)")

}

func Day15Part2(useTestInput: Bool) {

	let fileInput = "11,0,1,10,5,19".split(separator: ",").map { Int($0) }
	let testInput = "0,3,6".split(separator: ",").map { Int($0) }
	let input = useTestInput ? testInput : fileInput

	var turnIndex = input.count - 1
	var lastNumber: Int = input[turnIndex]!

	var previousIndexes = [Int: Int]()
	for i in 0..<input.count {
		previousIndexes[input[i] ?? 0] = i
	}

	while turnIndex < 29999999 {
//	while turnIndex < 2019 {

		var nextLastNumber: Int
		if let pIndex = previousIndexes[lastNumber] {
			nextLastNumber = turnIndex - pIndex
		}
		else {
			nextLastNumber = 0
		}
		previousIndexes[lastNumber] = turnIndex

		turnIndex += 1
		lastNumber = nextLastNumber
	}

	print("last number spoken: \(lastNumber)")

}
