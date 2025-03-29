//
//  MinWindowOfChars.swift
//  
//
//  Created by Justin Goulet on 3/27/25.
//

import Foundation

class MinWindowOfChars: NSObject {
    
    /**
     Problem: Find the Minimum Window Substring
     Description
     
     Given two strings, s and t, find the smallest substring in s that contains all the characters of t (including duplicates). If no such substring exists, return an empty string "".
     
     Constraints
     
     0 ≤ s.length ≤ 10^5
     0 ≤ t.length ≤ 10^5
     s and t consist of uppercase and lowercase English letters.
     Examples
     
     | Input                               |  Output |     Explanation   |
     | ----------------------------------- | ------- | ----------------- |
     | s = "ADOBECODEBANC", t = "ABC"      |  "BANC" |  The substring "BANC" is the smallest window containing "A", "B", and "C". |
     | s = "a", t = "a"                    |  "a"    |  The only substring is "a", which contains "a". |
     | s = "a", t = "aa"                   |  ""     |  The string s does not have two "a" characters. |
     | s = "abc", t = "bc"                 |  "bc"   |  The substring "bc" contains all characters from "t". |
     
     Function Signature
     ```swift
     func minWindow(_ s: String, _ t: String) -> String
     ```
     
     Hints
     Use the Sliding Window approach with two pointers (left and right).
     Maintain a frequency count of characters in t and track if the window is valid.
     Expand the window by moving the right pointer, and contract it by moving the left pointer when all required characters are inside.
     Keep track of the minimum window found.
     
     */
    func performTests() {
        let testCases: [(s: String, t: String, expected: String)] = [
            ("ADOBECODEBANC", "ABC", "BANC"),
            ("a", "a", "a"),
            ("a", "aa", ""),
            ("abc", "bc", "bc"),
            ("aa", "aa", "aa"),
            ("aaflslflsldkalskaaa", "aaa", "aaa"),
            ("abcd", "xyz", ""),
            ("ab", "b", "b"),
            ("ab", "a", "a"),
            ("abcdefgh", "hgf", "fgh"),
            ("abacabadabacaba", "abc", "bac"),
            ("aaabbaac", "abc", "baac")
        ]
        
        for (index, testCase) in testCases.enumerated() {
            let output = minWindow(testCase.s, testCase.t)
            let passed = output == testCase.expected
            print("Test \(index + 1): \tInput: (\(testCase.s), \(testCase.t)) -> Output: \(output) | Expected: \(testCase.expected) | Pass: \(passed ? "✅" : "❌")")
        }
    }
    /*
     Hints
     Use the Sliding Window approach with two pointers (left and right).
     Maintain a frequency count of characters in t and track if the window is valid.
     Expand the window by moving the right pointer, and contract it by moving the left pointer when all required characters are inside.
     Keep track of the minimum window found.
     */
    /**func minWindow(_ s: String, _ t: String) -> String {
     guard !t.isEmpty, !s.isEmpty, s.count >= t.count else { return "" }
     
     let sArray = Array(s)
     let tArray = Array(t)
     
     var substringLetterFrequency: [Character: Int] = [:]
     
     //  Popular the frequency
     for char in tArray {
     substringLetterFrequency[char, default: 0] += 1
     }
     
     //  Now that we have the letter frequency of each letter
     //  We can now run through and create our "window".
     //  This window will have 2 pointers, 1 on the left and
     //  one on the right
     var startPointer: Int = 0
     
     //  Reference to the result
     var resultLength: Int = Int.max
     var result: String = ""
     
     while startPointer < sArray.count {
     var currentResult: [Character] = []
     var workingWindow: [Character: Int] = [:]
     
     for char in sArray[startPointer...] {
     workingWindow[char, default: 0] += 1
     currentResult.append(char)
     
     //  Now, check to see if the working window has all the required counts
     //  Could include more than
     var shouldContinueChecking: Bool = false
     for (key, value) in substringLetterFrequency {
     if workingWindow[key, default: 0] < value {
     shouldContinueChecking = true
     break
     }
     }
     
     if !shouldContinueChecking, currentResult.count < resultLength {
     result = String(currentResult)
     resultLength = result.count
     }
     }
     startPointer += 1
     }
     
     return result
     }*/
    
    func minWindow(_ s: String, _ t: String) -> String {
        guard !t.isEmpty, !s.isEmpty, s.count >= t.count else { return "" }
        
        let sArray: [Character] = Array(s)
        var requiredStringCounts: [Character: Int] = [:]
        
        //  Get the required char count of each char needed
        for char in t {
            requiredStringCounts[char, default: 0] += 1
        }
        
        //  Now that we have a baseline, set up some values for our "window"
        var left: Int = 0, right: Int = 0
        var result: String = ""
        var minLength: Int = Int.max
        var requiredChars: Int = requiredStringCounts.count
        var formedChars: Int = 0
        var currentWindow: [Character: Int] = [:]
        
        //  Now, start the loop, moving the endIndex after each parent
        while right < sArray.count {
            let rightChar = sArray[right]
            currentWindow[rightChar, default: 0] += 1
            
            if let needed = requiredStringCounts[rightChar], currentWindow[rightChar] == needed {
                formedChars += 1
            }
            
            while formedChars == requiredChars {
                let windowSize = right - left + 1
                if windowSize < minLength {
                    minLength = windowSize
                    result = String(sArray[left...right])
                }
                
                let leftChar = sArray[left]
                currentWindow[leftChar, default: 0] -= 1
                
                if let needed = requiredStringCounts[leftChar],
                   currentWindow[leftChar, default: 0] < needed {
                    formedChars -= 1
                }
                
                left += 1
            }
            
            right += 1
        }
        
        return result
    }
}
