import Foundation

extension String {
	/// returns a new string without the specified suffix, or nil if suffix was not present
	func withoutSuffix(_ suffix: String) -> String? {
		if self.hasSuffix(suffix) {
			var copy = self
			copy.removeLast(suffix.count)
			return copy
		}
		return nil
	}
}

//let url = Bundle.main.url(forResource: "test_input", withExtension: "txt")!
let url = Bundle.main.url(forResource: "input", withExtension: "txt")!
let contents = try String(contentsOf: url, encoding: String.Encoding.utf8)
let input: [String] = contents.split(separator: "\n", omittingEmptySubsequences: false).map { String($0) }

let colorPattern = #"^#[a-f0-9]{6}$"#
let colorRegex = try NSRegularExpression(pattern: colorPattern, options: [])

func isValid(_ pp: [String : String]) -> Bool {
	guard let byr = pp["byr"],
		  let iyr = pp["iyr"],
		  let eyr = pp["eyr"],
		  let hgt = pp["hgt"],
		  let hcl = pp["hcl"],
		  let ecl = pp["ecl"],
		  let pid = pp["pid"] else {
		return false
	}
	if byr.count == 4,
		let iByr = Int(byr),
		iByr >= 1920, iByr <= 2020,
		iyr.count == 4,
		let iIyr = Int(iyr),
		iIyr >= 2010, iIyr <= 2020,
		eyr.count == 4,
		let iEyr = Int(eyr),
		iEyr >= 2020, iEyr <= 2030,
		isValidHGT(h: hgt),
		isValidHCL(hcl),
		isValidECL(ecl),
		isValidPID(pid) {
		return true
	}
	return false
}
func isValidPID(_ p: String) -> Bool {
	guard p.count == 9 else { return false }
	if Int(p) != nil {
		return true
	}
	return false
}
func isValidECL(_ e: String) -> Bool {
	return "amb blu brn gry grn hzl oth".contains(e)
}
func isValidHGT(h: String?) -> Bool {
	guard let h = h else { return false }
	if let cm = h.withoutSuffix("cm"),
	   let iCM = Int(cm),
	   iCM >= 150, iCM <= 193 {
		return true
	} else if let inches = h.withoutSuffix("in"),
		let iIn = Int(inches),
		iIn >= 59, iIn <= 76 {
		return true
	}
	return false
}
func isValidHCL(_ hcl: String) -> Bool {
	let hclRange = NSRange(hcl.startIndex..<hcl.endIndex, in: hcl)
	return colorRegex.numberOfMatches(in: hcl, options: [], range: hclRange) == 1
}

var numValid = 0

var currentPassport = [String : String]()
for line in input {
	if line == "" {
		if isValid(currentPassport) {
			numValid += 1
		}
		currentPassport = [String : String]()
	}
	for element in line.split(separator: " ") {
		let elementParts = element.split(separator: ":")
		currentPassport[String(elementParts[0])] = String(elementParts[1])
	}
}

print("found \(numValid) valid passports.")
