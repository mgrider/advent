import Foundation

class Day05 {

    struct Point: Hashable {
        var x: Int
        var y: Int
    }

    func part1() {
        let input = points(withDiagonals: false)

        var dict = Dictionary<Point, Int>()
        for point in input {
            if let val = dict[point] {
                dict[point] = val + 1
            } else {
                dict[point] = 1
            }
        }

        let output = dict.values.filter { $0 > 1 }.count
        print("part1 = \(output)")
    }

    func part2() {
        let input = points(withDiagonals: true)

        var dict = Dictionary<Point, Int>()
        for point in input {
            if let val = dict[point] {
                dict[point] = val + 1
            } else {
                dict[point] = 1
            }
        }

        let output = dict.values.filter { $0 > 1 }.count
        print("part2 = \(output)")
    }

    private func points(withDiagonals: Bool) -> [Point] {
        let input = inputArray()
        var points = [Point]()
        for line in input {
            let parts = line.replacingOccurrences(of: " -> ", with: "|").split(separator: "|")
            let firstCoord = parts[0].split(separator: ",").map { Int($0) }
            let secondCoord = parts[1].split(separator: ",").map { Int($0) }
            if firstCoord[0] == secondCoord[0] {
                guard let x = firstCoord[0], let firstY = firstCoord[1], let secondY = secondCoord[1] else {
                    assertionFailure()
                    continue
                }
                if firstY < secondY {
                    for y in firstY...secondY {
                        points.append(Point(x: x, y: y))
                    }
                } else {
                    for y in secondY...firstY {
                        points.append(Point(x: x, y: y))
                    }
                }
            } else if firstCoord[1] == secondCoord[1] {
                guard let y = firstCoord[1], let firstX = firstCoord[0], let secondX = secondCoord[0] else {
                    assertionFailure()
                    continue
                }
                if firstX < secondX {
                    for x in firstX...secondX {
                        points.append(Point(x: x, y: y))
                    }
                } else {
                    for x in secondX...firstX {
                        points.append(Point(x: x, y: y))
                    }
                }
            } else if withDiagonals {
                guard let fX = firstCoord[0],
                      let fY = firstCoord[1],
                      let sX = secondCoord[0],
                      let sY = secondCoord[1] else {
                    assertionFailure()
                    continue
                }
                let exes = intsBetween(int1: fX, int2: sX)
                let wise = intsBetween(int1: fY, int2: sY)
                for i in 0..<exes.count {
                    points.append(Point(x: exes[i], y: wise[i]))
                }
            }
        }
        return points
    }

    private func intsBetween(int1: Int, int2: Int) -> [Int] {
        var array = [Int]()
        if int1 < int2 {
            for i in int1...int2 {
                array.append(i)
            }
        } else {
            for i in int2...int1 {
                array.insert(i, at: 0)
            }
        }
        return array
    }

    private func inputArray() -> [String] {
//        return stringArray(fromMultilineString: """
//0,9 -> 5,9
//8,0 -> 0,8
//9,4 -> 3,4
//2,2 -> 2,1
//7,0 -> 7,4
//6,4 -> 2,0
//0,9 -> 2,9
//3,4 -> 1,4
//0,0 -> 8,8
//5,5 -> 8,2
//""")
        return stringArray(fromFile: "Day05.txt")
    }

    func perform() {
        part1()
        part2()
    }
}
