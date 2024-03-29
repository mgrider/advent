import Foundation

extension String {

    // MARK: conversion to other things

    public func binaryFromHexadecimal() -> String {
        let hexChars = [
            "0":"0000",
            "1":"0001",
            "2":"0010",
            "3":"0011",
            "4":"0100",
            "5":"0101",
            "6":"0110",
            "7":"0111",
            "8":"1000",
            "9":"1001",
            "A":"1010",
            "B":"1011",
            "C":"1100",
            "D":"1101",
            "E":"1110",
            "F":"1111",
        ]
        var newStr = ""
        for i in 0..<self.count {
            guard let binStr = hexChars[String(self[i])] else { continue }
            newStr.append(binStr)
        }
        return newStr
    }

    public func decimalFromBinary() -> Int {
        return Int(self, radix: 2)!
    }

    public func intArray() -> [Int] {
        var ints = [Int]()
        for i in 0..<self.count {
            if let integer = Int(String(self[i])) {
                ints.append(integer)
            }
        }
        return ints
    }

	// MARK: Subtrings

	subscript(offset: Int) -> Character {
		self[index(startIndex, offsetBy: offset)]
	}

    public func containsAllCharactersIn(_ string: String) -> Bool {
        for char in string {
            if !self.contains(char) {
                return false
            }
        }
        return true
    }

    public mutating func insertCharacter(char: String, atIndex index: Int) {
        self.insert(char[0], at: self.index(self.startIndex, offsetBy: index))
    }

    func padLeft(totalWidth: Int, withString: String) -> String {
        let toPad = totalWidth - self.count
        if toPad < 1 {
            return self
        }
        return "".padding(toLength: toPad, withPad: withString, startingAt: 0) + self
    }

	public mutating func replaceCharacterAt(index: Int, with str: String) {
		self.remove(at: self.index(self.startIndex, offsetBy: index))
		self.insert(contentsOf: str, at: self.index(self.startIndex, offsetBy: index))
	}

	public mutating func replaceCharacterAt(index: Int, with char: Character) {
		self.remove(at: self.index(self.startIndex, offsetBy: index))
		self.insert(char, at: self.index(self.startIndex, offsetBy: index))
	}

    public func removingCharactersIn(string: String) -> String {
        var newString = self
        for char in string {
            newString = newString.replacingOccurrences(of: String(char), with: "")
        }
        return newString
    }

	public func substring(with range: NSRange) -> String {
		return (self as NSString).substring(with: range)
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
