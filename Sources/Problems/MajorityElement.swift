import Foundation

class MajorityElement: Problem {
    /**
     Finds the majority element in an array, which is the element that appears more than n/2 times.
     It is guaranteed that a majority element always exists.
    
     - Parameter nums: The array of integers.
     - Returns: The majority element.
     */
    func majorityElement(_ nums: [Int]) -> Int {
        let majorityNeeded: Int = nums.count / 2
        var itemCounts: [Int: Int] = [:]
        for num in nums {
            itemCounts[num, default: 0] += 1
            
            if let newCount = itemCounts[num], newCount > majorityNeeded
            { return num }
        }
        
        return -1
    }

    override func performTests() {
        print("=== MajorityElement Tests ===")
        let header = "| #  | Input                  | Exp  | Act  | Pass |"
        let separator = String(repeating: "-", count: header.count)

        typealias TestCase = (input: [Int], expected: Int)
        let tests: [TestCase] = [
            // Simple case with clear majority
            ([3, 3, 4], 3),
            // Majority element is at the start
            ([2, 2, 1, 1, 1, 2, 2], 2),
            // Majority element is the only element
            ([1], 1),
            // Even length array
            ([1, 1, 2, 2, 2, 2], 2),
            // Majority element appears throughout
            ([5, 5, 5, 1, 5, 2, 5], 5),
            // Long repetition at end
            ([1, 2, 3, 4, 4, 4, 4, 4], 4),
            // Larger number majority
            ([10, 10, 10, 1, 2], 10),
            // All same
            ([9, 9, 9, 9, 9], 9),
            // Alternate non-majorities
            ([8, 8, 7, 7, 8], 8),
            // Negative majority
            ([-1, -1, -1, 2, 3], -1),
        ]

        print(separator)
        print(header)
        print(separator)

        for (i, test) in tests.enumerated() {
            let result = majorityElement(test.input)
            let passed = result == test.expected ? "✅" : "❌"

            let idx = "\(i + 1)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let inputStr = "\(test.input)".padding(toLength: 22, withPad: " ", startingAt: 0)
            let expected = "\(test.expected)".padding(toLength: 4, withPad: " ", startingAt: 0)
            let actual = "\(result)".padding(toLength: 4, withPad: " ", startingAt: 0)
            let passStr = passed.padding(toLength: 4, withPad: " ", startingAt: 0)

            print("| \(idx) | \(inputStr) | \(expected) | \(actual) | \(passStr) |")
        }

        print(separator)
    }
}