import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [String] = contents.split(separator: "\n").map { String($0) }

func seatId(_ str: String) -> Int {
	let row = String(str[str.startIndex..<str.index(str.startIndex, offsetBy: 7)])
		.replacingOccurrences(of: "F", with: "0")
		.replacingOccurrences(of: "B", with: "1")
	let column = String(str[str.index(str.startIndex, offsetBy: 7)..<str.index(str.startIndex, offsetBy: 10)])
		.replacingOccurrences(of: "L", with: "0")
		.replacingOccurrences(of: "R", with: "1")

	let intRow = strtoul(row, nil, 2)
	let intCol = strtoul(column, nil, 2)

	print("row: \(row) (\(intRow)), column: \(column) (\(intCol))")

	return Int(intRow * 8 + intCol)
}


// --- part 2 ---
var seatIds = [Int]()
for line in input {
	seatIds.append(seatId(line))
}
seatIds.sort()
var firstMissing = 0
if let first = seatIds.first, let last = seatIds.last {
	for i in first...last {
		if !seatIds.contains(i) {
			print("missing seat is \(i)")
			break
		}
	}
}


// --- part 1 ----
//var largest = 0
//var current = 0
//for line in input {
//	current = seatId(line)
//	if current > largest {
//		largest = current
//	}
//}
//print("largest seatId = \(largest)")

//let sId = seatId("FBFBBFFRLR")

