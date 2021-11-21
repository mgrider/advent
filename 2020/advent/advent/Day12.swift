import Foundation


func Day12Part2(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day12_input.txt")

	let testInput = """
F10
N3
F7
R90
F11
""".split(separator: "\n").map { String($0) }

	let input = useTestInput ? testInput : fileInput

	var x = 0
	var y = 0
	var wx = 10
	var wy = 1

	for line in input {

		var instruction = line
		let prefix = String(instruction.remove(at: instruction.startIndex))
		guard let number = Int(instruction) else {
			print("couldn't find number in line \(line)")
			return
		}

		switch prefix {
		case "N":
			wy += number
		case "S":
			wy -= number
		case "E":
			wx += number
		case "W":
			wx -= number
		case "L":
			var left = number
			while left > 0 {
				let tempx = (-1 * wy)
				let tempy = wx
				wx = tempx
				wy = tempy
				left -= 90
			}
		case "R":
			var right = number
			while right > 0 {
				let tempy = (-1 * wx)
				let tempx = wy
				wy = tempy
				wx = tempx
				right -= 90
			}
		case "F":
			x += (wx * number)
			y += (wy * number)
		default:
			break
		}

	}

	let mx = abs(x)
	let my = abs(y)
	print("x= \(x), y= \(y), manhattan = \(mx + my)")



}


func Day12a(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day12_input.txt")

	let testInput = """
F10
N3
F7
R90
F11
""".split(separator: "\n").map { String($0) }

	let input = useTestInput ? testInput : fileInput

	var currentDirection: Direction = .east
	var x = 0
	var y = 0

	for line in input {

		var instruction = line
		let prefix = String(instruction.remove(at: instruction.startIndex))
		guard let number = Int(instruction) else {
			print("couldn't find number in line \(line)")
			return
		}

		switch prefix {
		case "N":
			y += number
		case "S":
			y -= number
		case "E":
			x += number
		case "W":
			x -= number
		case "L":
			var left = number
			while left > 0 {
				currentDirection = currentDirection.leftRotation()
				left -= 90
			}
		case "R":
			var right = number
			while right > 0 {
				currentDirection = currentDirection.rightRotation()
				right -= 90
			}
		case "F":
			switch currentDirection {
			case .north:
				y += number
			case .south:
				y -= number
			case .east:
				x += number
			case .west:
				x -= number
			}
		default:
			break
		}

	}

	let mx = abs(x)
	let my = abs(y)
	print("x= \(x), y= \(y), manhattan = \(mx + my)")

}


enum Direction: String {
	case north = "N"
	case south = "S"
	case east = "E"
	case west = "W"
	func leftRotation() -> Direction {
		switch self {
		case .north:
			return .west
		case .south:
			return .east
		case .east:
			return .north
		case .west:
			return .south
		}
	}
	func rightRotation() -> Direction {
		switch self {
		case .north:
			return .east
		case .south:
			return .west
		case .east:
			return .south
		case .west:
			return .north
		}
	}
}

