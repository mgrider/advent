import Foundation

// credit where it's due, this is pretty much one of the examples on NSHipster's article on swift regex: https://nshipster.com/swift-regular-expressions/

let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [String] = contents.split(separator: "\n").map { String($0) }

// test input
//let input: [String] = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]

let pattern = #"^(\d{1,})-(\d{1,}) (\w{1}): (\w{1,})$"#
let regex = try NSRegularExpression(pattern: pattern, options: [])

var numberMatching = 0
for str in input {

	let nsrange = NSRange(str.startIndex..<str.endIndex, in: str)
	regex.enumerateMatches(
		in: str,
		options: [],
		range: nsrange) { (match, _, stop) in

		guard let match = match else { return }

		print("match ranges: \(match.numberOfRanges)")

		if match.numberOfRanges == 5,
		   let r1 = Range(match.range(at: 1), in: str),
		   let min = Int(str[r1]),
		   let r2 = Range(match.range(at: 2), in: str),
		   let max = Int(str[r2]),
		   let r3 = Range(match.range(at: 3), in: str),
		   let r4 = Range(match.range(at:4), in: str)
		{

			let password = "\(str[r4])"
			let specialChar = "\(str[r3])"

			print("string '\(str[r4])' must contain char \(str[r3]) at \(min) or \(max) positions.")

			let first = String(password[password.index(password.startIndex, offsetBy: min-1)])
			let second = String(password[password.index(password.startIndex, offsetBy: max-1)])

			if (first == specialChar && second != specialChar) ||
				(second == specialChar && first != specialChar)  {
				numberMatching += 1
			}
		}
	}
}

print("pw matches: \(numberMatching)")
