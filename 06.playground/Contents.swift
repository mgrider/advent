import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [String] = contents.split(separator: "\n", omittingEmptySubsequences: false).map { String($0) }

let testInput = """
abc

a
b
c

ab
ac

a
a
a
a

b

""".split(separator: "\n", omittingEmptySubsequences: false).map { String($0) }

// -- part 2 --
var answers = Set<String>()
var groupAnswers = Set<String>()
var groupNegatives = Set<String>()
var total = 0

for line in input {
	if line.isEmpty {
		// new group
//		print("group answers: \(groupAnswers), negatives: \(groupNegatives)")
		for char in groupNegatives {
			groupAnswers.remove(char)
		}
		total += groupAnswers.count
		groupAnswers.removeAll()
		groupNegatives.removeAll()
	}
	if groupAnswers.isEmpty && groupNegatives.isEmpty {
		for char in line {
			groupAnswers.insert(String(char))
		}
	}
	else {
		answers.removeAll()
		for char in line {
			answers.insert(String(char))
		}
		groupNegatives.formUnion(answers.symmetricDifference(groupAnswers))
		groupAnswers = groupAnswers.intersection(answers)
	}
}

print("total is \(total)")


//// -- part 1 --
//var group = [String: Bool]()
//var total = 0
//
//for line in input {
//	if line.isEmpty {
//		print("group: \(group)")
//		total += group.keys.count
//		group = [String: Bool]()
//	}
//	for char in line {
//		group[String(char)] = true
//	}
//}
//
//print("total is \(total)")
