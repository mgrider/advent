import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [Int] = contents.split(separator: "\n").map { Int($0) ?? 0 }

// 01.2
let start = Date()
loops: for i in input {
	for i2 in input {
		for i3 in input {
			if i + i2 + i3 == 2020 {
				print(i * i2 * i3)
				break loops
			}
		}
	}
}
let diff = String(format:"%.2f", -start.timeIntervalSinceNow)
print("Took \(diff) seconds")
//281473080
// 3 for loops: 0.55 seconds
// old way using .first
//Took 29.36 seconds

// 01.1
//for i in input {
//	if let i2 = input.first(where: {
//		i + $0 == 2020
//	}) {
//		print(i * i2)
//		break
//	}
//}

//func testB(i: Int, i2: Int, i3: Int) -> Bool {
//	if i + i2 + i3 == 2020 {
//		print("solution: \( i * i2 * i3 )")
//		return true
//	}
//	return false
//}
