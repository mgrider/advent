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

struct PP {
	var byr: String?
	var iyr: String?
	var eyr: String?
	var hgt: String?
	var hcl: String?
	var ecl: String?
	var pid: String?
	var cid: String?
	func isValid() -> Bool {
		guard let byr = byr,
			  let iyr = iyr,
			  let eyr = eyr,
			  let hgt = hgt,
			  let hcl = hcl,
			  let ecl = ecl,
			  let pid = pid else {
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
	func isValidV1() -> Bool {
		if byr != nil &&
			iyr != nil &&
			eyr != nil &&
			hgt != nil &&
			hcl != nil &&
			ecl != nil &&
			pid != nil {
			return true
		}
		return false
	}
}

var numValid = 0

var currentPassport: PP = PP()
for line in input {
	if line == "" {
//		print("current: \(currentPassport)")
		if currentPassport.isValid() {
			numValid += 1
		}
		currentPassport = PP()
	}
	for element in line.split(separator: " ") {
		let elementParts = element.split(separator: ":")
		switch elementParts[0] {
		case "byr":
			currentPassport.byr = String(elementParts[1])
		case "iyr":
			currentPassport.iyr = String(elementParts[1])
		case "eyr":
			currentPassport.eyr = String(elementParts[1])
		case "hgt":
			currentPassport.hgt = String(elementParts[1])
		case "hcl":
			currentPassport.hcl = String(elementParts[1])
		case "ecl":
			currentPassport.ecl = String(elementParts[1])
		// not doing cid
		case "pid":
			currentPassport.pid = String(elementParts[1])
		default:
			break
		}
	}
}

print("found \(numValid) valid passports.")
