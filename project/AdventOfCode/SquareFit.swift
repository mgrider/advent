import Foundation

class SquareFit {

    let possibleCharacters = [
        "A", "B", "C", "D", "a", "b", "c", "d",
    ]

    var groups = [String]()

    func perform() {

        for char1 in possibleCharacters {
            for char2 in possibleCharacters {
                for char3 in possibleCharacters {
                    for char4 in possibleCharacters {
                        let possible = "\(char1)\(char2)\(char3)\(char4)"
                        if !exists(possible) {
                            groups.append(possible)
                        }
                    }
                }
            }
        }

        print("group count: \(groups.count)\n\n \(groups)")

    }

    func exists(_ possible: String) -> Bool {
        if groups.contains(possible) { return true }
        // rotations
        var permutation = "\(possible[1])\(possible[2])\(possible[3])\(possible[0])"
        if groups.contains(permutation) { return true }
        permutation = "\(possible[2])\(possible[3])\(possible[0])\(possible[1])"
        if groups.contains(permutation) { return true }
        permutation = "\(possible[3])\(possible[0])\(possible[1])\(possible[2])"
        if groups.contains(permutation) { return true }
        // flipped over
        permutation = "\(possible[3])\(possible[2])\(possible[1])\(possible[0])"
        if groups.contains(permutation) { return true }
        permutation = "\(possible[2])\(possible[1])\(possible[0])\(possible[3])"
        if groups.contains(permutation) { return true }
        permutation = "\(possible[1])\(possible[0])\(possible[3])\(possible[2])"
        if groups.contains(permutation) { return true }
        permutation = "\(possible[0])\(possible[3])\(possible[2])\(possible[1])"
        if groups.contains(permutation) { return true }
        return false
    }

}
