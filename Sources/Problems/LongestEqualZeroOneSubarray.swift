import Foundation

/**
 Finds the length of the longest contiguous subarray with equal number of 0s and 1s.

 - Parameter nums: The binary array of integers (0s and 1s).
 - Returns: The maximum length of a balanced subarray.
 */
class LongestEqualZeroOneSubarray: Problem {

    typealias TestCase = (input: [Int], expected: Int)

    override func performTests() {
        print("Running tests for: \(Self.self)")

        let tests: [TestCase] = [
            // Equal 0s and 1s
            (input: [0, 1], expected: 2),

            // Shortest balance
            (input: [0, 1, 0], expected: 2),

            // Full array balanced
            (input: [0, 1, 1, 0], expected: 4),

            // Largest subarray in the middle
            (input: [0, 0, 1, 1, 0], expected: 4),

            // All zeros
            (input: [0, 0, 0, 0], expected: 0),

            // All ones
            (input: [1, 1, 1, 1], expected: 0),

            // Alternating pattern
            (input: [0, 1, 0, 1, 0, 1], expected: 6),

            // Balance happens later
            (input: [1, 1, 1, 0, 0, 0], expected: 6),

            // Empty array
            (input: [], expected: 0),

            // Single value
            (input: [1], expected: 0)
        ]

        func pad(_ string: String, to length: Int, emojiAdjustment: Bool = false) -> String {
            let emojiExtra = (emojiAdjustment && (string.contains("✅") || string.contains("❌"))) ? 1 : 0
            let visualLength = string.count + emojiExtra
            if visualLength >= length {
                return String(string.prefix(length))
            }
            return string + String(repeating: " ", count: length - visualLength)
        }

        let columnWidths = (input: 30, expected: 10, actual: 10, pass: 6)

        let header: String = "| " + pad("Input", to: columnWidths.input)
            + " | " + pad("Expected", to: columnWidths.expected)
            + " | " + pad("Actual", to: columnWidths.actual)
            + " | " + pad("Pass", to: columnWidths.pass)
            + " |"

        let separator: String = "|"
            + String(repeating: "-", count: columnWidths.input + 2) + "|"
            + String(repeating: "-", count: columnWidths.expected + 2) + "|"
            + String(repeating: "-", count: columnWidths.actual + 2) + "|"
            + String(repeating: "-", count: columnWidths.pass + 2) + "|"

        print(header)
        print(separator)

        for test in tests {
            let result = findMaxLength(test.input)
            let pass = result == test.expected ? "✅" : "❌"
            let inputStr = "\(test.input.prefix(6))" + (test.input.count > 6 ? "..." : "")
            let passStr = pad(pass, to: columnWidths.pass, emojiAdjustment: true)

            print("| \(pad(inputStr, to: columnWidths.input))"
                + " | \(pad(String(test.expected), to: columnWidths.expected))"
                + " | \(pad(String(result), to: columnWidths.actual))"
                + " | \(passStr) |")
        }
    }

    /**
     Returns the length of the longest subarray with equal number of 0s and 1s.

     - Parameter nums: The input binary array.
     - Returns: Length of the longest balanced subarray.
     */
    func findMaxLength(_ nums: [Int]) -> Int {
        var sumToIndex: [Int: Int] = [0: -1]
        var sum = 0
        var currentMax = 0

        for (index, num) in nums.enumerated() {
            sum += num == 0 ? -1 : 1
            if let foundIndex = sumToIndex[sum] {
                currentMax = max(currentMax, index - foundIndex)
            } else {
                sumToIndex[sum] = index
            }
        }

        return currentMax
    }
}
