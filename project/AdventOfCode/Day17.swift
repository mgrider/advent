import Foundation

class Day17 {

    struct Velocity {
        var x: Int
        var y: Int
    }

    func part1() {
        let target = input()

        // [hightestHeight : initial velocity]
//        var results = [Int: Velocity]()
        var highestResult = 0
        var highestV: Velocity?
        var numberResults = 0
        for x in 0..<1000 {
            print("onto \(x)")
            for y in -1000..<1000 {
                let velocity = Velocity(x: x, y: y)
                let result = simulate(velocity: velocity, to: target)
                if result.hit {
                    if result.highest > highestResult {
                        highestResult = result.highest
                        highestV = velocity
                    }
                    numberResults += 1
//                    results[result.highest] = velocity
                }
            }
        }

//        let output = results.keys.sorted().last!
        // not 12497500
        // not 49995000
        // not 5940445500 (x: 17, y: 108999)
        //     5940445500
        print("best v: \(highestV)")
        print("part1 = \(highestResult)")
        print("part2 = \(numberResults)")
        // not 3993
    }

    func simulate(velocity: Velocity, to target: Target) -> (hit: Bool, highest: Int) {
        var hasGoneBeyondIt = false
        var currentYPosition = 0
        var currentXPosition = 0
        var highestYPosition = 0
        var currentYVelocity = velocity.y
        var currentXVelocity = velocity.x
        while !hasGoneBeyondIt {
            currentYPosition += currentYVelocity
            currentXPosition += currentXVelocity
            currentYVelocity -= 1
            currentXVelocity = currentXVelocity > 0 ? currentXVelocity - 1 : 0
            if currentYPosition > highestYPosition {
                highestYPosition = currentYPosition
            }
            if target.yRange.contains(currentYPosition) && target.xRange.contains(currentXPosition) {
                print("hit with velocity \(velocity), highest point: \(highestYPosition)")
                return (hit: true, highest: highestYPosition)
            }
            if currentXPosition > target.xRange.upperBound || currentYPosition < target.yRange.lowerBound {
                hasGoneBeyondIt = true
                return (hit: false, highest: highestYPosition)
            }
        }
        return (hit: false, highest: highestYPosition)
    }

    struct Target {
        var xRange: ClosedRange<Int>
        var yRange: ClosedRange<Int>
    }

    private func input() -> Target {
//        return Target(xRange: 20 ..< 30, yRange: -10 ..< -5)
        // puzzle input
        return Target(xRange: 138 ... 184, yRange: -125 ... -71)
    }

    func perform() {
        part1()
    }
}
