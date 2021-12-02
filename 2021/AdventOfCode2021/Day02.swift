//
//  Day02.swift
//  AdventOfCode2021
//
//  Created by Martin Grider on 12/1/21.
//

import Foundation

class Day02 {
    func perform() {
        part2()
    }

    func part1() {
        let input = inputArray()

        var depth = 0
        var position = 0

        for line in input {
            if line.hasPrefix("forward ") {
                guard let change = Int(line.replacingOccurrences(of: "forward ", with: "")) else {
                    print("no change found in line: \(line)")
                    continue
                }
                position += change
            }
            else if line.hasPrefix("down ") {
                guard let change = Int(line.replacingOccurrences(of: "down ", with: "")) else {
                    print("no change found in line: \(line)")
                    continue
                }
                depth += change
            }
            else if line.hasPrefix("up ") {
                guard let change = Int(line.replacingOccurrences(of: "up ", with: "")) else {
                    print("no change found in line: \(line)")
                    continue
                }
                depth -= change
            }
        }
        let output = depth * position
        print("depth: \(depth) * pos: \(position) = \(output)")
        // depth: 1017 * pos: 1906 = 1938402
    }

    func part2() {
        let input = inputArray()

        var depth = 0
        var position = 0
        var aim = 0

        for line in input {
            if line.hasPrefix("forward ") {
                guard let change = Int(line.replacingOccurrences(of: "forward ", with: "")) else {
                    print("no change found in line: \(line)")
                    continue
                }
                position += change
                depth += aim * change
            }
            else if line.hasPrefix("down ") {
                guard let change = Int(line.replacingOccurrences(of: "down ", with: "")) else {
                    print("no change found in line: \(line)")
                    continue
                }
                aim += change
            }
            else if line.hasPrefix("up ") {
                guard let change = Int(line.replacingOccurrences(of: "up ", with: "")) else {
                    print("no change found in line: \(line)")
                    continue
                }
                aim -= change
            }
        }
        let output = depth * position
        print("depth: \(depth) * pos: \(position) = \(output)")

    }

    private func inputArray() -> [String] {
        return stringArray(fromFile: "Day02.txt")
    }
}
