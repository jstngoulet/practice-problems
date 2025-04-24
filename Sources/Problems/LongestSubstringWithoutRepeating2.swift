
/**
### **Problem: Longest Substring Without Repeating Characters**

#### **Problem Statement:**

Given a string `s`, find the length of the **longest substring** without repeating characters.

---

**Function Signature:**
```swift
func lengthOfLongestSubstring(_ s: String) -> Int
```
*/

import Foundation

class LongestSubstringWithoutRepeats2: Problem {
    
    /**
     Finds the length of the longest substring without repeating characters.
     
     - Parameter s: A string consisting of ASCII characters.
     - Returns: The length of the longest substring without duplicates.
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        /**
            Walkthrough:
            Given the string `"abcabcbb"`, we want to find the **length** of the longest substring without repeating characters.
        
            We'll use a **sliding window** approach with two pointers — `start` and `end` — to define the current valid window of unique characters.
        
            Here's how it plays out:
        
            Start     End     Current Window   Unique?   Max Length   Action
            -----     ---     --------------   -------   -----------  -------------------------
            0         0       "a"              ✅         1            Add 'a' to set
            0         1       "ab"             ✅         2            Add 'b'
            0         2       "abc"            ✅         3            Add 'c'
            0         3       "abca"           ❌         3            'a' is duplicate → move start
            1         3       "bca"            ✅         3            Remove 'a', add 'a'
            1         4       "bcab"           ❌         3            'b' is duplicate → move start
            2         4       "cab"            ✅         3            Remove 'b', add 'b'
            2         5       "cabc"           ❌         3            'c' is duplicate → move start
            3         5       "abc"            ✅         3            Remove 'c', add 'c'
            3         6       "abcb"           ❌         3            'b' is duplicate → move start
            4         6       "bcb"            ❌         3            'a' removed, 'b' still duplicate
            5         6       "cb"             ✅         3            Now valid again
            5         7       "cbb"            ❌         3            'b' duplicate again
            6         7       "b"              ✅         3            Only 'b'
        
            Final Max Length: 3
        
            ------------------------------------------------------------
        
            What we need:
            - Two pointers to define the window (`start` and `end`)
            - A Set to track current characters in the window
            - An `Int` to track the max length seen so far
        
            Steps:
            1. Initialize an empty Set, `start = 0`, `end = 0`, and `maxLength = 0`
            2. Loop with `end` over the characters in the string
                a. If `s[end]` is not in the set: insert it, update `maxLength`
                b. If `s[end]` **is** in the set: remove `s[start]` and increment `start` until `s[end]` is no longer in the set
            3. After finishing the loop, return `maxLength`
        
            This runs in O(n) time, since each character is visited at most twice (once by `end`, once by `start`)
        */

        var startIter: Int = 0, endIter: Int = 0
        let sArray: [Character] = Array(s)    //  For indexing operations
        var currentMax: Int = 0
        var currentSet: Set<Character> = []
        
        while endIter < sArray.count {
            let currentChar = sArray[endIter]
            //  Start off at a. 
            //  if a exists already, move other iter
            
            while currentSet.contains(currentChar) && startIter < endIter {
                let startChar = sArray[startIter]
                currentSet.remove(startChar)
                startIter += 1
            }
            
            currentSet.insert(currentChar)
            currentMax = max(currentMax, endIter - startIter + 1)
            endIter += 1
        }
        
        return currentMax
    }
    
    override func performTests() {
        print("Running tests for: LongestSubstringWithoutRepeats\n")
        
        struct TestCase {
            let input: String
            let expected: Int
        }
        
        let tests: [TestCase] = [
            // Test 1: Basic non-repeating substring at the start
            TestCase(input: "abcabcbb", expected: 3),
            // Test 2: All characters are the same
            TestCase(input: "bbbb", expected: 1),
            // Test 3: Middle substring is the longest
            TestCase(input: "pwwkew", expected: 3),
            // Test 4: Empty string
            TestCase(input: "", expected: 0),
            // Test 5: All unique characters
            TestCase(input: "abcdefg", expected: 7),
            // Test 6: First two repeat
            TestCase(input: "aab", expected: 2),
            // Test 7: Repeats at boundary
            TestCase(input: "abba", expected: 2),
            // Test 8: Pattern reuses earlier characters
            TestCase(input: "dvdf", expected: 3),
            // Test 9: Combination of numbers and letters
            TestCase(input: "abc123abc", expected: 6),
            // Test 10: Special characters
            TestCase(input: "!@#$%^&*()", expected: 10),
        ]
        
        print("| Test # | Input           | Expected | Actual   | Pass |")
        print("|--------|-----------------|----------|----------|------|")
        
        for (i, test) in tests.enumerated() {
            let actual = lengthOfLongestSubstring(test.input)
            let paddedInput = test.input.padding(toLength: 16, withPad: " ", startingAt: 0)
            let paddedExpected = "\(test.expected)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let paddedActual = "\(actual)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let result = actual == test.expected ? "✅" : "❌"
            print("| \(String(format: "%-6d", i + 1)) | \(paddedInput)| \(paddedExpected) | \(paddedActual) | \(result)   |")
        }
    }
}