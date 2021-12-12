import Foundation

class Day12 {

    class Node: Equatable, Hashable {
        var name = ""
        var connections = Set<String>()
        var isBig: Bool {
            name == name.uppercased()
        }

        static func ==(lhs: Node, rhs: Node) -> Bool {
            return lhs.name == rhs.name
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
    }

    var allNodes = [String: Node]()
    var allPaths = [String]()

    func part1() {
        let start = allNodes["start"]!
        for secondNodeName in start.connections {
            let path = "start,\(secondNodeName)"
            addPaths(fromNode: allNodes[secondNodeName]!, toPath: path)
        }

        let output = allPaths.count
        print("part1 = \(output)")
    }

    func addPaths(fromNode node: Node, toPath path: String) {
        var string = path
        if node.isBig || !string.contains("\(node.name),") {
            string = "\(string)\(node.name),"
        } else {
            return
        }
        if node.name == "end" && !allPaths.contains(string) {
            allPaths.append(string)
            return
        }
        for nodeName in node.connections {
            addPaths(fromNode: allNodes[nodeName]!, toPath: string)
        }
    }

//    var allPaths2 = [[String]]()
    struct Path: Equatable {
        var string = ""
        var smallCaveTwice = false
    }
    var allPaths2 = [Path]()

    func part2() {
        let start = allNodes["start"]!
        for secondNodeName in start.connections {
            let path = Path(string: "start,", smallCaveTwice: false)
            addPathsPart2(fromNode: allNodes[secondNodeName]!, toPath: path)
        }

        let output = allPaths2.count
        print("part2 = \(output)")
    }

    func addPathsPart2(fromNode node: Node, toPath path: Path) {
        guard node.name != "start" else { return }
        var path = path
        if path.string.contains(node.name) {
            if node.isBig {
                path.string = "\(path.string)\(node.name),"
            } else if !path.smallCaveTwice {
                path.string = "\(path.string)\(node.name),"
                path.smallCaveTwice = true
            } else {
                return
            }
        } else {
            path.string = "\(path.string)\(node.name),"
        }
        if node.name == "end" {
            if !allPaths2.contains(path) {
                allPaths2.append(path)
            }
            return
        }
        for nodeName in node.connections {
            addPathsPart2(fromNode: allNodes[nodeName]!, toPath: path)
        }
    }

    private func parseInput() {
        let input = stringArray(fromFile: "Day12.txt")
        var nodes = [String: Node]()
        for line in input {
            let caves = line.split(separator: "-")
            if let node = nodes[String(caves[0])] {
                node.connections.insert(String(caves[1]))
            } else {
                let node = Node()
                node.name = String(caves[0])
                node.connections.insert(String(caves[1]))
                nodes[String(caves[0])] = node
            }
            if let node2 = nodes[String(caves[1])] {
                node2.connections.insert(String(caves[0]))
            } else {
                let node = Node()
                node.name = String(caves[1])
                node.connections.insert(String(caves[0]))
                nodes[String(caves[1])] = node
            }
        }
        allNodes = nodes
    }

    func perform() {
        parseInput()
        part1()
        part2()
    }
}
