import Foundation

class ValidAnagram: Problem {
    /**
     Determines if two strings are anagrams of each other.
    
     - Parameters:
       - s: The first string.
       - t: The second string.
     - Returns: True if "t" is an anagram of "s", false otherwise.
     */
    func isAnagram(_ s: String, _ t: String) -> Bool {
        //  One Liner
        // return s.sorted() == t.sorted()
        
        //  Optimized
        if s.count != t.count { return false }
        
        var letterCounts: [Character: Int] = [:]
        for char in s {
            letterCounts[char, default: 0] += 1
        } 
        
        for char in t {
            letterCounts[char, default: 0] -= 1
            if letterCounts[char, default: 0] <= 0 {
                letterCounts.removeValue(forKey: char)
            }
        }
        
        return letterCounts.isEmpty
    }

    override func performTests() {
        print("=== ValidAnagram Tests ===")
        let header = "| #  | s            | t            | Expected | Actual | Pass |"
        let separator = String(repeating: "-", count: header.count)

        typealias TestCase = (s: String, t: String, expected: Bool)
        let tests: [TestCase] = [
            // Simple anagram
            ("anagram", "nagaram", true),
            // Different lengths
            ("rat", "car", false),
            // Same letters, different counts
            ("aacc", "ccac", false),
            // Empty strings
            ("", "", true),
            // Single letter
            ("a", "a", true),
            // Single letter mismatch
            ("a", "b", false),
            // Complex anagram
            ("listen", "silent", true),
            // Completely different strings
            ("abc", "def", false),
            // Upper and lowercase mismatch
            ("Abc", "abc", false),
            // Special characters
            ("a#b!c", "c!b#a", true),
        ]

        print(separator)
        print(header)
        print(separator)

        for (i, test) in tests.enumerated() {
            let result = isAnagram(test.s, test.t)
            let passed = result == test.expected ? "✅" : "❌"

            let idx = "\(i + 1)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let sStr = "\(test.s)".padding(toLength: 12, withPad: " ", startingAt: 0)
            let tStr = "\(test.t)".padding(toLength: 12, withPad: " ", startingAt: 0)
            let expected = "\(test.expected)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let actual = "\(result)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let passStr = passed.padding(toLength: 4, withPad: " ", startingAt: 0)

            print("| \(idx) | \(sStr) | \(tStr) | \(expected) | \(actual) | \(passStr) |")
        }

        print(separator)
    }
}
