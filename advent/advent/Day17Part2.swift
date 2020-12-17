import Foundation

func Day17Part2(useTestInput: Bool) {

	let fileInput = stringArray(fromFile: "Day17_input.txt")
	let testInput = stringArray(fromMultilineString: """
.#.
..#
###
""")
	let input = useTestInput ? testInput : fileInput

	var state = [[[[Bool]]]]()
	var state2D = [[[Bool]]]()
	var grid = [[Bool]]()

	var currentCountX = input[0].count
	var currentCountY = input.count
	var currentCountZ = 1
	var currentCountW = 1

	// pack initial state
	for line in input {
		var stateRow = [Bool]()
		for char in line {
			stateRow.append(char == Character("#"))
		}
		grid.append(stateRow)
	}
	state2D.append(grid)
	state.append(state2D)

	// simulate 6 times
	var neighbors = 0
	var tempState = [[[[Bool]]]]()
	for _ in 0..<6 {

		// first grow in every dimension
		for w in 0..<currentCountW {
			for z in 0..<currentCountZ {
				// first x
				for y in 0..<currentCountY {
					state[w][z][y].insert(false, at: 0)
					state[w][z][y].append(false)
				}
				// y
				let emptyRow = Array(repeating: false, count: currentCountX + 2)
				state[w][z].insert(emptyRow, at: 0)
				state[w][z].append(emptyRow)
			}
			grid = [[Bool]]()
			for _ in 0..<currentCountY + 2 {
				grid.append(Array(repeating: false, count: currentCountX + 2))
			}
			state[w].insert(grid, at: 0)
			state[w].append(grid)
		}
		currentCountX += 2
		currentCountY += 2
		currentCountZ += 2
		// empty w dimension
		grid = [[Bool]]()
		for _ in 0..<currentCountY {
			grid.append(Array(repeating: false, count: currentCountX))
		}
		state2D = [[[Bool]]]()
		for _ in 0..<currentCountZ {
			state2D.insert(grid, at: 0)
		}
		state.insert(state2D, at: 0)
		state.append(state2D)
		currentCountW += 2

		// now simulate
		tempState = state
		for x in 0..<currentCountX {
			for y in 0..<currentCountY {
				for z in 0..<currentCountZ {
					for w in 0..<currentCountW {

						neighbors = on4DNeighbors(checkX: x, checkY: y, checkZ: z, checkW: w, state: state)
						if state[w][z][y][x] {
							if neighbors != 2 && neighbors != 3 {
								tempState[w][z][y][x] = false
							}
						}
						else {
							if neighbors == 3 {
								tempState[w][z][y][x] = true
							}
						}

					}
				}
			}
		}
		state = tempState
//		print4DState(state: state)
	}

	let onStates = state.flatMap { $0 }.flatMap { $0 }.flatMap { $0 }.filter { $0 }.count
	print("on states count = \(onStates)")

}

func print4DState(state: [[[[Bool]]]]) {
	for w in 0..<state.count {
		for z in 0..<state[0].count {
			print("z = \(z), w = \(w)")
			for y in 0..<state[0][0].count {
				var line = ""
				for x in 0..<state[0][0][0].count {
					if state[w][z][y][x] {
						line.append("#")
					} else {
						line.append(".")
					}
				}
				print(line)
			}
		}
		print("\n")
	}
}

func on4DNeighbors(checkX: Int, checkY: Int, checkZ: Int, checkW: Int, state: [[[[Bool]]]]) -> Int {
	var num = 0
	let wCount = state.count
	let zCount = state[checkW].count
	let yCount = state[checkW][checkZ].count
	let xCount = state[checkW][checkZ][checkY].count
	var x = 0, y = 0, z = 0, w = 0
	for xOffset in -1...1 {
		for yOffset in -1...1 {
			for zOffset in -1...1 {
				for wOffset in -1...1 {

					x = checkX + xOffset
					y = checkY + yOffset
					z = checkZ + zOffset
					w = checkW + wOffset

					if x == checkX && y == checkY && z == checkZ && w == checkW {
						continue
					}

					if w < 0 ||
						w >= wCount ||
						z < 0 ||
						z >= zCount ||
						y < 0 ||
						y >= yCount ||
						x < 0 ||
						x >= xCount
					{
						continue
					}

					if state[w][z][y][x] {
						num += 1
					}

				}
			}
		}
	}
	return num
}
