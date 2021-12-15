import Foundation

class Day15 {

    func part1() {
        var grid = inputArray()

        let start = Grid.Point(x: 0, y: 0)
        let end = Grid.Point(x: grid.arr[0].count-1, y: grid.arr.count-1)
        let path = grid.search(start: start, end: end)
//        grid.printSearchPath(path)

        var totalCost = 0
        for point in path {
            totalCost += grid.cost(point: point)
        }
        let output = totalCost
        print("part1 = \(output)")
    }

    func part2() {
//        let input = inputArray()

        let output = ""
        print("part2 = \(output)")
    }

    private func inputArray() -> Grid {
        let input = stringArray(fromFile: "Day15.txt")
        var grid = Grid()
        for line in input {
            grid.arr.append(line.intArray())
        }
        return grid
    }

    private func part2Input() -> Grid {
        let input = stringArray(fromFile: "Day15.txt")
        var grid = Grid()
        for multiplier in 0..<5 {
            for line in input {
                grid.arr.append(line.intArray())
            }
        }
        return grid
    }

    func perform() {
        part1()
        part2()
    }
}
