import Foundation

class Day13 {

    struct Coord: Equatable, Hashable {
        var x: Int
        var y: Int
    }

    struct Fold {
        var axis: String
        var index: Int
    }

    func part1() {
        let input = inputArray()
        let folds = foldingInstructions()
        var output = Set<Coord>()

        if folds[0].axis == "y" {
            for coord in input {
                if coord.y < folds[0].index {
                    output.insert(coord)
                } else if coord.y == folds[0].index {
                    continue
                } else {
                    let newY = folds[0].index - (coord.y - folds[0].index)
                    let newCoord = Coord(x: coord.x, y: newY)
                    output.insert(newCoord)
                }
            }
        } else {
            for coord in input {
                if coord.x < folds[0].index {
                    output.insert(coord)
                } else if coord.x == folds[0].index {
                    continue
                } else {
                    let newX = folds[0].index - (coord.x - folds[0].index)
                    let newCoord = Coord(x: newX, y: coord.y)
                    output.insert(newCoord)
                }
            }
        }
        print("part1 = \(output.count)")
    }

    func part2() {
        var input = inputArray()
        let folds = foldingInstructions()

        for fold in folds {
            var output = Set<Coord>()
            if fold.axis == "y" {
                for coord in input {
                    if coord.y < fold.index {
                        output.insert(coord)
                    } else if coord.y == fold.index {
                        continue
                    } else {
                        let newY = fold.index - (coord.y - fold.index)
                        let newCoord = Coord(x: coord.x, y: newY)
                        output.insert(newCoord)
                    }
                }
            } else {
                for coord in input {
                    if coord.x < fold.index {
                        output.insert(coord)
                    } else if coord.x == fold.index {
                        continue
                    } else {
                        let newX = fold.index - (coord.x - fold.index)
                        let newCoord = Coord(x: newX, y: coord.y)
                        output.insert(newCoord)
                    }
                }
            }
            input = output
        }

        let biggestX = input.sorted(by: { $0.x > $1.x }).first!
        let biggestY = input.sorted(by: { $0.y > $1.y }).first!

        let gridX = Array<String>(repeating: ".", count: biggestX.x+1)
        var grid = Array<Array<String>>(repeating: gridX, count: biggestY.y+1)
        for coord in input {
            grid[coord.y][coord.x] = "#"
        }

        for g in grid {
            print("\(g)")
        }
//        print("part2 = \(grid)")
    }

    private func inputArray() -> Set<Coord> {
        let input = stringArray(fromFile: "Day13.txt")
        var coords = Set<Coord>()
        for line in input {
            let parts = line.split(separator: ",")
            let coord = Coord(x: Int(parts[0])!, y: Int(parts[1])!)
            coords.insert(coord)
        }
        return coords
    }

    private func foldingInstructions() -> [Fold] {
        return [
            Fold(axis: "x", index: 655),
            Fold(axis: "y", index: 447),
            Fold(axis: "x", index: 327),
            Fold(axis: "y", index: 223),
            Fold(axis: "x", index: 163),
            Fold(axis: "y", index: 111),
            Fold(axis: "x", index: 81),
            Fold(axis: "y", index: 55),
            Fold(axis: "x", index: 40),
            Fold(axis: "y", index: 27),
            Fold(axis: "y", index: 13),
            Fold(axis: "y", index: 6),
        ]
    }

    func perform() {
        part1()
        part2()
    }
}
