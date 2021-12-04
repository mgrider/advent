import Foundation

class Day04 {

    let numbersDrawn = [26,38,2,15,36,8,12,46,88,72,32,35,64,19,5,66,20,52,74,3,59,94,45,56,0,6,67,24,97,50,92,93,84,65,71,90,96,21,87,75,58,82,14,53,95,27,49,69,16,89,37,13,1,81,60,79,51,18,48,33,42,63,39,34,62,55,47,54,23,83,77,9,70,68,85,86,91,41,4,61,78,31,22,76,40,17,30,98,44,25,80,73,11,28,7,99,29,57,43,10]
    let numbersDrawnSample = [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]

    struct Board {
        var numbers = [Int]()
        var marked = Array<Bool>.init(repeating: false, count: 25)
        mutating func markNumber(number: Int) {
            if let index = numbers.firstIndex(of: number) {
                marked[index] = true
            }
        }
        func hasWin() -> Bool {
            // rows
            for i in 0..<5 {
                if marked[i*5] &&
                    marked[(i*5)+1] &&
                    marked[(i*5)+2] &&
                    marked[(i*5)+3] &&
                    marked[(i*5)+4] {
                    return true
                }
            }
            // columns
            for i in 0..<5 {
                if marked[i] &&
                    marked[i+5] &&
                    marked[i+10] &&
                    marked[i+15] &&
                    marked[i+20] {
                    return true
                }
            }
            return false
        }
    }

    func part1() {
        var input = boards()
        for number in numbersDrawn {
            for i in 0..<input.count {
                input[i].markNumber(number: number)
                if input[i].hasWin() {
                    var sum = 0
                    for z in 0..<input[i].numbers.count {
                        if !input[i].marked[z] {
                            sum = sum + input[i].numbers[z]
                        }
                    }
                    print("part1 winning sum: \(sum) * win: \(number) = \(sum * number)")
                    return
                }
            }
        }
    }

    func part2() {
        var input = boards()
        for number in numbersDrawn {
            for i in 0..<input.count {
                input[i].markNumber(number: number)
            }
            if input.count == 1 && input[0].hasWin() {
                var sum = 0
                for z in 0..<input[0].numbers.count {
                    if !input[0].marked[z] {
                        sum = sum + input[0].numbers[z]
                    }
                }
                print("part2 losing sum: \(sum) * win: \(number) = \(sum * number)")
                return
            } else {
                input = input.filter { !$0.hasWin() }
            }
        }
    }

    private func boards() -> [Board] {
        let input = inputArray()
        var boards = [Board]()
        var currentBoard = Board()
        var index = 0
        for line in input {
            if index == 4 {
                let numbers = line.split(separator: " ").compactMap { Int($0) }
                currentBoard.numbers.append(contentsOf: numbers)
                guard currentBoard.numbers.count == 25 else {
                    assertionFailure("only \(currentBoard.numbers.count) numbers")
                    break
                }
                boards.append(currentBoard)
                currentBoard = Board()
                index = 0
            } else {
                let numbers = line.split(separator: " ").compactMap { Int($0) }
                currentBoard.numbers.append(contentsOf: numbers)
                index = index + 1
            }
        }
        return boards
    }

    private func inputArray() -> [String] {
        return stringArray(fromFile: "Day04.txt")
    }

    func perform() {
        part1()
        part2()
    }
}
