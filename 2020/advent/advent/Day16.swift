import Foundation

struct Day16TicketRules {
	var name: String
	var range1: ClosedRange<Int>
	var range2: ClosedRange<Int>
	var ruleIndex: Int
	var ticketIndex: Int = -1
}

struct Day16Data {

	let rulesRegEx = #"([\w ]{1,}): (\d{1,})-(\d{1,}) or (\d{1,})-(\d{1,})"#

	var rules = [Day16TicketRules]()
	var myTicket = [Int]()
	var nearbyTickets = [[Int]]()

	init(useTestInput: Bool) {

		func parseRuleArray(ruleArray: [String]) {
			for i in 0..<ruleArray.count {
				try! ruleArray[i].enumerateMatches(withPattern: rulesRegEx) { matches in
					rules.append(Day16TicketRules(
						name: matches[1],
						range1: Int(matches[2])!...Int(matches[3])!,
						range2: Int(matches[4])!...Int(matches[5])!,
						ruleIndex: i
					))
				}
			}
		}

		if useTestInput {
			let testRules = stringArray(fromMultilineString: """
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50
""")
			parseRuleArray(ruleArray: testRules)
			myTicket = [7,1,14]
			let testTickets = stringArray(fromMultilineString: """
7,3,47
40,4,50
55,2,20
38,6,12
""")
			for ticket in testTickets {
				nearbyTickets.append(
					ticket.split(separator: ",").map { Int($0)! }
				)
			}
		}
		else {
			let inputRules = stringArray(fromMultilineString: """
departure location: 44-709 or 728-964
departure station: 42-259 or 269-974
departure platform: 39-690 or 701-954
departure track: 49-909 or 924-965
departure date: 48-759 or 779-957
departure time: 38-115 or 121-965
arrival location: 32-808 or 818-949
arrival station: 45-418 or 439-949
arrival platform: 35-877 or 894-962
arrival track: 26-866 or 872-958
class: 32-727 or 736-969
duration: 35-446 or 460-968
price: 26-545 or 571-961
route: 35-207 or 223-960
row: 43-156 or 165-955
seat: 26-172 or 181-966
train: 49-582 or 606-952
type: 36-279 or 303-968
wagon: 26-657 or 672-959
zone: 36-621 or 637-963
""")
			parseRuleArray(ruleArray: inputRules)
			myTicket = [83,127,131,137,113,73,139,101,67,53,107,103,59,149,109,61,79,71,97,89]
			let inputTickets = stringArray(fromFile: "Day16_input.txt")
			for ticket in inputTickets {
				nearbyTickets.append(
					ticket.split(separator: ",").map { Int($0)! }
				)
			}
		}

	}

}

func Day16Part1(useTestInput: Bool) {

	let data = Day16Data(useTestInput: useTestInput)

	var invalidValues = [Int]()

	for ticket in data.nearbyTickets {
		for value in ticket {
			var isValid = false
			for rule in data.rules {
				if rule.range1.contains(value) || rule.range2.contains(value) {
					isValid = true
					continue
				}
			}
			if !isValid {
				invalidValues.append(value)
			}
		}
	}
	let sum = invalidValues.reduce(0, +)
	print("invalid values \(invalidValues), sum = \(sum)")
}

func Day16Part2(useTestInput: Bool) {

	let data = Day16Data(useTestInput: useTestInput)

	var validTickets = [[Int]]()
	for ticket in data.nearbyTickets {
		var allValuesValid = true
		for value in ticket {
			var isValid = false
			for rule in data.rules {
				if rule.range1.contains(value) || rule.range2.contains(value) {
					isValid = true
					continue
				}
			}
			if !isValid {
				allValuesValid = false
			}
		}
		if allValuesValid {
			validTickets.append(ticket)
		}
	}

	let departureRules = data.rules.filter {
		$0.name.hasPrefix("departure")
	}

	var possibleIndexes = [Int: Set<Int>]()

	for i in 0..<data.rules.count {
		possibleIndexes[i] = Set<Int>()
		for ticketIndex in 0..<validTickets[0].count {
			var value: Int
			var allMatch = true
			for ticket in validTickets {
				value = ticket[ticketIndex]
				if data.rules[i].range1.contains(value) || data.rules[i].range2.contains(value) {
					continue
				}
				else {
					allMatch = false
					break
				}
			}
			if allMatch {
				possibleIndexes[i]!.insert(ticketIndex)
			}
		}
	}

	// [ruleIndex : ticketIndex]
	var foundRuleIndexes = [Int: Int]()

	while possibleIndexes.count > 0 {

		var ruleIndex = -1
		for i in possibleIndexes.keys {
			if possibleIndexes[i]!.count == 1 {
				ruleIndex = i
				break
			}
		}
		let value = possibleIndexes[ruleIndex]!.first!
		foundRuleIndexes[ruleIndex] = value
		possibleIndexes[ruleIndex] = nil
		for i in possibleIndexes.keys {
			possibleIndexes[i]!.remove(value)
		}
		print("ruleIndex = \(ruleIndex), possibleIndexes count = \(possibleIndexes.count)")
	}
	print("found rule indexes \(foundRuleIndexes)")

	var myTicketValues = [Int]()
	var departureIndex = 0
	for rule in departureRules {
		let ticketIndex = foundRuleIndexes[rule.ruleIndex]!
		myTicketValues.append(data.myTicket[ticketIndex])
		departureIndex += 1
	}

	let departureVal = myTicketValues.reduce(1, *)
	print("departure values multiplied: \(departureVal), ")

}
