//
//  AnagramCounts.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//

import Foundation

class AnagramCounts: NSObject {
    /**
     # Problem: **Find All Anagrams in a String**
     
     ## Problem Statement:
     Given a string `s` and a string `p`, find all the start indices of `p`'s anagrams in `s`. The order of output does not matter.
     
     An **Anagram** of a string is another string that contains the same characters, but the order may be different. For example, `"abc"` is an anagram of `"cab"`, `"bca"`, etc.
     
     ## Function Signature:
     ```swift
     func findAnagrams(_ s: String, _ p: String) -> [Int]
     ```
     
     Input:
     
     s: A string s where you need to find anagrams of string p. The length of s is between 1 and 10^4.
     p: A string p whose anagrams need to be found in s. The length of p is between 1 and 100.
     Output:
     
     A list of start indices of p's anagrams in s. If no such anagram is found, return an empty list.
     Example:
     ```swift
     let s = "cbaebabacd"
     let p = "abc"
     findAnagrams(s, p)  // Output: [0, 6]
     ```
     
     Explanation:
     
     The substring with start index = 0 is "cba", which is an anagram of "abc".
     The substring with start index = 6 is "bac", which is an anagram of "abc".
     Constraints:
     
     Both strings are non-empty.
     The length of the strings is constrained to 1 ≤ |s| ≤ 10^4 and 1 ≤ |p| ≤ 100.
     Hint:
     
     You can use a sliding window approach with two hash maps (or arrays) to compare character frequencies efficiently.
     Notes:
     
     The problem is similar to finding "substring with exactly the same characters as another string". The sliding window can help reduce the time complexity from O(n^2) to O(n).
     */
    override init() {
        super.init()
        performTests()
    }
    
    func performTests() {
        let testCases: [(s: String, p: String, expected: [Int])] = [
            ("cbaebabacd", "abc", [0, 6]),  // "cba" at index 0, "bac" at index 6
            ("abab", "ab", [0, 1, 2]),  // "ab" at indices 0, 1, and 2
            ("a", "a", [0]),  // Single character match
            ("xyzabc", "abc", [3]),  // "abc" at index 3
            ("aaaaaaaaaaa", "aa", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]),  // Multiple overlapping "aa"
            ("abcdefg", "hij", []),  // No matching anagram
            ("abacbabc", "abc", [1, 2, 3, 5]) // "abc" found at multiple positions
        ]
        
        // Run test cases
        testCases.forEach { testCase in
            let result = findAnagrams(testCase.s, testCase.p)
            let passed = result == testCase.expected
            print("Input: \"\(testCase.s)\", \"\(testCase.p)\" -> Output: \(result) | Expected: \(testCase.expected) | Pass: \(passed ? "✅" : "❌")")
        }
    }
    
    /// Finds the anagram indices of the provided string, `p` in the original string, `s`
    /// - Parameters:
    ///   - s: The original string in which is going to find anagrams
    ///   - p: the string we want to find anagrams of
    /// - Returns: <#description#>
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        var anagramIndices: [Int] = []
        var parentIndex: Int = 0
        
        //  Reference
        let baseCharacters: [Character] = Array(s)
        let count: Int = baseCharacters.count
        
        let anagramCharacters: [Character] = Array(p)
        let windowLength: Int = anagramCharacters.count
        
        //  We are going to need to run though with 2 loops (nested)
        //  as there will be a rolling window for †he start and end indices.
        while parentIndex + windowLength <= count {
            
            let currentWindow = baseCharacters[parentIndex..<windowLength + parentIndex]
            
            //  Check the current window for anagrams
            var anagramFound: Bool = true
            
            for anagramChar in anagramCharacters {
                if !currentWindow.contains(anagramChar) {
                    anagramFound = false
                    break
                }
            }
            
            if anagramFound {
                anagramIndices.append(parentIndex)
            }
            
            parentIndex += 1
        }
        
        return anagramIndices
    }
}
