import Foundation 

class LongestSubstring: Problem {
    /**
    🧩 Problem Title: Longest Substring Without Repeating Characters

    📝 Problem Description:
    Given a string s, find the length of the longest substring without repeating characters.

    Implement the function in Swift:
    ```swift
    func lengthOfLongestSubstring(_ s: String) -> Int
    ```
    
    🔍 Example 1:
    ```swift
    let result = lengthOfLongestSubstring("abcabcbb")
    // Output: 3
    // The answer is "abc", with the length of 3.
    ```
    
    🔍 Example 2:
    ```swift
    let result = lengthOfLongestSubstring("bbbbb")
    // Output: 1
    // The answer is "b", with the length of 1.
    ```
    
    🔍 Example 3:
    ```swift
    let result = lengthOfLongestSubstring("pwwkew")
    // Output: 3
    // The answer is "wke", with the length of 3.
    ```
    ✅ Constraints:
    • 0 <= s.count <= 5 * 10^4
    • s consists of English letters, digits, symbols, and spaces.
    
    💡 Hint:
    • Use a sliding window with a Set to track characters in the current window.
    • When a duplicate character is found, slide the start index forward until the window is unique again.
    */
    
    override func performTests() {
        typealias TestCase = (s: String, expected: Int)
        let tests: [TestCase] = [
            ("abcabcbb", 3),       // "abc"
            ("bbbbb", 1),          // "b"
            ("pwwkew", 3),         // "wke"
            ("", 0),               // empty string
            (" ", 1),              // single space
            ("au", 2),             // "au"
            ("dvdf", 3),           // "vdf"
            ("anviaj", 5),         // "nviaj"
            ("tmmzuxt", 5),        // "mzuxt"
            ("abba", 2),           // "ab" or "ba"
            ("aab", 2),            // "ab"
            ("abcdeafgh", 8),      // "bcdeafgh"
            ("aabcabcbb", 3),      // "abc"
            ("abcdef", 6),         // all unique
            ("abcdabcdeabcd", 5)   // "abcde"
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = lengthOfLongestSubstring(test.s)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "PASSED" : "FAILED")\t\(result)\t\(test.s)")
        }
    }
    /**
        How this wil work: 
        For every letter in the string `s`, we are going to have a starter and an ending
        pointer. 
        The ending pointer is going to go through the list once (start to end)
        while the starting pointer is going to reset for every window.
        
        What is going to happen is we are going to have 2 loops, iterating through each time.
        For example, given the string `abcabcbb` (example 1), we are going to have this pattern: 
         
        Example Breakdown (for: "abcabcbb"): 
        a           ✅
        ab          ✅
        abc         ✅
        abca        ❌  Shift
         bca        ✅
         bcab       ❌  Shift
          cab       ✅
          cabc      ❌  Shift
           abc      ✅
           abcb     ❌  Shift
            bcb     ❌  Shift
             cb     ✅
             cbb    ❌  Shift
              bb    ❌  Shift
               b    ✅  Final Letter
                        Max Length: 3
        
        Simpler Breakdown (for: "abcdeafgh"): 
        a           ✅
        ab          ✅
        abc         ✅
        abcd        ✅
        abcde       ✅
        abcdea      ❌  A exists, so we need to shift
         bcdea      ✅
         bcdeaf     ✅
         bcdeafg    ✅
         bcdeafgh   ✅  Final letter
                        Max Length: 8
    */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        var longestSubstring: Int = 0
        let charArray: [Character] = Array(s)
        var workingWindow: Set<Character> = []
        var leftIter: Int = 0, rightIter: Int = 0
        
        while rightIter < s.count {
           let rightChar = charArray[rightIter]
           let leftChar: Character = charArray[leftIter]
           
           if !workingWindow.contains(rightChar) {
                workingWindow.insert(rightChar)
                longestSubstring = max(longestSubstring, abs(rightIter - leftIter) + 1)
                rightIter += 1
           } else {
                workingWindow.remove(leftChar)
                leftIter += 1
           }
        }
        
        return longestSubstring
    }
    
}