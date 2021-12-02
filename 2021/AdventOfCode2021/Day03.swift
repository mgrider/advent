import Foundation

class Day03 {
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
        return stringArray(fromFile: "Day03.txt")
    }
}
