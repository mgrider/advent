import Foundation

class Day16 {

    func part1() {
        var sum = 0

        for packet in packets {
            sum += versionSum(forPacket: packet)
        }

        let output = sum
        print("part1 = \(output)")
    }

    func versionSum(forPacket: Packet) -> Int {
        var sum = forPacket.version
        for packet in forPacket.subpackets {
            sum += versionSum(forPacket: packet)
        }
        return sum
    }

    func part2() {
        let output = packets.last!.value
        print("part2 = \(output)")
    }

    private func input() -> String {
//        return "620080001611562C8802118E34".binaryFromHexadecimal()

        return string(fromFile: "Day16.txt").binaryFromHexadecimal()

        return "A0016C880162017C3686B18A3D4780".binaryFromHexadecimal()
        return "D2FE28".binaryFromHexadecimal()
    }

    struct Packet {
        var version: Int
        var typeId: Int
        var value: Int = -1
        var bitCount: Int = 0
        var groups = [String]()
        var lengthOfSubpacketsInBits: Int = -1
        var numberOfSubsequentSubpackets: Int = -1
        var subpackets = [Packet]()
    }

    private func packetsFrom(binary: String) -> Packet {
        var pointerIndex = 0
        let binaryVersion = "\(binary[pointerIndex])\(binary[pointerIndex + 1])\(binary[pointerIndex + 2])"
        pointerIndex += 3
        let binaryPacketTypeId = "\(binary[pointerIndex])\(binary[pointerIndex + 1])\(binary[pointerIndex + 2])"
        pointerIndex += 3
        var currentPacket = Packet(version: binaryVersion.decimalFromBinary(), typeId: binaryPacketTypeId.decimalFromBinary())
        if currentPacket.typeId == 4 {
            while binary[pointerIndex] == "1" {
                currentPacket.groups.append("\(binary[pointerIndex+1])\(binary[pointerIndex + 2])\(binary[pointerIndex + 3])\(binary[pointerIndex + 4])")
                pointerIndex += 5
            }
            if binary[pointerIndex] == "0" {
                // last group!
                currentPacket.groups.append("\(binary[pointerIndex+1])\(binary[pointerIndex + 2])\(binary[pointerIndex + 3])\(binary[pointerIndex + 4])")
                pointerIndex += 5
                currentPacket.bitCount = pointerIndex
                currentPacket.value = currentPacket.groups.joined().decimalFromBinary()
                return currentPacket
            }
        } else {
            // operator packet
            let lengthType = binary[pointerIndex]
            pointerIndex += 1
            if lengthType == "0" {
                // next 15 bits represent subpacket length
                var totalSubpacketBitLength = ""
                for i in 0..<15 {
                    totalSubpacketBitLength.append(String(binary[pointerIndex+i]))
                }
                pointerIndex += 15
                currentPacket.lengthOfSubpacketsInBits = totalSubpacketBitLength.decimalFromBinary()
                currentPacket.bitCount = pointerIndex
                var subpacketBitLength = 0
                while subpacketBitLength < currentPacket.lengthOfSubpacketsInBits {
                    let newStart = binary.index(binary.startIndex, offsetBy: pointerIndex)
                    let remainingBinary = binary[newStart..<binary.endIndex]
                    let subpacket = packetsFrom(binary: String(remainingBinary))
                    currentPacket.subpackets.append(subpacket)
                    currentPacket.bitCount += subpacket.bitCount
                    pointerIndex += subpacket.bitCount
                    subpacketBitLength += subpacket.bitCount
                }
            } else {
                // next 11 bits represent number of subsequent subpackets
                var numberOfSubpacketsBits = ""
                for i in 0..<11 {
                    numberOfSubpacketsBits.append(String(binary[pointerIndex+i]))
                }
                pointerIndex += 11
                currentPacket.numberOfSubsequentSubpackets = numberOfSubpacketsBits.decimalFromBinary()
                currentPacket.bitCount = pointerIndex
                for _ in 0..<currentPacket.numberOfSubsequentSubpackets {
                    let newStart = binary.index(binary.startIndex, offsetBy: pointerIndex)
                    let remainingBinary = binary[newStart..<binary.endIndex]
                    let subpacket = packetsFrom(binary: String(remainingBinary))
                    currentPacket.subpackets.append(subpacket)
                    currentPacket.bitCount += subpacket.bitCount
                    pointerIndex += subpacket.bitCount
                }
            }
            // get operator packet values
            switch currentPacket.typeId {
            case 0:
                currentPacket.value = 0
                for subpacket in currentPacket.subpackets {
                    currentPacket.value += subpacket.value
                }
            case 1:
                for subpacket in currentPacket.subpackets {
                    if currentPacket.value == -1 {
                        currentPacket.value = subpacket.value
                    } else {
                        currentPacket.value *= subpacket.value
                    }
                }
            case 2:
                currentPacket.value = Int.max
                for subpacket in currentPacket.subpackets {
                    if subpacket.value < currentPacket.value {
                        currentPacket.value = subpacket.value
                    }
                }
            case 3:
                for subpacket in currentPacket.subpackets {
                    if subpacket.value > currentPacket.value {
                        currentPacket.value = subpacket.value
                    }
                }
            case 5:
                let first = currentPacket.subpackets.first!.value
                let second = currentPacket.subpackets.last!.value
                currentPacket.value = (first > second) ? 1 : 0
            case 6:
                let first = currentPacket.subpackets.first!.value
                let second = currentPacket.subpackets.last!.value
                currentPacket.value = (first < second) ? 1 : 0
            case 7:
                let first = currentPacket.subpackets.first!.value
                let second = currentPacket.subpackets.last!.value
                currentPacket.value = (first == second) ? 1 : 0
            default:
                break
            }
        }
        return currentPacket
    }

    var packets = [Packet]()

    func parseInput() {
        let input = input()
        packets.append(packetsFrom(binary: input))
    }

    func perform() {
        parseInput()
        part1()
        part2()
    }
}
