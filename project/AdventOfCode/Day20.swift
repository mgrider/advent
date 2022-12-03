import Foundation

class Day20 {

    func part1() {
        var input = inputArray()

        for _ in 0..<2 {
            input = enhance(inputData: input)
        }

        var count = 0
        for y in 0..<input.count {
            for x in 0..<input[0].count {
                if input[y][x] == "#" {
                    count += 1
                }
            }
        }

        let output = count
        print("part1 = \(output)")
        // not 5255
        // not 5235
        // 5194
    }

    func enhance(inputData: [String]) -> [String] {
        var input = inputData
        // first expand in each direction
        let expandingChar = enhancementString[0]
        for y in 0..<input.count {
            input[y].insertCharacter(char: String(expandingChar), atIndex: 0)
            input[y].append(expandingChar)
        }
        input.insert(String(Array<Character>(repeating: expandingChar, count: input[0].count)), at: 0)
        input.append(String(Array<Character>(repeating: expandingChar, count: input[0].count)))
        // do enhancement
        var newInput = input
        for y in 0..<input.count {
            for x in 0..<input[0].count {
                var bin = zeroOrOneFor(x: x-1, y: y-1, in: input)
                bin.append(zeroOrOneFor(x: x, y: y-1, in: input))
                bin.append(zeroOrOneFor(x: x+1, y: y-1, in: input))
                bin.append(zeroOrOneFor(x: x-1, y: y, in: input))
                bin.append(zeroOrOneFor(x: x, y: y, in: input))
                bin.append(zeroOrOneFor(x: x+1, y: y, in: input))
                bin.append(zeroOrOneFor(x: x-1, y: y+1, in: input))
                bin.append(zeroOrOneFor(x: x, y: y+1, in: input))
                bin.append(zeroOrOneFor(x: x+1, y: y+1, in: input))
                let num = bin.decimalFromBinary()
                newInput[y].replaceCharacterAt(index: x, with: enhancementString[num])
            }
        }
        return newInput
    }

    func zeroOrOneFor(x: Int, y: Int, in array: [String]) -> String {
        guard y >= 0, y < array.count, x >= 0, x < array[y].count else {
            return "1"
        }
        if array[y][x] == "#" {
            return "1"
        } else {
            return "0"
        }
    }

    func part2() {
//        let input = inputArray()

        let output = ""
        print("part2 = \(output)")
    }

    private func inputArray() -> [String] {
        var strArr = stringArray(fromFile: "Day20.txt")
        enhancementString = strArr[0]
        strArr.remove(at: 0)
        return strArr
//        return stringArray(fromMultilineString: """
//
//""")
    }

    var enhancementString = ""

    func perform() {
        part1()
        part2()
    }
}
