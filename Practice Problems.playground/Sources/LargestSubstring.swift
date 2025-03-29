//
//  LargestSubstring.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//
import Foundation

class LargestSubstring: NSObject {
    
    /**
     Problem: Find the Longest Substring Without Repeating Characters
     Write a function lengthOfLongestSubstring that takes a string as input and returns the length of the longest substring without repeating characters.
     
     Function Signature:
     ```swift
     func lengthOfLongestSubstring(_ s: String) -> Int
     ```
     
     Example:
     ```swift
     lengthOfLongestSubstring("abcabcbb") // Should return 3 ("abc")
     lengthOfLongestSubstring("bbbbb") // Should return 1 ("b")
     lengthOfLongestSubstring("pwwkew") // Should return 3 ("wke")
     ```
     Constraints:
     The input string is non-empty.
     The string has a maximum length of 1000 characters.
     
     Hints:
     Use a sliding window approach to keep track of the current substring.
     You can use a dictionary or a set to keep track of characters that you've seen so far.
     */
    
    override init() {
        super.init()
        performTests()
    }
    
    func performTests() {
        typealias TestCase = (input: String, expected: Int)
        let testCases: [TestCase] = [
            ("abcabcbb", 3),    // "abc"
            ("bbbbb", 1),       // "b"
            ("pwwkew", 3),      // "wke"
            ("", 0),            // Empty string
            ("a", 1),           // Single character
            ("au", 2),          // "au"
            ("dvdf", 3),        // "vdf"
            ("abcdef", 6),      // "abcdef" - all unique characters
            ("abba", 2),        // "ab" or "ba"
            ("tmmzuxt", 5),     // "mzuxt"
            ("abcddefghijklmnop", 13), // "defghijklmnop"
            ("aaaaaaaabcdef", 6),      // "abcdef"
            ("xyzxyzxyzxyz", 3),       // "xyz"
            ("abcdeafgh", 7),   // "bcdeafg"
            ("abccba", 3),      // "abc" or "cba"
            ("aabbccddeeffgghhiijjkk", 2), // "ab", "bc", etc.
            ("longestsubstringtest", 8), // "ubstring"
            ("  ", 1),          // Space character only
            ("a b c d e f g", 7), // Spaces included, all unique
            ("abbaabbaabba", 2), // "ab"
            ("1234567890", 10),  // All numbers unique
            ("123123412341234", 4) // "1234"
        ]
        
        // 🔍 Run test cases
        let colWidths = [8, (testCases.map { Array($0.input).description.count }.max() ?? 0), 10, 10, 8]  // Adjust column widths dynamically
        
        func formatRow(_ values: [String]) -> String {
            return zip(values, colWidths).map { $0.padding(toLength: $1, withPad: " ", startingAt: 0) }.joined(separator: "| ")
        }
        
        let header = formatRow(["Test #", "Input", "Expected", "Output", "Result"])
        let separator = String(repeating: "-", count: header.count)
        
        print(separator)
        print(header)
        print(separator)
        
        for (index, testCase) in testCases.enumerated() {
            let output = lengthOfLongestSubstring(testCase.input)
            let passed = output == testCase.expected ? "✅" : "❌"
            
            let inputStr = testCase.input.map { "\($0)" }.joined(separator: ", ")
            let row = formatRow(["\(index + 1)", "[\(inputStr)]", "\(testCase.expected)", "\(output)", passed])
            
            print(row)
        }
        
        print(separator)
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        let sArray: [Character] = Array(s)
        var leftPointer: Int = 0
        var rightPointer: Int = 0
        var currentSet: Set<Character> = []
        var currentMax: Int = 0
        
        while rightPointer < s.count {
            let currentChar = sArray[rightPointer]
            
            while currentSet.contains(currentChar) {
                currentSet.remove(sArray[leftPointer])
                leftPointer += 1
            }
            
            currentSet.insert(currentChar)
            currentMax = max(currentSet.count, currentMax)
            rightPointer += 1
        }
        
        return currentMax
    }
}
