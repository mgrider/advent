import Foundation

class Day16 {

    func part1() {
        let input = input()
        let packets = packetsFrom(binary: input)

        var versionSum = 0
        for packet in packets {
            versionSum += packet.version
        }

        let output = versionSum
        print("part1 = \(output)")
    }

    func part2() {
//        let input = input()

        let output = ""
        print("part2 = \(output)")
    }

    private func input() -> String {
        return string(fromFile: "Day16.txt").binaryFromHexadecimal()

        return "A0016C880162017C3686B18A3D4780".binaryFromHexadecimal()
    }

    struct Packet {
        var version: Int
        var typeId: Int
        var bitCount: Int = 0
        var groups = [String]()
        var lengthOfSubpacketsInBits: Int = -1
        var numberOfSubsequentSubpackets: Int = -1
        var subpackets = [Packet]()
    }

    private func packetsFrom(binary: String) -> [Packet] {
        var packets = [Packet]()
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
                packets.append(currentPacket)
                return packets
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
                packets.append(currentPacket)
                var totalSubpacketIndex = 0
                while totalSubpacketIndex < currentPacket.lengthOfSubpacketsInBits {
                    let newStart = binary.index(binary.startIndex, offsetBy: pointerIndex)
                    let remainingBinary = binary[newStart..<binary.endIndex]
                    let subpackets = packetsFrom(binary: String(remainingBinary))
                    currentPacket.subpackets = subpackets
                    packets.append(contentsOf: subpackets)
                    for p in subpackets {
                        pointerIndex += p.bitCount
                        totalSubpacketIndex += p.bitCount
                    }
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
                packets.append(currentPacket)
                for _ in 0..<currentPacket.numberOfSubsequentSubpackets {
                    let newStart = binary.index(binary.startIndex, offsetBy: pointerIndex)
                    let remainingBinary = binary[newStart..<binary.endIndex]
                    let subpackets = packetsFrom(binary: String(remainingBinary))
                    currentPacket.subpackets.append(subpackets[0])
                    for p in subpackets {
                        pointerIndex += p.bitCount
                    }
                    packets.append(contentsOf: subpackets)
                }
            }
        }
        return packets
    }

    func perform() {
        part1()
        part2()
    }
}
