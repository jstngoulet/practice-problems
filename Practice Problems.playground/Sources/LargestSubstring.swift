//
//  LargestSubstring.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//
import Foundataion

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
        let testCases: [(input: String, expected: Int)] = [
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
        
        for test in testCases {
            let result = lengthOfLongestSubstring(test.input)
            let isPassing = result == test.expected
            print("Input: \"\(test.input)\" -> Output: \(result) | Expected: \(test.expected) | Pass: \(isPassing ? "✅" : "❌")")
        }
        
    }
    
    func lengthOfLongestSubstring(_ str: String) -> Int {
        
        var startPointer: Int = 0
        var endPointer: Int = 0
        var seenCharacters: Set<Character> = []
        var maxLength: Int = 0
        var characters = Array(str)
        
        while endPointer < characters.count {
            let currentChar = characters[endPointer]
            
            while seenCharacters.contains(currentChar) {
                seenCharacters.remove(characters[startPointer])
                startPointer += 1
            }
            
            seenCharacters.insert(currentChar)
            maxLength = max(maxLength, seenCharacters.count)
            endPointer += 1
        }
        
        return maxLength
    }
}
