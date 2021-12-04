import Foundation

extension Int {

    /// Convert a string containing 0s and 1s to a decimal (`Int`) representation.
    /// Shamelessly modified from https://kalkicode.com/binary-to-decimal-conversion-in-swift
    static func decimalFromBinaryString(_ num: String) -> Int
    {
        let number = Array(num);
        // Assuming that number contains 0,1s
        // Used to store result
        var result: Int = 0;
        var bit: Int = 0;
        var n: Int = number.count - 1;
        // Display Binary number
//        print("Binary : ", num, terminator: "");
        // Execute given number in reverse order
        while (n >= 0)
        {
            if (number[n] == "1")
            {
                // When get binary 1
                result += (1 << (bit));
            }
            n = n - 1;
            // Count number of bits
            bit += 1;
        }
        // Display decimal result
//        print("  Decimal :  ",result);
        return result
    }
}
