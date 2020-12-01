import Foundation

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [Int] = contents.split(separator: "\n").map { Int($0) ?? 0 }

//print(input.count)

for i in input {
	if let i2 = input.first(where: {
		i + $0 == 2020
	}) {
		print(i * i2)
		break
	}
}

