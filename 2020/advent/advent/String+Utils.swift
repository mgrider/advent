import Foundation

extension String {

	// MARK: Subtrings

	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}

	public mutating func replaceCharacterAt(index: Int, with str: String) {
		self.remove(at: self.index(self.startIndex, offsetBy: index))
		self.insert(contentsOf: str, at: self.index(self.startIndex, offsetBy: index))
	}

	public mutating func replaceCharacterAt(index: Int, with char: Character) {
		self.remove(at: self.index(self.startIndex, offsetBy: index))
		self.insert(char, at: self.index(self.startIndex, offsetBy: index))
	}

	public func substring(with range: NSRange) -> String {
		return (self as NSString).substring(with: range)
	}

	func padLeft(totalWidth: Int, withString: String) -> String {
		let toPad = totalWidth - self.count
		if toPad < 1 {
			return self
		}
		return "".padding(toLength: toPad, withPad: withString, startingAt: 0) + self
	}

	// MARK: Regex
	/// thanks to @scelis for these regex functions https://github.com/scelis/Advent-of-Code/blob/main/Sources/AdventKit/String%2BRegex.swift
	public func enumerateMatches(
		withPattern pattern: String,
		patternOptions: NSRegularExpression.Options = [],
		matchingOptions: NSRegularExpression.MatchingOptions = [],
		using block: ([String]) -> ()) throws
	{
		let regex = try NSRegularExpression(pattern: pattern, options: patternOptions)
		return try enumerateMatches(
			withRegularExpression: regex,
			options: matchingOptions,
			using: block
		)
	}

	public func enumerateMatches(
		withRegularExpression regex: NSRegularExpression,
		options: NSRegularExpression.MatchingOptions = [],
		using block: ([String]) -> ()) throws
	{
		let numGroups = regex.numberOfCaptureGroups
		let nsRange = NSRange(startIndex..<endIndex, in: self)
		regex.enumerateMatches(in: self, options: options, range: nsRange, using: { result, _, _ in
			if let result = result {
				var groups: [String] = []
				groups.append(substring(with: result.range))
				for i in 0..<numGroups {
					let groupRange = result.range(at: i + 1)
					if groupRange.location == NSNotFound {
						groups.append("")
					} else {
						groups.append(substring(with: groupRange))
					}
				}
				block(groups)
			}
		})
	}

	public func firstMatch(
		withPattern pattern: String,
		patternOptions: NSRegularExpression.Options = [],
		matchingOptions: NSRegularExpression.MatchingOptions = []) throws
		-> [String]
	{
		var ret: [String]?
		try enumerateMatches(
			withPattern: pattern,
			patternOptions: patternOptions,
			matchingOptions: matchingOptions,
			using: { groups in
				ret = groups
				return
			}
		)
		return ret ?? []
	}

	public func firstMatch(
		withRegularExpression regex: NSRegularExpression,
		options: NSRegularExpression.MatchingOptions = []) throws
		-> [String]
	{
		var ret: [String]?
		try enumerateMatches(
			withRegularExpression: regex,
			options: options,
			using: { groups in
				ret = groups
				return
			}
		)
		return ret ?? []
	}

}
