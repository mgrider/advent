import Foundation

class Day03 {
    func perform() {
        part2()
    }

    func part1() {
        let input = inputArray()

        var mostCommons = [Substring]()
        var leastCommons = [Substring]()
        for i in 0..<input[0].count {
            let digits = input.compactMap { Int(String($0[i])) }
            let ones = digits.filter { $0 == 1 }.count
            let zeros = digits.filter { $0 == 0 }.count
            if ones > zeros {
                mostCommons.append("1")
                leastCommons.append("0")
            } else {
                mostCommons.append("0")
                leastCommons.append("1")
            }
        }
        let most = mostCommons.reduce("") { $0 + $1 }
        let least = leastCommons.reduce("") { $0 + $1 }
        let mostInt = Int.decimalFromBinaryString(most)
        let leastInt = Int.decimalFromBinaryString(least)

        print("gama: \(mostInt), espilon: \(leastInt), consumptioin = \(mostInt * leastInt)")
    }

    func part2() {
        let input = inputArray()

        var mostCommons = input
        var leastCommons = input
        var most: String = ""
        var least: String = ""
        for i in 0..<input[0].count {
            // mosts
            var digits = mostCommons.compactMap { Int(String($0[i])) }
            var ones = digits.filter { $0 == 1 }.count
            var zeros = digits.filter { $0 == 0 }.count
            if ones >= zeros {
                mostCommons = mostCommons.filter { $0[i] == "1" }
            } else {
                mostCommons = mostCommons.filter { $0[i] == "0" }
            }
            if most == "" && mostCommons.count == 1 {
                most = mostCommons[0]
            }
            // leasts
            digits = leastCommons.compactMap { Int(String($0[i])) }
            ones = digits.filter { $0 == 1 }.count
            zeros = digits.filter { $0 == 0 }.count
            if ones >= zeros {
                leastCommons = leastCommons.filter { $0[i] == "0" }
            } else {
                leastCommons = leastCommons.filter { $0[i] == "1" }
            }
            if least == "" && leastCommons.count == 1 {
                least = leastCommons[0]
            }
        }

//        print("most: \(most), least: \(least)")

        let mostInt = Int.decimalFromBinaryString(most)
        let leastInt = Int.decimalFromBinaryString(least)

        print("gama: \(mostInt), espilon: \(leastInt), consumptioin = \(mostInt * leastInt)")
    }

    private func inputArray() -> [String] {
        return stringArray(fromFile: "Day03.txt")
    }
}
