import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [String] = contents.split(separator: "\n").map { String($0) }

let testInput = """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
end +0
""".split(separator: "\n").map { String($0) }

let regex =  #"^(\w{3}) ([+|-])(\d{1,})$"#
var program = [(String, Int)]()

for str in input {
	var operation = ""
	var value = 0
	try! str.enumerateMatches(withPattern: regex) { matches in
		operation = matches[1]
		value = (matches[2] == "-") ? -Int(matches[3])! : Int(matches[3])!
		program.append((operation, value))
	}
}

//print("program: \(program)")

print("i goes to \(program.count)")

for i in 0..<program.count {
	var accumulator = 0
	var hasRun = [0: false]
	var index = 0
	var changed = false
	if program[i].0 == "jmp" {
		program[i].0 = "nop"
		changed = true
	}
	while true {
		if let has = hasRun[index], has == true {
//			print("\(i) : value before infinite loop = \(accumulator)")
			break
		}
		hasRun[index] = true
		switch program[index].0 {
		case "nop":
			index += 1
		case "jmp":
//			print("jmp \(program[index].1), new index is \(index)")
			index += program[index].1
		case "acc":
			accumulator += program[index].1
			index += 1
		case "end":
			print("it worked! val = \(accumulator)")
		default:
			print("should not get here.")
		}
	}
	if changed {
		program[i].0 = "jmp"
	}
}
