import Foundation

func Day11Part2() {

	let input = stringArray(fromFile: "Day11_input.txt")
	let testInput = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
""".split(separator: "\n").map { String($0) }

	let rows = input
	let width = rows[0].count
	let empty: Character = "L"[0]
	let occupied: Character = "#"[0]
	let floor: Character = "."[0]

	func followRule(rowstrings: [String]) -> [String] {
		var rulerows = rowstrings
		for y in 0..<rowstrings.count {
			for x in 0..<width {
				if rowstrings[y][x] == empty &&
					adjacentSeatCount(character: occupied, x: x, y: y, rowstrings: rowstrings) == 0 {
					var row = rulerows[y]
					row.remove(at: row.index(row.startIndex, offsetBy: x))
					row.insert(occupied, at: row.index(row.startIndex, offsetBy: x))
					rulerows[y] = row
				}
				else if rowstrings[y][x] == occupied &&
							adjacentSeatCount(character: occupied, x: x, y: y, rowstrings: rowstrings) >= 5 {
					var row = rulerows[y]
					row.remove(at: row.index(row.startIndex, offsetBy: x))
					row.insert(empty, at: row.index(row.startIndex, offsetBy: x))
					rulerows[y] = row
				}
			}
		}
		return rulerows
	}

	func adjacentSeatCount(character: Character, x: Int, y: Int, rowstrings: [String]) -> Int {
		var adjacent = 0
		for cy in -1...1 {
			for cx in -1...1 {
				if cy == 0 && cx == 0 {
					continue
				}
				if isSeat(
					character: character,
					x: x,
					y: y,
					cx: cx,
					cy: cy,
					rowstrings: rowstrings) {
					adjacent += 1
				}
			}
		}
		return adjacent
	}

	func isSeat(
		character: Character,
		x: Int,
		y: Int,
		cx: Int,
		cy: Int,
		rowstrings: [String]) -> Bool {
		var ax = x + cx
		var ay = y + cy
		while ax >= 0 && ax < width && ay >= 0 && ay < rowstrings.count {
			if rowstrings[ay][ax] == character {
				return true
			}
			else if rowstrings[ay][ax] == floor {
				ax = ax + cx
				ay = ay + cy
			}
			else {
				return false
			}
		}
		return false
	}

	var seatSet = Set<[String]>()
	seatSet.insert(rows)
	var index = 0
	var lastSeats = rows
	while true {
		print("checking row itteration \(index)")
		let seatsAfterRules = followRule(rowstrings: lastSeats)
		if seatsAfterRules == lastSeats {
			var totalOccupied = 0
			for y in 0..<lastSeats.count {
				for x in 0..<width {
					if lastSeats[y][x] == occupied {
						totalOccupied += 1
					}
				}
			}
			print("we won! \n\(seatsAfterRules)\ntotal: \(totalOccupied)")
			break
		}
		lastSeats = seatsAfterRules
		index += 1
	}

}



func Day11Part1() {

	let input = stringArray(fromFile: "Day11_input.txt")
	let testInput = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
""".split(separator: "\n").map { String($0) }

	var rows = input
	let width = rows[0].count
	let empty: Character = "L"[0]
	let occupied: Character = "#"[0]

	func followRule(rowstrings: [String]) -> [String] {
		var rulerows = rowstrings
		for y in 0..<rowstrings.count {
			for x in 0..<width {
				if rowstrings[y][x] == empty &&
					adjacentSeatCount(character: occupied, x: x, y: y, rowstrings: rowstrings) == 0 {
					var row = rulerows[y]
					row.remove(at: row.index(row.startIndex, offsetBy: x))
					row.insert(occupied, at: row.index(row.startIndex, offsetBy: x))
					rulerows[y] = row
				}
				else if rowstrings[y][x] == occupied &&
							adjacentSeatCount(character: occupied, x: x, y: y, rowstrings: rowstrings) >= 4 {
					var row = rulerows[y]
					row.remove(at: row.index(row.startIndex, offsetBy: x))
					row.insert(empty, at: row.index(row.startIndex, offsetBy: x))
					rulerows[y] = row
				}
			}
		}
		return rulerows
	}

	func adjacentSeatCount(character: Character, x: Int, y: Int, rowstrings: [String]) -> Int {
		var adjacent = 0
		for cy in y-1...y+1 {
			for cx in x-1...x+1 {
				if cy == y && cx == x {
					continue
				}
				if isSeat(character: character, x: cx, y: cy, rowstrings: rowstrings) {
					adjacent += 1
				}
			}
		}
		return adjacent
	}

	func isSeat(character: Character, x: Int, y: Int, rowstrings: [String]) -> Bool {
		guard x >= 0 && x < width && y >= 0 && y < rowstrings.count else { return false }
		return rowstrings[y][x] == character
	}

	var seatSet = Set<[String]>()
	seatSet.insert(rows)
	var index = 0
	var lastSeats = rows
	while true {
		print("checking row itteration \(index)")
		let seatsAfterRules = followRule(rowstrings: lastSeats)
		if seatsAfterRules == lastSeats {
			var totalOccupied = 0
			for y in 0..<lastSeats.count {
				for x in 0..<width {
					if lastSeats[y][x] == occupied {
						totalOccupied += 1
					}
				}
			}
			print("we won! \n\(seatsAfterRules)\ntotal: \(totalOccupied)")
			break
		}
		lastSeats = seatsAfterRules
		index += 1
	}
}
