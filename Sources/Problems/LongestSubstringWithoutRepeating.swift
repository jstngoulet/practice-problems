/**
 Finds the length of the longest substring without repeating characters.
 This class includes a method to solve the problem and a test runner to validate correctness.

 Use this class as part of a practice problem suite.
 */
final class LongestSubstringWithoutRepeats: Problem {
    /**
     Returns the length of the longest substring with all unique characters.

     - Parameter s: The input string.
     - Returns: Length of the longest substring without repeating characters.
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        else if s.count == 1 { return 1 }
        
        let sArray: [Character] = Array(s)
        let maxIterator: Int = sArray.count
        var rightIterator: Int = 0, leftIterator: Int = 0
        var longestSubstringLength: Int = 0
        var workingSet: Set<Character> = []
        
        /**
            Walkthrough of `abcabcdb`
            1. a
            2. ab
            3. abc
            4. abca         No, remove
            4.  bca
            5.  bcab        No, remove
            6.   cab
            7.   cabc       No, remove
            8.    abc
            9.    abcd
            10.   abcdb     No, remove
            11.    bcdb     No, remove
            12.     cdb     Done
        */
        while rightIterator < maxIterator {
            let currentChar = sArray[rightIterator]
            
            while workingSet.contains(currentChar) {
                //  While working set does not contain, move the left
                let leftChar = sArray[leftIterator]
                workingSet.remove(leftChar)
                leftIterator += 1
            }
            
            workingSet.insert(currentChar)
            longestSubstringLength = max(longestSubstringLength, workingSet.count)
            
            rightIterator += 1
        }
        
        return longestSubstringLength
    }

    override func performTests() {
        print("Testing LongestSubstringWithoutRepeats\n")

        struct TestCase {
            let s: String
            let expected: Int
        }

        let tests: [TestCase] = [
            // ✅ Basic unique sequence
            TestCase(s: "abcabcbb", expected: 3),

            // ✅ Single repeated character
            TestCase(s: "bbbbb", expected: 1),

            // ✅ Unique spread after repeat
            TestCase(s: "pwwkew", expected: 3),

            // ✅ All unique
            TestCase(s: "abcdef", expected: 6),

            // ✅ Edge case: empty string
            TestCase(s: "", expected: 0),

            // ✅ Numbers and letters
            TestCase(s: "123abc123", expected: 6),

            // ✅ Mix of special characters
            TestCase(s: "a!b@c#d$", expected: 8),

            // ✅ Long repeat in middle
            TestCase(s: "abcdeffffgh", expected: 6),

            // ✅ Alternating repeat
            TestCase(s: "abababab", expected: 2),

            // ✅ Single char input
            TestCase(s: "z", expected: 1)
        ]

        let header = "| Test # | Input                     | Expected |  Actual  | Pass  |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (index, test) in tests.enumerated() {
            let result = lengthOfLongestSubstring(test.s)
            let input = "\"\(test.s)\"".padding(toLength: 25, withPad: " ", startingAt: 0)
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
