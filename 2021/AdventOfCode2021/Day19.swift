import Foundation

class Day19 {

    struct Coord: Equatable, Hashable {
        var x, y, z: Int
    }

    func part1() {

        let output = "input"
        print("part1 = \(output)")
    }

    func part2() {
//        let input = inputArray()

        let output = ""
        print("part2 = \(output)")
    }

    //  1,  2,  3 xyz - zero rotation
    //  3,  2, -1 cw rotation from "above"
    // -1,  2, -3 twice
    // -3,  2, -1 thrice
    // 

    var scannerInput = [Set<Coord>]()

    private func parseScannerInput() {
        let input = stringArray(fromFile: "Day19.txt")
        var currentSet = Set<Coord>()
        for line in input {
            if line.hasPrefix("---") && !currentSet.isEmpty {
                scannerInput.append(currentSet)
                currentSet = Set<Coord>()
            } else {
                let parts = line.components(separatedBy: ",")
                if let x = Int(parts[0]), let y = Int(parts[1]), let z = Int(parts[2]) {
                    currentSet.insert(Coord(x: x, y: y, z: z))
                }
            }
        }
    }

    func perform() {
        parseScannerInput()
        part1()
        part2()
    }
}
