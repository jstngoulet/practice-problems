/**
 Finds the length of the longest substring that contains exactly k distinct characters.
 This class includes a method to solve the problem and a test runner to validate correctness.

 Use this class as part of a practice problem suite.
 */
final class LongestSubstringWithKDistinct: Problem {
    /**
     Determines the length of the longest substring with exactly k distinct characters.

     - Parameters:
        - s: The input string to examine.
        - k: The exact number of distinct characters required in the substring.
     - Returns: The length of the longest valid substring, or 0 if none exist.
     */
    func lengthOfLongestSubstringKDistinct(_ s: String, _ k: Int) -> Int {
        //  The problem is looking for where k is a unique set of characters. 
        //  We can use a Set<Character> for this
        //  We also need to keep track of the current max, and two pointers (sliding window)
        var currentMax: Int = 0 //  Start at zero, add while we have a distinct set
        var leftIterator: Int = 0, rightIterator: Int = 0
        
        //  Keep an array for easy traversal of the string
        let stringArray: [Character] = Array(s)
        
        //  If the string Array is empty, return 0, 
        //  Else, set the first char in the string
        if s.isEmpty { return 0 }
        
        //  Build a frequency graph
        var frequencyGraph: [Character: Int] = [:]
        
        //  Now for the logic:
        /**
        We use a sliding window approach with two pointers: `leftIterator` and `rightIterator`.
        
        - `rightIterator` expands the window by including one character at a time.
        - `frequencyGraph` keeps track of how many times each character appears in the current window.
        
        If the number of distinct characters in the window (`frequencyGraph.keys.count`) exceeds `k`,
        we shrink the window from the left by incrementing `leftIterator`, decrementing the count
        of the character at that position, and removing it from the frequency map if its count reaches zero.
        
        We update `currentMax` each time the window contains exactly `k` distinct characters.
        
        This ensures we always consider the longest valid window that satisfies the constraint.
        */

        while rightIterator < s.count {
            let char = stringArray[rightIterator]
            frequencyGraph[char, default: 0] += 1

            while frequencyGraph.keys.count > k {
                let leftChar = stringArray[leftIterator]
                frequencyGraph[leftChar]! -= 1
                if frequencyGraph[leftChar]! == 0 {
                    frequencyGraph.removeValue(forKey: leftChar)
                }
                leftIterator += 1
            }

            if frequencyGraph.keys.count == k {
                currentMax = max(currentMax, rightIterator - leftIterator + 1)
            }

            rightIterator += 1
        }
        
        return currentMax
    }

    override func performTests() {
        print("Testing LongestSubstringWithKDistinct\n")

        struct TestCase {
            let s: String
            let k: Int
            let expected: Int
        }

        let tests: [TestCase] = [
            // ✅ Basic test with two distinct characters
            TestCase(s: "eceba", k: 2, expected: 3),

            // ✅ All unique characters, k matches count
            TestCase(s: "abc", k: 3, expected: 3),

            // ✅ Only one type of character
            TestCase(s: "aaaa", k: 1, expected: 4),

            // ❌ Too many distinct characters
            TestCase(s: "abc", k: 4, expected: 0),

            // ✅ Empty string
            TestCase(s: "", k: 1, expected: 0),

            // ✅ Repeats and switching characters
            TestCase(s: "aabacbebebe", k: 3, expected: 7),

            // ✅ One-character input
            TestCase(s: "a", k: 1, expected: 1),

            // ❌ Zero distinct characters (invalid k)
            TestCase(s: "a", k: 0, expected: 0),

            // ✅ Long valid stretch
            TestCase(s: "abcadcacacaca", k: 3, expected: 11),

            // ❌ k too large for string length
            TestCase(s: "abc", k: 10, expected: 0)
        ]

        let header = "| Test # | Input (s, k)            | Expected |  Actual  | Pass  |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (index, test) in tests.enumerated() {
            let result = lengthOfLongestSubstringKDistinct(test.s, test.k)
            let input = "(\(test.s), \(test.k))".padding(toLength: 24, withPad: " ", startingAt: 0)
            let expectedStr = String(test.expected).padding(toLength: 9, withPad: " ", startingAt: 0)
            let resultStr = String(result).padding(toLength: 9, withPad: " ", startingAt: 0)
            let passStr = (result == test.expected ? "✅" : "❌").padding(toLength: 5, withPad: " ", startingAt: 0)

            print("| \(String(index + 1).padding(toLength: 7, withPad: " ", startingAt: 0))" +
                  "| \(input)" +
                  "| \(expectedStr)" +
                  "| \(resultStr)" +
                  "| \(passStr)|")
        }
    }
}
