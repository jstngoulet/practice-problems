import Foundation
import PlaygroundSupport

class DriverApplication: NSObject {
    override init() { super.init(); performTests() }
    
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
            print("Test \(index + 1): Input: (\(testCase.s), \(testCase.t)) -> Output: \(output) | Expected: \(testCase.expected) | Pass: \(passed ? "✅" : "❌")")
        }
    }
    
    func minWindow(_ s: String, _ t: String) -> String {
        return t
    }
}

DriverApplication()
PlaygroundPage.current.needsIndefiniteExecution = true
