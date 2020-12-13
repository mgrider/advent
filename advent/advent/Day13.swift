import Foundation

func Day13Part2(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day13_input.txt")
	let testInput = stringArray(fromMultilineString: """
939
7,13,x,x,59,x,31,19
""")
	let input = useTestInput ? testInput : fileInput

	var indexTimes = [Int: Int]()
	struct Bus {
		var index: Int
		var busId: Int
		var latestMultiple: Int
		var matches: Bool = false
	}
	var buses = [Bus]()

	var index = 0
	var largestBus = 0
	var largestBusIndex = 0
	for busId in input[1].split(separator: ",") {
		if busId == "x" {
			index += 1
			continue
		}

		let time = Int(busId) ?? 0
		if time > largestBus {
			largestBus = time
			largestBusIndex = index
		}
		buses.append(Bus(index: index, busId: time, latestMultiple: time))
		indexTimes[index] = time
		index += 1
	}

	index = 1
	var nextBigBus = largestBus
	var targetTime = 0
	while true {

		var allMatch = true
		for i in 0..<buses.count {
			targetTime = nextBigBus - largestBusIndex + buses[i].index
			while buses[i].latestMultiple < targetTime {
				buses[i].latestMultiple += buses[i].busId
			}
			if buses[i].latestMultiple == targetTime {
				buses[i].matches = true
			}
			else {
				buses[i].matches = false
				allMatch = false
			}
		}

		if allMatch {
			print("earliest timestamp is \(buses[0].latestMultiple)")
			return
		}

		index += 1
		nextBigBus = largestBus * index
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
