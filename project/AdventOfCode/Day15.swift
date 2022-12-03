import Foundation

class Day15 {

    func part1() {
        var grid = inputArray()

        let start = Grid.Point(x: 0, y: 0)
        let end = Grid.Point(x: grid.data[0].count-1, y: grid.data.count-1)
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
        var grid = part2Input()
        let start = Grid.Point(x: 0, y: 0)
        let end = Grid.Point(x: grid.data[0].count-1, y: grid.data.count-1)
        let path = grid.search(start: start, end: end)
//        grid.printSearchPath(path)

        var totalCost = 0
        for point in path {
            totalCost += grid.cost(point: point)
        }
        let output = totalCost
        print("part2 = \(output)")
    }

    private func inputArray() -> Grid {
        let input = stringArray(fromFile: "Day15.txt")
        var grid = Grid()
        for line in input {
            grid.data.append(line.intArray())
        }
        return grid
    }

    private func part2Input() -> Grid {
        let input = stringArray(fromFile: "Day15.txt")
        var grid = Grid()
        let width = input[0].count * 5
        let height = input.count * 5
        grid.initializeDataWith(width: width, height: height)
        var baseY = 0
        var baseX = 0
        for line in input {
            baseX = 0
            for cost in line.intArray() {
                grid.data[baseY][baseX] = cost
                for additionX in 0..<5 {
                    let costX = cost + additionX
                    let value = costX < 10 ? costX : ((costX % 10) + 1)
                    grid.data[baseY][baseX + (line.count * additionX)] = value
                    // each row below
                    for additionY in 1..<5 {
                        let costY = costX + additionY
                        let downValue = costY < 10 ? costY : ((costY % 10) + 1)
                        grid.data[baseY + (additionY * input.count)][baseX + (line.count * additionX)] = downValue
                    }
                }
                baseX += 1
            }
            baseY += 1
        }
        return grid
    }

    func perform() {
        let date = Date()
        part1()
        print("took: \(Date().timeIntervalSince(date).formatted())")
        part2()
        print("took: \(Date().timeIntervalSince(date).formatted())")
    }
}
