import Foundation

class Day12 {

    func part1() {
        let input = inputArray()

        let output = input
        print("part1 = \(output)")
    }

    func part2() {
        let input = inputArray()

        let output = ""
        print("part2 = \(output)")
    }

    private func inputArray() -> [String] {
        return stringArray(fromFile: "Day12.txt")
    }

    func perform() {
        part1()
        part2()
    }
}