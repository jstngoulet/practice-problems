import Foundation

class MinimumWindowSubstring2: Problem {
    /**
     Returns the smallest substring of `s` that contains all characters from `t`.
    
     - Parameters:
        - s: The source string.
        - t: The target string.
     - Returns: The minimum window in `s` which contains all the characters in `t`.
     */
    func minWindow(_ s: String, _ t: String) -> String {
        
        if t.isEmpty || s.isEmpty { return "" }
        
        //  We will need to keep track of a sliding window, 
        //   in addition, we will need counts of each letter in the t string
        //  and convert the s string into a char array, to check each one
        let sArray: [Character] = Array(s)
        var tLetterRequirements: [Character: Int] = [:]
        
        //  Populare t requirments
        for char in t {
            tLetterRequirements[char, default: 0] += 1
        }
        
        /**
            Walkthrough:     a a b a c a -> "cab" returns "bac"
            Counts:          T: a: 1, b: 1, c: 1
            
            Right Iter      Left Iter           Current         Current Min
            0               0                   a               -
            1               0                   aa              -
            2               0                   aab             - 
            3               0                   aaba            -
            4               0                   aabac           5
            4               1                    abac           4
            4               2                     bac           3
            5               2                     baca          3 (compare with 4)
            5               3                      aca          - 
            -(5)            4                       ca          - 
            -(5)            5                        a          -
            
            Plan: 
            Grab the current letter at the starting position
                Increase the count shown of the current letter in stored dict
                Do the letters in the current string all match up with the required letters in the t string
                    - may need to keep track of both letters shown and removed
                    If No, increase right iter again
                    If yes, increase left iter and add letter to dict
                        Check to see if all match up with required
                        If yes, compare min
                            Then, remove left iter while true
                        If no, move right
                                                  
        */
        var rightIter: Int = 0, leftIter: Int = 0
        var shownDict: [Character: Int] = [:]
        var currentMin: Int = Int.max
        var minString: String = ""
        
        func isValidWindow(freq required: [Character: Int], in window: [Character: Int]) -> Bool {
            for (char, neededCount) in required {
                if window[char, default: 0] < neededCount {
                    return false
                }
            }
            return true
        }
        
        while rightIter < s.count {
            let currentChar = sArray[rightIter]
            shownDict[currentChar, default: 0] += 1
            
            while isValidWindow(freq: tLetterRequirements, in: shownDict)
            && leftIter <= rightIter {
                
                let windowLength = rightIter - leftIter + 1
                if windowLength < currentMin {
                    minString = String(sArray[leftIter...rightIter])
                    currentMin = windowLength
                }
                
                let leftChar = sArray[leftIter]
                shownDict[leftChar, default: 0] -= 1
                
                if shownDict[leftChar, default: 0] <= 0 {
                    shownDict.removeValue(forKey: leftChar)
                }
                leftIter += 1
            }
            
            rightIter += 1
        }
        
        return minString
    }

    override func performTests() {
        print("Running tests for: \(type(of: self))\n")

        struct TestCase {
            let s: String
            let t: String
            let expected: String
        }

        let tests: [TestCase] = [
            // Classic minimum window
            TestCase(s: "ADOBECODEBANC", t: "ABC", expected: "BANC"),

            // No match
            TestCase(s: "A", t: "AA", expected: ""),

            // Exact match
            TestCase(s: "ABC", t: "ABC", expected: "ABC"),

            // Full match required
            TestCase(s: "AA", t: "AA", expected: "AA"),

            // Multiple valid windows
            TestCase(s: "aaflslflsldkalskaaa", t: "aaa", expected: "aaa"),

            // Case sensitivity
            TestCase(s: "aA", t: "Aa", expected: "aA"),

            // Single character match
            TestCase(s: "a", t: "a", expected: "a"),

            // Target longer than source
            TestCase(s: "a", t: "aa", expected: ""),

            // Empty target
            TestCase(s: "anything", t: "", expected: ""),

            // Empty source
            TestCase(s: "", t: "abc", expected: ""),
        ]

        let header = "| Test # | Input (s, t)                   | Expected  | Actual | Pass |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (i, test) in tests.enumerated() {
            let result = minWindow(test.s, test.t)
            let pass = result == test.expected ? "✅" : "❌"
            let inputStr = "(\(test.s), \(test.t))".padding(
                toLength: 30, withPad: " ", startingAt: 0)
            let expectedStr = "\"\(test.expected)\"".padding(
                toLength: 9, withPad: " ", startingAt: 0)
            let actualStr = "\"\(result)\"".padding(toLength: 7, withPad: " ", startingAt: 0)
            print(
                "| \(String(format: "%-6d", i + 1)) | \(inputStr) | \(expectedStr) | \(actualStr) | \(pass) |"
            )
        }
    }
}
