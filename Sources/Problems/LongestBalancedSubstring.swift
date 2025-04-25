import Foundation

/// Finds the length of the longest balanced substring containing equal number of 0s followed by 1s.
///
/// - Parameter s: A string containing only characters '0' and '1'.
/// - Returns: The maximum length of a valid substring where 0s come before 1s and both counts are equal.
class LongestBalancedSubstring: Problem {
    
    func longestBalanced(_ s: String) -> Int {
        /**
            Walkthrough:
            - We are going to iterate through the string, keeping counts of when
            the total count is even. Then, when it is even, see if the string is balanced (equal number of 0s and 1s)
            If the string is balanced, add the next one. if not.
            - Key thing to note is that 0s must come before ones.
        
            This is similar to the parenthesis issue, except instead of true/false, we are counting the current window
            size.
        
            For example, (easy) given: `0011`
            The hint they gave, was that we can do this by counting consecutive 0s, followed by ones
            and keeping track of the transitions
        
            Start Iter      End Iter        String      0 Count     1 Count     Net (balanced when 0)
            0               0               0           1           0           1
            0               1               00          2           0           2
            0               2               001         2           1           1
            0               3               0011        2           2           0       -- Keep count of balanced
        
            Another one..
            For example, (medium) given: `001111`
            Start Iter      End Iter        String      0 Count     1 Count     Net (balanced when 0)
            0               0               0           1           0           1
            0               1               00          2           0           2
            0               2               001         2           1           1
            0               3               0011        2           2           0       -- Keep count of balanced
            0               4               00111       2           3           -1
            0               5               001111      2           4           -2
        
            Another one.. This time, not at start
            For Example, (hard) given: `10011100`
            Start Iter      End Iter        String      0 Count     1 Count     Net (balanced when 0)
            0               0               1           0           1           -1
            0               1               10          1           1           0       -- Balanced, but 0s must be before ones
            0               2               100         2           1           1
            0               3               1001        2           2           0       -- Balanced, but 0s must be before ones
            0               4               10011       2           3           -1
            0               5               100111      2           4           -2
            0               6               1001110     3           4           -1
            0               7               10011100    4           4           0       -- Balanced, but 0s must be before ones
            1               1               0           1           0
            
            Patterns: 
            - Should only count when previous net is positive amd mew net == 0
            - Should keep track of 0s and 1s seen
            - Should have 2 iters, as the longest balanced string may not be at the start
        */
        var startIter: Int = 0, endIter: Int = 0
        var currentMax: Int = 0
        let numberArray: [Character] = Array(s)
        
        while startIter < numberArray.count {
            if numberArray[startIter] != "0" {
                startIter += 1
                continue
            }

            var zeros = 0, ones = 0
            endIter = startIter

            while endIter < numberArray.count && numberArray[endIter] == "0" {
                zeros += 1
                endIter += 1
            }

            while endIter < numberArray.count && numberArray[endIter] == "1" {
                ones += 1
                endIter += 1
            }

            if zeros > 0 && ones > 0 {
                currentMax = max(currentMax, 2 * min(zeros, ones))
            }

            startIter = endIter
        }
        
        return currentMax
    }
    
    override func performTests() {
        print("Running tests for: \(type(of: self))")

        struct TestCase {
            let input: String
            let expected: Int
        }

        let tests: [TestCase] = [
            // Basic alternating pair
            TestCase(input: "01", expected: 2),
            // Two valid blocks
            TestCase(input: "0011", expected: 4),
            // Multiple valid segments, longest is first
            TestCase(input: "001100", expected: 4),
            // Only one full valid segment
            TestCase(input: "000111", expected: 6),
            // More ones than zeros, short match
            TestCase(input: "001111", expected: 4),
            // Reverse order should fail
            TestCase(input: "1100", expected: 0),
            // Interleaved, only one valid
            TestCase(input: "0101", expected: 2),
            // Entire string is valid
            TestCase(input: "00001111", expected: 8),
            // No valid segment
            TestCase(input: "1111", expected: 0),
            // Valid mid segment
            TestCase(input: "10011100", expected: 4),
        ]

        let header = "| Test # | Input               | Expected | Actual | Pass |"
        print(header)
        print(String(repeating: "-", count: header.count))

        for (i, test) in tests.enumerated() {
            let actual = longestBalanced(test.input)
            let pass = actual == test.expected ? "✅" : "❌"

            let testNum = String(i + 1).padding(toLength: 7, withPad: " ", startingAt: 0)
            let inputStr = test.input.padding(toLength: 20, withPad: " ", startingAt: 0)
            let expectedStr = String(test.expected).padding(
                toLength: 8, withPad: " ", startingAt: 0)
            let actualStr = String(actual).padding(toLength: 8, withPad: " ", startingAt: 0)
            let passStr = "\(pass)  "

            print("| \(testNum)| \(inputStr)| \(expectedStr)| \(actualStr)| \(passStr)|")
        }
    }

}
