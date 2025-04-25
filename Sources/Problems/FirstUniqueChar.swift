import Foundation

class FirstUniqueCharacter2: Problem {
    /**
     Finds the index of the first non-repeating character in a string.
    
     - Parameter s: The input string to search.
     - Returns: The zero-based index of the first unique character, or -1 if none exists.
     */
    func firstUniqChar(_ s: String) -> Int {
        //Create a map, then go through again and determine count
        var map: [Character: Int] = [:]
        for char in s {
            map[char, default: 0] += 1
        }
        
        for (iter, char) in s.enumerated() {
            if map[char] == 1 { return iter }
        }
        
        return -1
    }

    override func performTests() {
        print("=== FirstUniqueCharacter Tests ===")
        let header = "| #  | Input         | Exp | Act | Pass |"
        let separator = String(repeating: "-", count: header.count)

        typealias TestCase = (input: String, expected: Int)
        let tests: [TestCase] = [
            // Empty string should return -1
            ("", -1),
            // Single character string returns index 0
            ("a", 0),
            // First char is unique
            ("leetcode", 0),
            // First unique char is 'v'
            ("loveleetcode", 2),
            // No unique characters
            ("aabb", -1),
            // Unique character in middle
            ("xxyz", 2),
            // Unique character at end
            ("aabbccdde", 8),
            // Single-character string test
            ("z", 0),
            // Unique character after repeats
            ("aaabc", 3),
            // Larger repeats with unique at end
            ("aaabcccddde", 3),
        ]

        print(separator)
        print(header)
        print(separator)

        for (i, test) in tests.enumerated() {
            let result = firstUniqChar(test.input)
            let passed = result == test.expected ? "✅" : "❌"

            let idx = "\(i + 1)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let inputStr = "\(test.input)".padding(toLength: 13, withPad: " ", startingAt: 0)
            let expected = "\(test.expected)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let actual = "\(result)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let passStr = passed.padding(toLength: 4, withPad: " ", startingAt: 0)

            print("| \(idx) | \(inputStr) | \(expected) | \(actual) | \(passStr) |")
        }

        print(separator)
    }
}
