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

let right = 3
let width = input[0].count

var trees = 0
var index = 0

for line in input {
	let charAtIndex = String(line[line.index(line.startIndex, offsetBy: index)])
	if charAtIndex == "#" {
		trees += 1
	}
	index = (index + right) % width
}

print("hit \(trees) trees")
