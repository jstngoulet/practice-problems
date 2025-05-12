import Foundation

class FindAllDuplicates: Problem {
    /**
     Given an array of integers where 1 <= a[i] <= n (n = size of array),
     some elements appear twice and others appear once.
    
     Find all the elements that appear twice.
    
     - Parameter nums: The array of integers.
     - Returns: An array of all duplicates found.
     */
    func findDuplicates(_ nums: [Int]) -> [Int] {
        // Implementation goes here
        var duplicates: [Int: Int] = [:]
        
        for num in nums {
            duplicates[num, default: 0] += 1
        }
        
        return duplicates.filter { $0.value > 1 }.keys.map { $0 }

    }

    override func performTests() {
        print("=== FindAllDuplicates Tests ===")
        let header = "| #  | Input                | Expected         | Actual           | Pass |"
        let separator = String(repeating: "-", count: header.count)

        typealias TestCase = (input: [Int], expected: [Int])
        let tests: [TestCase] = [
            ([4, 3, 2, 7, 8, 2, 3, 1], [2, 3]),
            ([1, 1, 2], [1]),
            ([1], []),
            ([2, 2, 2], [2]),
            ([5, 4, 6, 7, 9, 3, 10, 9, 5, 6], [5, 6, 9]),
            ([], []),
            ([1, 2, 3, 4, 5], []),
            ([10, 2, 5, 10, 9, 1, 1, 4, 3, 7], [1, 10]),
            ([2, 2], [2]),
            ([3, 3, 3, 3], [3]),
        ]

        print(separator)
        print(header)
        print(separator)

        for (i, test) in tests.enumerated() {
            let result = Set(findDuplicates(test.input))
            let expected = Set(test.expected)
            let passed = result == expected ? "✅" : "❌"

            let idx = "\(i + 1)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let inputStr = "\(test.input)".padding(toLength: 20, withPad: " ", startingAt: 0)
            let expectedStr = "\(Array(expected))".padding(
                toLength: 17, withPad: " ", startingAt: 0)
            let actualStr = "\(Array(result))".padding(toLength: 17, withPad: " ", startingAt: 0)
            let passStr = passed.padding(toLength: 4, withPad: " ", startingAt: 0)

            print("| \(idx) | \(inputStr) | \(expectedStr) | \(actualStr) | \(passStr) |")
        }

        print(separator)
    }
}
