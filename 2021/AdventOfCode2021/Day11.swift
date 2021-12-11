import Foundation

class Day11 {

    struct Grid {
        var arr = [[Int]]()

        mutating func addToAllAdjacent(forX x: Int, andY y: Int) {
            addTo(x: x-1, andY: y-1)
            addTo(x: x, andY: y-1)
            addTo(x: x+1, andY: y-1)
            addTo(x: x-1, andY: y)
            addTo(x: x+1, andY: y)
            addTo(x: x-1, andY: y+1)
            addTo(x: x, andY: y+1)
            addTo(x: x+1, andY: y+1)
        }

        mutating func addTo(x: Int, andY y:Int) {
            guard x >= 0, y >= 0, y < arr.count, x < arr[y].count else { return }
            // we also want to skip 0s, because they already flashed this time around
            guard arr[y][x] != 0 else { return }
            arr[y][x] = arr[y][x] + 1
        }

    }

    func part1() {
        var input = inputArray()

        var flashes = 0

        for _ in 0..<100 {

            for y in 0..<input.arr.count {
                for x in 0..<input.arr[y].count {
                    input.arr[y][x] = input.arr[y][x] + 1
                }
            }

            var shouldContinue = true
            while shouldContinue {
                shouldContinue = false

                for y in 0..<input.arr.count {
                    for x in 0..<input.arr[y].count {
                        if input.arr[y][x] > 9 {
                            shouldContinue = true
                            flashes = flashes + 1
                            input.addToAllAdjacent(forX: x, andY: y)
                            input.arr[y][x] = 0
                        }
                    }
                }

            }

        }

        print("part1 = \(flashes)")
    }

    func part2() {
        var input = inputArray()

        for i in 1..<1000 {

            for y in 0..<input.arr.count {
                for x in 0..<input.arr[y].count {
                    input.arr[y][x] = input.arr[y][x] + 1
                }
            }

            var shouldContinue = true
            while shouldContinue {
                shouldContinue = false

                for y in 0..<input.arr.count {
                    for x in 0..<input.arr[y].count {
                        if input.arr[y][x] > 9 {
                            shouldContinue = true
                            input.addToAllAdjacent(forX: x, andY: y)
                            input.arr[y][x] = 0
                        }
                    }
                }
            }

            var allAreZero = true
            for y in 0..<input.arr.count {
                for x in 0..<input.arr[y].count {
                    if input.arr[y][x] != 0 {
                        allAreZero = false
                    }
                }
            }
            if allAreZero {
                print("synchronized at \(i)")
                return
            }

        }
//        print("part2 = \(output)")
    }

    private func inputArray() -> Grid {
        let input = stringArray(fromFile: "Day11.txt")
        var grid = Grid()
        for line in input {
            grid.arr.append(line.intArray())
        }
        return grid
    }

    func perform() {
        part1()
        part2()
    }
}
