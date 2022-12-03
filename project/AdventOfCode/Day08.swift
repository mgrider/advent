import Foundation

class Day08 {

    func part1() {
        let input = inputArray()

        var outputDigits = [Substring]()
        for line in input {
            let outputs = line.split(separator: "|")[1].split(separator: " ")
            outputDigits.append(contentsOf: outputs)
        }

//        print("outputs: \(outputDigits)")

        var number = 0
        for outputDigit in outputDigits {
            if outputDigit.count == 2 // 1
                || outputDigit.count == 4 // 4
                || outputDigit.count == 3 // 7
                || outputDigit.count == 7 // 8
            {
                number = number + 1
            }
        }

        print("part1 = \(number)")
    }

    func part2() {
        let input = inputArray()

        var total = 0
        for line in input {

            let parts = line.split(separator: "|")
            let inputDigits = parts[0].split(separator: " ").map { String($0) }
            let outputDigits = parts[1].split(separator: " ").map { String($0) }

            var digitLUT = Dictionary<String,String>()
            guard let oneChars = inputDigits.filter({ $0.count == 2 }).first?.sorted() else {
                print("can't find one")
                assertionFailure()
                return
            }
            let one = String(oneChars)
            digitLUT[one] = "1"
            guard let fourChars = inputDigits.filter({ $0.count == 4 }).first?.sorted() else {
                print("can't find four")
                return
            }
            let four = String(fourChars)
            digitLUT[four] = "4"
            if let seven = inputDigits.filter({ $0.count == 3 }).first?.sorted() {
                digitLUT[String(seven)] = "7"
            }
            if let eight = inputDigits.filter({ $0.count == 7 }).first?.sorted() {
                digitLUT[String(eight)] = "8"
            }
            var allSixes = inputDigits.filter({ $0.count == 6 })
            guard let nineChars = allSixes.filter({ $0.containsAllCharactersIn(four) }).first else {
                print("can't find nine")
                assertionFailure()
                return
            }
            let nine = String(nineChars.sorted())
            digitLUT[nine] = "9"
            allSixes.remove(at: allSixes.firstIndex(of: nineChars)!)
            guard let sixChars = allSixes.filter({ !$0.containsAllCharactersIn(one) }).first else {
                print("can't find six")
                assertionFailure()
                return
            }
            let six = String(sixChars.sorted())
            digitLUT[six] = "6"
            allSixes.remove(at: allSixes.firstIndex(of: sixChars)!)
            guard let zeroChars = allSixes.first?.sorted() else {
                print("can't find nine")
                assertionFailure()
                return
            }
            let zero = String(zeroChars)
            digitLUT[zero] = "0"
            var allFives = inputDigits.filter({ $0.count == 5 })
            guard let threeChars = allFives.filter({ $0.containsAllCharactersIn(one) }).first else {
                print("can't find three")
                assertionFailure()
                return
            }
            let three = String(threeChars.sorted())
            digitLUT[three] = "3"
            allFives.remove(at: allFives.firstIndex(of: threeChars)!)
            let fourMinusOne = four.removingCharactersIn(string: one)
            guard let fiveChars = allFives.filter({ $0.containsAllCharactersIn(fourMinusOne) }).first else {
                print("can't find five")
                assertionFailure()
                return
            }
            let five = String(fiveChars.sorted())
            digitLUT[five] = "5"
            allFives.remove(at: allFives.firstIndex(of: fiveChars)!)
            guard let twoChars = allFives.first?.sorted() else {
                print("can't find two")
                return
            }
            let two = String(twoChars)
            digitLUT[two] = "2"

            var digits = ""
            for digit in outputDigits {
                let sorted = String(digit.sorted())
                guard let stringDigit = digitLUT[sorted] else {
                    assertionFailure("couldn't find string \(sorted) in LUT")
                    return
                }
                digits.append(stringDigit)
            }
            if let toAdd = Int(digits) {
                total = total + toAdd
            }
        }

        print("part2 = \(total)")
    }

    private func inputArray() -> [String] {
//        return stringArray(fromFile: "Day08-sample.txt")
        return stringArray(fromFile: "Day08.txt")
    }

    func perform() {
        part1()
        part2()
    }
}
