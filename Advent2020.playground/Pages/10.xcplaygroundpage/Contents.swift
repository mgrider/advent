import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [Int] = contents.split(separator: "\n").map { Int($0) ?? 0 }

let sorted = input.sorted()

let testSorted = """
16
10
15
5
1
11
7
19
6
12
4
""".split(separator: "\n").map { Int($0) ?? 0 }.sorted()

//var sets = Set<[Int]>()
//sets.insert(sorted)
//var current = [Int]()

var numberOfSets = [1]
var index = 0

for i in sorted {
	var number = 1
	// +1
	if sorted.count > index + 1 && sorted[index + 1] < i + 3 {
		number += 1
	}
	// +2
	if sorted.count > index + 2 && sorted[index + 2] < i + 3 {
		number += 1
	}
	// +3
	if sorted.count > index + 3 && sorted[index + 3] < i + 3 {
		number += 1
	}
	numberOfSets.append(number)
	index += 1
}
print(numberOfSets)
var total = 1
for i in numberOfSets {
	total = total * i
}

print("total = \(total)")



// === part 1 ===

//var ones = 0
//var threes = 0
//var current = 0
//var diff = 0
//
//for i in sorted {
//	diff = i - current
//	if diff == 1 {
//		ones += 1
//	}
//	else if diff == 3 {
//		threes += 1
//	}
//	current = i
//}
//print("ones \(ones) x threes \(threes + 1) == \(ones * (threes + 1))")



