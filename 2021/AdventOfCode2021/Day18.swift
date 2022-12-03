import Foundation

class Day18 {

    func part1() {
        let input = inputArray()
        var allSnailInts = [SnailInt]()
        for line in input {
            let snailInts = parseInputLine(input: line)
            if allSnailInts.isEmpty {
                allSnailInts = snailInts
                var reducedSnailInts = reduceSnailInts(allSnailInts)
                while allSnailInts != reducedSnailInts {
                    allSnailInts = reducedSnailInts
                    reducedSnailInts = reduceSnailInts(allSnailInts)
                }
            } else {
                allSnailInts = addSnailInts(left: allSnailInts, right: snailInts)
                var reducedSnailInts = reduceSnailInts(allSnailInts)
                while allSnailInts != reducedSnailInts {
                    allSnailInts = reducedSnailInts
                    reducedSnailInts = reduceSnailInts(allSnailInts)
                }
            }
        }

        let output = magnitudeOf(allSnailInts)
        print("part1 = \(output)")
    }

    func part2() {
        let input = inputArray()
        var allSnailInts = [SnailInt]()
        var magnitudes = [Int]()
        for i in 0..<input.count {
            let snail1 = parseInputLine(input: input[i])
            allSnailInts = snail1
            var reducedSnailInts = reduceSnailInts(allSnailInts)
            while allSnailInts != reducedSnailInts {
                allSnailInts = reducedSnailInts
                reducedSnailInts = reduceSnailInts(allSnailInts)
            }
            for i2 in 0..<input.count {
                if i == i2 {
                    continue
                }
                let snail2 = parseInputLine(input: input[i2])
                var newSnailInts = addSnailInts(left: allSnailInts, right: snail2)
                reducedSnailInts = reduceSnailInts(newSnailInts)
                while newSnailInts != reducedSnailInts {
                    newSnailInts = reducedSnailInts
                    reducedSnailInts = reduceSnailInts(newSnailInts)
                }
                magnitudes.append(magnitudeOf(newSnailInts))
            }
        }

        let output = magnitudes.max()!
        print("part2 = \(output)")
    }

    struct SnailInt: Equatable {
        var depth = 0
        var value: Int
        var leftSide: Bool
    }

    private func magnitudeOf(_ snailInts: [SnailInt]) -> Int {
        var newSnailInts = snailInts
        var searchDepth = 4
        while newSnailInts.count > 2 {
            if let firstDepthIndex = newSnailInts.firstIndex(where: { $0.depth == searchDepth }) {
                let first = newSnailInts[firstDepthIndex]
//                guard first.leftSide else {
//                    assertionFailure("first found was not left side!?!")
//                    return -1
//                }
                var leftSide = true
                if firstDepthIndex > 0 && newSnailInts[firstDepthIndex - 1].depth == first.depth-1 && newSnailInts[firstDepthIndex - 1].leftSide {
                    leftSide = false
                }
//                } else if firstDepthIndex < newSnailInts.count-2 && newSnailInts[firstDepthIndex + 2].depth == first.depth-1 {
//                    leftSide = true
//                } else {
//                    print("something is wrong.")
//                    assertionFailure("not found left nor right")
//                }
                else if firstDepthIndex == newSnailInts.count - 2 {
                    leftSide = false
                }
                let newValue = first.value * 3 + newSnailInts[firstDepthIndex + 1].value * 2
                let newSI = SnailInt(depth: searchDepth - 1, value: newValue, leftSide: leftSide)
                newSnailInts.remove(at: firstDepthIndex + 1)
                newSnailInts.remove(at: firstDepthIndex)
                newSnailInts.insert(newSI, at: firstDepthIndex)
            } else {
                searchDepth -= 1
            }
        }
        var total = 0
        for snailInt in newSnailInts {
            let toAdd = snailInt.leftSide ? snailInt.value * 3 : snailInt.value * 2
            total += toAdd
        }
        return total
    }

    private func addSnailInts(left: [SnailInt], right: [SnailInt]) -> [SnailInt] {
        var newSnailInts = [SnailInt]()
        for i in 0..<left.count {
            var snailInt = left[i]
            snailInt.depth += 1
            newSnailInts.append(snailInt)
        }
        for i in 0..<right.count {
            var snailInt = right[i]
            snailInt.depth += 1
            newSnailInts.append(snailInt)
        }
        return newSnailInts
    }

    private func reduceSnailInts(_ snailInts: [SnailInt]) -> [SnailInt] {
        var newSnailInts = snailInts
        if let firstExploderIndex = newSnailInts.firstIndex(where: { $0.depth > 4 }) {
            var resultIsLeftSide = true
            let firstExploder = newSnailInts[firstExploderIndex]
            if firstExploderIndex > 0 {
                var toLeft = newSnailInts[firstExploderIndex - 1]
                toLeft.value = toLeft.value + firstExploder.value
                newSnailInts[firstExploderIndex - 1] = toLeft
                if toLeft.leftSide {
                    resultIsLeftSide = false
                }
            }
            let secondExploderIndex = firstExploderIndex + 1
            let secondExploder = newSnailInts[secondExploderIndex]
            if secondExploderIndex < newSnailInts.count - 1 {
                var toRight = newSnailInts[secondExploderIndex + 1]
                toRight.value = toRight.value + secondExploder.value
                newSnailInts[secondExploderIndex + 1] = toRight
            }
            let resultingInt = SnailInt(depth: firstExploder.depth - 1, value: 0, leftSide: resultIsLeftSide)
            newSnailInts[firstExploderIndex] = resultingInt
            newSnailInts.remove(at: secondExploderIndex)
        }
        else if let firstSplittingIndex = newSnailInts.firstIndex(where: { $0.value > 9 }) {
            let firstSplitting = newSnailInts[firstSplittingIndex]
            let leftValue = Int((Double(firstSplitting.value) / 2).rounded(.down))
            let rightValue = Int((Double(firstSplitting.value) / 2).rounded(.up))
            newSnailInts.remove(at: firstSplittingIndex)
            newSnailInts.insert(SnailInt(depth: firstSplitting.depth + 1, value: rightValue, leftSide: false), at: firstSplittingIndex)
            newSnailInts.insert(SnailInt(depth: firstSplitting.depth + 1, value: leftValue, leftSide: true), at: firstSplittingIndex)
        }
        return newSnailInts
    }

    private func parseInputLine(input: String) -> [SnailInt] {

        var snailInts = [SnailInt]()
        var isLeftSide = true
        var depth = 0

        for i in 0..<input.count {
            if input[i] == "[" {
                depth += 1
                isLeftSide = true
            } else if input[i] == "]" {
                depth -= 1
            } else if input[i] == "," {
                isLeftSide = false
            } else if input[i] == " " {
                continue
            } else if let intValue = Int(String(input[i])) {
                let snailInt = SnailInt(depth: depth, value: intValue, leftSide: isLeftSide)
                snailInts.append(snailInt)
            }
        }
        return snailInts
    }

    private func inputArray() -> [String] {
//        return stringArray(fromMultilineString: """
//[[[[3,0],[5,3]],[4,4]],[5,5]]
//""")
        return stringArray(fromFile: "Day18.txt")
    }

    func perform() {
        part1()
        part2()
    }
}
