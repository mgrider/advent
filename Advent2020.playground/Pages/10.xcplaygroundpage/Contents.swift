import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [Int] = contents.split(separator: "\n").map { Int($0) ?? 0 }

let sorted = input.sorted()

let testInput = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
""".split(separator: "\n").map { Int($0) ?? 0 }
let testSorted = testInput.sorted()

// === part 2 ===

var countsForValues = [0: 1]
for adapter in sorted {
	var count = 0
	for i in 1...3 {
		if countsForValues[adapter - i] != nil {
			count += countsForValues[adapter - i]!
		}
	}
	countsForValues[adapter] = count
}
//print("counts for values: \(countsForValues)")
let total = countsForValues[sorted.last!]!

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



