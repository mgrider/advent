import Foundation

func Day14Part2(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day14_input.txt")
	let testInput = stringArray(fromMultilineString: """
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
""")
	let input = useTestInput ? testInput : fileInput

	let memLineRegex = #"mem\[(\d{1,})\] = (\d{1,})"#

	var mask = ""
	var mem = [Int: Int]()

	for line in input {

		if line.hasPrefix("mask = ") {
			mask = line.replacingOccurrences(of: "mask = ", with: "")
			continue
		}

		try! line.enumerateMatches(withPattern: memLineRegex) { matches in

			let intValue = Int(matches[2]) ?? 0

			let memIndex = Int(matches[1]) ?? -1
			let binValue = String(memIndex, radix: 2).padLeft(totalWidth: mask.count, withString: "0")

			var indexes = [binValue]

			for i in 0..<mask.count {
				switch mask[i] {
				case "1"[0]:
					for (index, _) in indexes.enumerated() {
						indexes[index].replaceCharacterAt(index: i, with: "1")
					}
				case "X"[0]:
					var newIndexes = Array<String>()
					for (index, _) in indexes.enumerated() {
						var zIndex = indexes[index]
						zIndex.replaceCharacterAt(index: i, with: "0")
						var oIndex = indexes[index]
						oIndex.replaceCharacterAt(index: i, with: "1")
						newIndexes.append(zIndex)
						newIndexes.append(oIndex)
					}
					indexes = newIndexes
				default:
					break
				}
			}
			for index in indexes {
				let intIndex = strtol(index, nil, 2)
				mem[intIndex] = intValue
			}

//			print("mem[\(memIndex)] = (bin) \(binValue) (masked) \(binMem)")

		}

	}

	let total = mem.values.reduce(0, +)
	print("part 2 total is \(total)")
}

func Day14Part1(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day14_input.txt")
	let testInput = stringArray(fromMultilineString: """
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
""")
	let input = useTestInput ? testInput : fileInput

	let memLineRegex = #"mem\[(\d{1,})\] = (\d{1,})"#

	var mask = ""
	var mem = [Int: Int]()

	for line in input {

		if line.hasPrefix("mask = ") {
			mask = line.replacingOccurrences(of: "mask = ", with: "")
			continue
		}

		try! line.enumerateMatches(withPattern: memLineRegex) { matches in

			let memIndex = Int(matches[1]) ?? -1
			let intValue = Int(matches[2]) ?? 0
			let binValue = String(intValue, radix: 2).padLeft(totalWidth: mask.count, withString: "0")

			var binMem = mask

			for i in 0..<binMem.count {
				switch mask[i] {
				case "X"[0]:
					binMem.replaceCharacterAt(index: i, with: binValue[i])
				default:
					break
				}
			}
			mem[memIndex] = strtol(binMem, nil, 2)

//			print("mem[\(memIndex)] = (bin) \(binValue) (masked) \(binMem)")

		}

	}

	let total = mem.values.reduce(0, +)
	print("total is \(total)")
}
