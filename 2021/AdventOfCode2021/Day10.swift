import Foundation

class Day10 {

    func part1() {
        let input = inputArray()

        let scoreLUT = [
            ")": 3,
            "]": 57,
            "}": 1197,
            ">": 25137,
        ]

        var score = 0

        for line in input {

            var expectedChars = [String]()
            var skipRestOfLine = false
            for i in 0..<line.count {
                if skipRestOfLine { break }
                switch String(line[i]) {
                case "(":
                    expectedChars.append(")")
                case "[":
                    expectedChars.append("]")
                case "{":
                    expectedChars.append("}")
                case "<":
                    expectedChars.append(">")
                case ")", "]", "}", ">":
                    if expectedChars.last! != String(line[i]) {
                        score = score + scoreLUT[String(line[i])]!
                        skipRestOfLine = true
                    } else {
                        expectedChars.removeLast()
                    }
                default:
                    break
                }
            }

        }

        print("part1 = \(score)")
    }

    func part2() {
        let input = inputArray()

        let scoreLUT = [
            ")": 1,
            "]": 2,
            "}": 3,
            ">": 4,
        ]

        var scores = [Int]()

        for line in input {

            var expectedChars = [String]()
            var skipRestOfLine = false
            for i in 0..<line.count {
                if skipRestOfLine { break }
                switch String(line[i]) {
                case "(":
                    expectedChars.append(")")
                case "[":
                    expectedChars.append("]")
                case "{":
                    expectedChars.append("}")
                case "<":
                    expectedChars.append(">")
                case ")", "]", "}", ">":
                    if expectedChars.last! != String(line[i]) {
                        skipRestOfLine = true
                    } else {
                        expectedChars.removeLast()
                    }
                default:
                    break
                }
            }

            if !skipRestOfLine && expectedChars.count > 0 {
                var newScore = 0
                for char in expectedChars.reversed() {
                    newScore = (newScore * 5) + scoreLUT[char]!
                }
                scores.append(newScore)
            }

        }

        let midpoint = (scores.count - 1) / 2
        let finalScore = scores.sorted()[midpoint]

        print("part2 = \(finalScore)")
    }

    private func inputArray() -> [String] {
        return stringArray(fromFile: "Day10.txt")
    }

    func perform() {
        part1()
        part2()
    }
}
