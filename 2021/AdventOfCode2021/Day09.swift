import Foundation

class Day09 {

    struct Coord: Equatable {
        var x: Int
        var y: Int
    }

    func part1() {
        let input = inputArray()

        var risk = 0
        for y in 0..<input.count {
            for x in 0..<input[y].count {
                guard let height = Int(String(input[y][x])) else {
                    assertionFailure()
                    break
                }
                // up
                if y > 0 &&
                    height >= Int(String(input[y-1][x]))! {
                    continue
                }
                // down
                if y < input.count - 1 &&
                    height >= Int(String(input[y+1][x]))! {
                    continue
                }
                // left
                if x > 0 &&
                    height >= Int(String(input[y][x-1]))! {
                    continue
                }
                // right
                if x < input[y].count - 1 &&
                    height >= Int(String(input[y][x+1]))! {
                    continue
                }
                // otherwise we're in risky business
                risk = risk + height + 1
            }
        }

        print("part1 = \(risk)")
    }

    func part2() {
        let input = inputArray()

        var foundBasins = [[Coord]]()
        for y in 0..<input.count {
            for x in 0..<input[y].count {
                if Int(String(input[y][x]))! == 9 {
                    continue
                }
                let currentCoord = Coord(x: x, y: y)
                if foundBasins.contains(where: { $0.contains(where: { $0 == currentCoord })}) {
                    continue
                }
                let basin = addCoordToBasin(coord: currentCoord, basin: [Coord](), input: input)
                foundBasins.append(basin)
            }
        }

        foundBasins.sort(by: { $0.count > $1.count })
        let threeLargestBasinSizes = foundBasins[0].count * foundBasins[1].count * foundBasins[2].count

        print("part2 = \(threeLargestBasinSizes)")
    }

    func addCoordToBasin(coord: Coord, basin: [Coord], input: [String]) -> [Coord] {
        if basin.contains(coord) {
            return basin
        }
        if coord.x < 0 || coord.y < 0 || coord.y >= input.count || coord.x >= input[coord.y].count {
            return basin
        }
        if Int(String(input[coord.y][coord.x]))! == 9 {
            return basin
        }
        var newBasin = basin
        newBasin.append(coord)
        newBasin = addCoordToBasin(coord: Coord(x: coord.x, y: coord.y-1), basin: newBasin, input: input)
        newBasin = addCoordToBasin(coord: Coord(x: coord.x, y: coord.y+1), basin: newBasin, input: input)
        newBasin = addCoordToBasin(coord: Coord(x: coord.x+1, y: coord.y), basin: newBasin, input: input)
        newBasin = addCoordToBasin(coord: Coord(x: coord.x-1, y: coord.y), basin: newBasin, input: input)
        return newBasin
    }

    private func inputArray() -> [String] {
        return stringArray(fromFile: "Day09.txt")
    }

    func perform() {
        part1()
        part2()
    }
}
