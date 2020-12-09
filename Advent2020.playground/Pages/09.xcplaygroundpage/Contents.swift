import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [Int] = contents.split(separator: "\n").map { Int($0) ?? 0 }

var last25 = [Int]()

// === part 1 ===

//for latest in input {
//	var found = false
//	for i in last25 {
//		for i2 in last25 {
//			if i + i2 == latest {
//				found = true
//			}
//		}
//	}
//	if found == false {
//		print("found: \(latest)")
//	}
//	last25.append(latest)
//	if last25.count == 26 {
//		last25.remove(at: 0)
//	}
//}

// === part 2 ===

let finding = 15690279
var contiguous = [Int]()
var total = 0

func printFound() {
	print("\(contiguous)")
	var least = Int.max
	var most = 0
	for i in contiguous {
		if i < least {
			least = i
		}
		if i > most {
			most = i
		}
	}
	print("found! \(least) + \(most) = \(least + most)")
}

for latest in input {
	contiguous.append(latest)
	total = contiguous.reduce(0, +)
	if total == finding {
		printFound()
		break
	}
	else if total > finding {
		while total > finding {
			contiguous.remove(at: 0)
			total = contiguous.reduce(0, +)
			if total == finding {
				printFound()
			}
		}
	}
}
