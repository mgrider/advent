import Foundation

class Day06 {
    func part1() {
        var ages = inputArray()

        for _ in 0..<80 {
            var newAges = [Int]()
            for i in 0..<ages.count {
                if ages[i] == 0 {
                    newAges.append(6)
                    newAges.append(8)
                } else {
                    newAges.append(ages[i] - 1)
                }
            }
            ages = newAges
        }

        let output = ages.count
        print("part1 = \(output)")
    }

    func part2() {
        let ages = inputArray()
        var dict = Dictionary<Int,Int>()
        for i in 0..<ages.count {
            if let count = dict[ages[i]] {
                dict[ages[i]] = count + 1
            } else {
                dict[ages[i]] = 1
            }
        }
        for i in 0...8 {
            if dict[i] == nil {
                dict[i] = 0
            }
        }
        for _ in 0..<256 {
            var newAges = Dictionary<Int,Int>()
            var babies = 0
            if let mothers = dict[0] {
                babies = mothers
                newAges[8] = babies
            }
            for i in 1..<9 {
                if i == 7 {
                    newAges[6] = dict[7]! + babies
                } else {
                    newAges[i-1] = dict[i]!
                }
            }
            dict = newAges
        }

        let output = dict.values.reduce(0) { $0 + $1 }
        print("part2 = \(output)")
    }

    private func inputArray() -> [Int] {
        return [3,5,3,1,4,4,5,5,2,1,4,3,5,1,3,5,3,2,4,3,5,3,1,1,2,1,4,5,3,1,4,5,4,3,3,4,3,1,1,2,2,4,1,1,4,3,4,4,2,4,3,1,5,1,2,3,2,4,4,1,1,1,3,3,5,1,4,5,5,2,5,3,3,1,1,2,3,3,3,1,4,1,5,1,5,3,3,1,5,3,4,3,1,4,1,1,1,2,1,2,3,2,2,4,3,5,5,4,5,3,1,4,4,2,4,4,5,1,5,3,3,5,5,4,4,1,3,2,3,1,2,4,5,3,3,5,4,1,1,5,2,5,1,5,5,4,1,1,1,1,5,3,3,4,4,2,2,1,5,1,1,1,4,4,2,2,2,2,2,5,5,2,4,4,4,1,2,5,4,5,2,5,4,3,1,1,5,4,5,3,2,3,4,1,4,1,1,3,5,1,2,5,1,1,1,5,1,1,4,2,3,4,1,3,3,2,3,1,1,4,4,3,2,1,2,1,4,2,5,4,2,5,3,2,3,3,4,1,3,5,5,1,3,4,5,1,1,3,1,2,1,1,1,1,5,1,1,2,1,4,5,2,1,5,4,2,2,5,5,1,5,1,2,1,5,2,4,3,2,3,1,1,1,2,3,1,4,3,1,2,3,2,1,3,3,2,1,2,5,2]
//        return [3,4,3,1,2]
    }

    func perform() {
        part1()
        part2()
    }
}
