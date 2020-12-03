import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)

let testContents = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

let input: [String] = contents.split(separator: "\n").map { String($0) }

let width = input[0].count

let slopes = [[1,1], [3,1], [5,1], [7,1], [1,2]]

var trees = [0,0,0,0,0]
var xIndex = [0,0,0,0,0]
var yIndex = 0
var slopeIndex = 0

for line in input {
	slopeIndex = 0
	for slope in slopes {
		if slope[1] > 1 && (yIndex % slope[1]) != 0 {
//			print("continuing... yIndex: \(yIndex) slope: \(slope[1])")
			slopeIndex += 1
			continue
		}
		if yIndex > 0 {
			xIndex[slopeIndex] = (xIndex[slopeIndex] + slope[0]) % width
		}
		let charAtIndex = String(line[line.index(line.startIndex, offsetBy: xIndex[slopeIndex])])
		if charAtIndex == "#" {
			trees[slopeIndex] += 1
		}
		slopeIndex += 1
	}
	yIndex = yIndex + 1
}

var multiplied = 1
for tree in trees {
	multiplied *= tree
}

print("hit \(trees) trees, multiplied = \(multiplied)")
