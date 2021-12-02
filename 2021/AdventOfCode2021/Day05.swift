import Foundation

class Day05 {
    func perform() {
        part1()
    }

    func part1() {
        let input = inputArray()

        let output = input
        print(" = \(output)")
    }

    func part2() {
        let input = inputArray()

        let output = input
        print(" = \(output)")
    }

    private func inputArray() -> [String] {
        return stringArray(fromFile: "Day05.txt")
    }
}
