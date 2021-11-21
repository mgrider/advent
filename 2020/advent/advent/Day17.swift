import Foundation

func Day17Part1(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day17_input.txt")
	let testInput = stringArray(fromMultilineString: """
.#.
..#
###
""")
	let input = useTestInput ? testInput : fileInput

	var state = [[[Bool]]]()
	var grid = [[Bool]]()

	var currentCountX = input[0].count
	var currentCountY = input.count
	var currentCountZ = 1

	// pack initial state
	for line in input {
		var stateRow = [Bool]()
		for char in line {
			stateRow.append(char == Character("#"))
		}
		grid.append(stateRow)
	}
	state.append(grid)

	// simulate 6 times
	var neighbors = 0
	var tempState = [[[Bool]]]()
	for _ in 0..<6 {

		// first grow in every dimension
		for z in 0..<currentCountZ {
			// first x
			for y in 0..<currentCountY {
				state[z][y].insert(false, at: 0)
				state[z][y].append(false)
			}
			// y
			let emptyRow = Array(repeating: false, count: currentCountX + 2)
			state[z].insert(emptyRow, at: 0)
			state[z].append(emptyRow)
		}
		currentCountX += 2
		currentCountY += 2
		grid = [[Bool]]()
		for _ in 0..<currentCountY {
			grid.append(Array(repeating: false, count: currentCountX))
		}
		state.insert(grid, at: 0)
		state.append(grid)
		currentCountZ += 2

		// now simulate
		tempState = state
		for x in 0..<currentCountX {
			for y in 0..<currentCountY {
				for z in 0..<currentCountZ {

					neighbors = onNeighbors(checkX: x, checkY: y, checkZ: z, state: state)
					if state[z][y][x] {
						if neighbors != 2 && neighbors != 3 {
							tempState[z][y][x] = false
						}
					}
					else {
						if neighbors == 3 {
							tempState[z][y][x] = true
						}
					}
				}
			}
		}
		state = tempState
		printState(state: state)
	}

	let onStates = state.flatMap { $0 }.flatMap { $0 }.filter { $0 }.count
	print("on states count = \(onStates)")

}

func printState(state: [[[Bool]]]) {
	for z in 0..<state.count {
		print("\n")
		for y in 0..<state[0].count {
			var line = ""
			for x in 0..<state[0][0].count {
				if state[z][y][x] {
					line.append("#")
				} else {
					line.append(".")
				}
			}
			print(line)
		}
	}
}

func onNeighbors(checkX: Int, checkY: Int, checkZ: Int, state: [[[Bool]]]) -> Int {
	var num = 0
	var x = 0, y = 0, z = 0
	for xOffset in -1...1 {
		for yOffset in -1...1 {
			for zOffset in -1...1 {

				x = checkX + xOffset
				y = checkY + yOffset
				z = checkZ + zOffset

				if x == checkX && y == checkY && z == checkZ {
					continue
				}

				if x < 0 ||
					x >= state[checkZ][checkY].count ||
					y < 0 ||
					y >= state[checkZ].count ||
					z < 0 ||
					z >= state.count {
					continue
				}

				if state[z][y][x] {
					num += 1
				}
			}
		}
	}
	return num
}
