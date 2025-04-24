
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
            Given the string, `abcabcbb`, we need to determine the largest substring without duplicate letters
            1. We need to go through the string, using a window, to help solve this. 
            
            Pointer 1           Pointer 2           Current String      isValid     Max
            ---------           ---------           --------------      -------     ---
            0                   0                   a                   t           1
            0                   1                   ab                  t           2
            0                   2                   abc                 t           3
            0                   3                   abca                f           3       - Move pointer 1
            1                   3                    bca                t           3
            1                   4                    bcab               f           3       - Move pointer 1
            2                   4                     cab               t           3       
            2                   5                     cabc              f           3       - Move pointer 1
            3                   6                      abcb             f           3       - Move pointer 1
            4                   5                       bcb             f           3       - Move pointer 1
            5                   5                        cb                   
        
            What we need: 
            - Start and End pointers
            - Something to keep track of the current string
            - Something to keep track of the current max length
            - 2 loops (nested) that adjust the window
            
            Steps: 
            1. Start at 0, 0. if the current character is not in the set, add it and move iter
            2. Move. If the character is in the set, move the other iter and keep removing until the string is valid
            3. After the string is valid, update the max
            4. When all letters are considered, return the max
            
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