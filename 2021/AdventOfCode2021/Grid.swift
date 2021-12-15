import Foundation

struct Grid {

    struct Point: Hashable, Equatable {
        var x: Int
        var y: Int
    }

    var arr = [[Int]]()

    struct PointPriorityQueue {
        private var elements = [(point: Point, priority: Int)]()

        func count() -> Int {
            return elements.count
        }

        mutating func enqueue(point: Point, cost: Int) {
            elements.append((point: point, priority: cost))
        }

        mutating func dequeue() -> Point {
            var bestIndex = 0
            for i in 0..<elements.count {
                if elements[i].priority < elements[bestIndex].priority {
                    bestIndex = i
                }
            }
            let bestItem = elements[bestIndex]
            elements.remove(at: bestIndex)
            return bestItem.point
        }
    }

    func inBounds(point: Point) -> Bool {
        return point.x >= 0 && point.y >= 0 &&
            point.x < arr[0].count && point.y < arr.count
    }

    // neighboring spaces

    static var directions = [
        Point(x: 1, y: 0),
        Point(x: 0, y: -1),
        Point(x: -1, y: 0),
        Point(x: 0, y: 1),
    ]

    func neighbors(point: Point) -> [Point] {
        var nbs = [Point]()
        for d in Grid.directions {
            let newPoint = Point(x: point.x + d.x, y: point.y + d.y)
            if inBounds(point: newPoint) {
                nbs.append(newPoint)
            }
        }
        return nbs
    }

    // A* related

    public var cameFrom = [Point: Point]()
    public var costSoFar = [Point: Int]()

    func cost(point: Point) -> Int {
        return arr[point.y][point.x]
    }

    func heuristic(a: Point, b: Point) -> Int {
        return abs(a.x - b.x) + abs(a.y - b.y)
    }

    mutating func search(start: Point, end: Point) -> [Point] {
        var frontier = PointPriorityQueue()
        frontier.enqueue(point: start, cost: 0)

        cameFrom[start] = start
        costSoFar[start] = 0

        while frontier.count() > 0 {
            let current = frontier.dequeue()

            for next in neighbors(point: current) {
                let newCost = costSoFar[current]! + cost(point: next)
                if costSoFar[next] == nil || newCost < costSoFar[next]! {
                    costSoFar[next] = newCost
                    let priority = newCost + heuristic(a: next, b: end)
                    frontier.enqueue(point: next, cost: priority)
                    cameFrom[next] = current
                }
            }
        }

        var path = [Point]()
        var currentPoint = end
        while currentPoint != start {
            path.append(currentPoint)
            currentPoint = cameFrom[currentPoint]!
        }
        return path.reversed()
    }

    func printSearchPath(_ path: [Point]) {
        var string = "grid: \n"
        for y in 0..<arr.count {
            for x in 0..<arr[y].count {
                if path.contains(Point(x: x, y: y)) {
                    string += "*, "
                } else {
                    string += "\(arr[y][x]), "
                }
            }
            string += "\n"
        }
        print(string)
    }
}
