import Foundation

class FirstNonRepeatingString: Problem {
    
    /**
        🧩 Problem Title: First Unique Character in a String

        📝 Problem Description:
        Given a string s, find the first non-repeating character in it and return its index. If it doesn't exist, return -1.

        Write a function in Swift:
        ```swift
        func firstUniqChar(_ s: String) -> Int
        ```
        
        🔍 Example 1:
        ```swift
        let result = firstUniqChar("leetcode")
        // Output: 0
        // 'l' is the first character that appears only once
        ```
        
        🔍 Example 2:
        ```swift
        let result = firstUniqChar("loveleetcode")
        // Output: 2
        // 'v' is the first unique character
        ```
        
        🔍 Example 3:
        ```swift
        let result = firstUniqChar("aabb")
        // Output: -1
        // All characters repeat
        ```
        
        ✅ Constraints:
        • 1 <= s.count <= 10^5
        • s contains only lowercase English letters.
        
        💡 Hint:
        • Use a hash map to count character frequencies.
        • Then, iterate through the string to find the first character with a count of 1.
    */
    
    override func performTests() {
        typealias TestCase = (s: String, expected: Int)
        let tests: [TestCase] = [
            ("leetcode", 0),             // 'l' is the first unique
            ("loveleetcode", 2),         // 'v' is the first unique
            ("aabb", -1),                // all characters repeat
            ("xxyz", 2),                 // 'y' is the first unique
            ("abcabcde", 6),             // 'd' is the first unique
            ("a", 0),                    // single character
            ("", -1),                    // empty string edge case
            ("zxcvbnmasdfghjklqwertyuiop", 0), // all unique
            ("aaabcccdeeef", 3),         // 'b' is the first unique
            ("ababccdd", -1)             // no unique character
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = firstUniqChar(test.s)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "PASSED" : "FAILED")\t\tResult: \(result)\t\t\(test.s)")
        }
    }
    
    func firstUniqChar(_ s: String) -> Int {
        var foundLetters: [Character: [Int]] = [:]    //  Character and their indices
        
        for (iter, char) in s.enumerated() {
            foundLetters[char, default: []] += [iter]
        }
        
        //  Now, find the first with only 1
        for char in s {
            if let indicesFound = foundLetters[char]
            , indicesFound.count == 1 {
                return indicesFound[0]
            }
        }
        
        return -1
    }
    
}