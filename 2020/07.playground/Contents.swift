import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [String] = contents.split(separator: "\n").map { String($0) }

let exampleInput = """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
""".split(separator: "\n").map { String($0) }

let bagPattern = #"^([\w| ]*) bags contain (.*).$"#
let bagRegEx = try NSRegularExpression(pattern: bagPattern, options: [])

let subbagPattern = #"\s?(\d{1,}) ([\w| ]*) bag"#
let subbagRegEx = try NSRegularExpression(pattern: subbagPattern, options: [])

var bags = [String: [String: Int]]()

for str in input {
	let nsrange = NSRange(str.startIndex..<str.endIndex, in: str)
	bagRegEx.enumerateMatches(
		in: str,
		options: [],
		range: nsrange) { (match, _, stop) in
		guard let match = match else { return }

		if let r1 = Range(match.range(at: 1), in: str),
		   let r2 = Range(match.range(at: 2), in: str) {

			let bagKey = "\(str[r1])"
			let subBags = "\(str[r2])".split(separator: ",")

			var subBagDict = [String: Int]()
			for bag in subBags {

				let bagStr = String(bag)
				let bagrange = NSRange(bagStr.startIndex..<bagStr.endIndex, in: bagStr)
				subbagRegEx.enumerateMatches(
					in: bagStr,
					options: [],
					range: bagrange) { (bagmatch, _, stop) in
					guard let bagmatch = bagmatch else { return }

					if let r1 = Range(bagmatch.range(at: 1), in: bagStr),
					   let num = Int(bagStr[r1]),
					   let r2 = Range(bagmatch.range(at: 2), in: bagStr) {

						let subbagKey = bagStr[r2]
						subBagDict[String(subbagKey)] = num
					}
				}
			}

			bags[bagKey] = subBagDict

//			print("'\(bagKey)' can hold: '\(subBagDict)'")

		}
	}
}

// part 1

var canHoldGold = Set<String>()

func addBagsThatCanHold(type: String, canHoldGold: inout Set<String>, bags: [String: [String: Int]]) {
	for bagType in bags.keys {
		if let subbags = bags[bagType]?.keys {
			if subbags.contains(type) {
				canHoldGold.insert(bagType)
				addBagsThatCanHold(type: bagType, canHoldGold: &canHoldGold, bags: bags)
			}
		}
	}
}

addBagsThatCanHold(type: "shiny gold", canHoldGold: &canHoldGold, bags: bags)

print("can hold count: \(canHoldGold.count), - \(canHoldGold)")


// part 2

func numberOfBagsIn(
	type: String,
	bags: [String: [String: Int]]) -> Int {

	var numberOfBags = 0
	if let subbagsDict = bags[type] {
		for key in subbagsDict.keys {
			if let intVal = subbagsDict[key] {
				let bagsIn = numberOfBagsIn(type: key, bags: bags)
				numberOfBags += intVal + (intVal * bagsIn)
//				print("adding \(intVal) '\(key)' bags (x \(bagsIn)) to \(type)")
			}
		}
	}
	return numberOfBags
}

let bagsInGold = numberOfBagsIn(type: "shiny gold", bags: bags)
print("gold must hold \(bagsInGold) bags")

