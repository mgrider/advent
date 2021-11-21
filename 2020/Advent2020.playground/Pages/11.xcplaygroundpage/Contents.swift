import Foundation

extension StringProtocol {
	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}
}

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [String] = contents.split(separator: "\n").map { String($0) }

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

var rows = testInput
let width = rows[0].count
let empty: Character = "L"[0]
let occupied: Character = "#"[0]

func followRule(rowstrings: [String]) -> [String] {
	var rulerows = rowstrings
	for y in 0..<rowstrings.count {
		for x in 0..<width {
			if rowstrings[y][x] == empty {
				let aEC = adjacentEmptyCount(x: x, y: y, rowstrings: rowstrings)
				if aEC == 0 {
					var row = rulerows[y]
					row.remove(at: row.index(row.startIndex, offsetBy: x))
					row.insert(occupied, at: row.index(row.startIndex, offsetBy: x))
					rulerows[y] = row
				}
			}
			else if rowstrings[y][x] == occupied &&
						adjacentEmptyCount(x: x, y: y, rowstrings: rowstrings) >= 4 {
				var row = rulerows[y]
				row.remove(at: row.index(row.startIndex, offsetBy: x))
				row.insert(empty, at: row.index(row.startIndex, offsetBy: x))
				rulerows[y] = row
			}
		}
	}
	return rulerows
}

func adjacentEmptyCount(x: Int, y: Int, rowstrings: [String]) -> Int {
	var adjacent = 0
	for cy in y-1...y+1 {
		for cx in x-1...x+1 {
			if isEmptySeat(x: cx, y: cy, rowstrings: rowstrings) {
				adjacent += 1
			}
		}
	}
	return adjacent
}

func isEmptySeat(x: Int, y: Int, rowstrings: [String]) -> Bool {
	guard x < 0 || x > width || y < 0 || y > rowstrings.count else { return false }
	return rowstrings[y][x] == empty
}

var seatSet = Set<[String]>()
seatSet.insert(rows)
var index = 0
var lastSeats = rows
while index < 10 {
	var seatsAfterRules = followRule(rowstrings: lastSeats)
	if seatsAfterRules == lastSeats {
		print("we won! \n\(seatsAfterRules)")
		break
	}
	lastSeats = seatsAfterRules
	index += 1
}

