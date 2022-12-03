import Foundation

class Day14 {

    struct CharacterCounts {
        var char: Character
        var count: UInt64
    }

    func part1() {
        let input = inputArray()

        var polymer = starting()
        var characterCounts = [Character: CharacterCounts]()
        for i in 0..<10 {

            var newPolymer = polymer
            var lastChar: Character?
            var inserts = 0
            for (n, char) in polymer.enumerated() {
                if let lastChar = lastChar {
                    let key = "\(lastChar)\(char)"
                    if let value = input[key] {
                        newPolymer.replaceCharacterAt(index: inserts+n, with: "\(value)\(char)")
                        inserts = inserts + 1
                    }
                }
                lastChar = char
            }
            polymer = newPolymer
            characterCounts = [Character: CharacterCounts]()
            for (_, char) in polymer.enumerated() {
                if characterCounts[char] != nil {
                    characterCounts[char]!.count = characterCounts[char]!.count + 1
                } else {
                    characterCounts[char] = CharacterCounts(char: char, count: 1)
                }
            }
            print("finished \(i)")
            for count in characterCounts {
                print("\(count.value.char) - count: \(count.value.count)")
            }
        }

        let sorted = characterCounts.values.sorted(by: { $0.count > $1.count })

        let output = sorted.first!.count - sorted.last!.count
        print("part1 = \(output)")
    }

    struct Input {
        var key: String
        var insert: Character
        var increments: [String]
    }

    func part2() {
        let input = inputArray()
        let polymer = starting()

        var inputMap = [String: Input]()
        for (key, value) in input {
            let increments = [
                "\(key[0])\(value)",
                "\(value)\(key[1])",
            ]
            inputMap[key] = Input(key: key, insert: value[0], increments: increments)
        }

        var characterCounts = [Character: Int]()
        var pairCounts = [String: Int]()
        for (key, _) in inputMap {
            pairCounts[key] = 0
            for i in 0..<key.count {
                characterCounts[key[i]] = 0
            }
        }

        var lastChar: Character?
        for (_, char) in polymer.enumerated() {
            if let lastChar = lastChar {
                let key = "\(lastChar)\(char)"
                pairCounts[key]! += 1
            }
            characterCounts[char]! += 1
            lastChar = char
        }

        print(characterCounts)
        print(pairCounts)

        for i in 0..<40 {
            var newPairCounts = pairCounts
            for oldCount in pairCounts {
                if oldCount.value > 0 {
                    newPairCounts[oldCount.key]! -= oldCount.value
                    for otherKey in inputMap[oldCount.key]!.increments {
                        newPairCounts[otherKey]! += oldCount.value
                    }
                    characterCounts[inputMap[oldCount.key]!.insert]! += oldCount.value
                }
            }
            pairCounts = newPairCounts
            print("finished \(i): \(pairCounts)")
            print("\(characterCounts)")
        }

        let output = characterCounts.values.max()! - characterCounts.values.min()!
        print("part2 = \(output)")
    }

    private func inputArray() -> [String: String] {
        let input = stringArray(fromFile: "Day14.txt")
        var inputDict = [String: String]()
        for line in input {
            let splitable = line.replacingOccurrences(of: " -> ", with: ",")
            let split = splitable.split(separator: ",")
            inputDict[String(split[0])] = String(split[1])
        }
        return inputDict
    }

    private func starting() -> String {
//        return "NNCB"
        return "NBOKHVHOSVKSSBSVVBCS"
    }

    func perform() {
        part1()
        part2()
    }
}
