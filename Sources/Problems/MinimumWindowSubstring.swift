/**
 Finds the minimum-length substring of `s` that contains all characters in `t`.
 This class includes a method to solve the problem and a test runner to validate correctness.

 Use this class as part of a practice problem suite.
 */
final class MinimumWindowSubstring: Problem {
    /**
     Returns the smallest substring in `s` that contains all characters in `t`.

     - Parameters:
        - s: The string to search within.
        - t: The string containing required characters.
     - Returns: The shortest substring of `s` containing all characters of `t`, or an empty string.
     */
    func minWindow(_ s: String, _ t: String) -> String {
        
        //  T Must be smaller than s
        //  If not, it is impossible for t to be within s
        if t.count > s.count { return "" }
        if t.isEmpty { return "" }
        
        var smallestString: String = s  //  Start as the full length
        var smallestLength: Int = Int.max
        var rightIterator: Int = 0, leftIterator: Int = 0
        let sArray: [Character] = Array(s)
        
        /**
        Walkthrough: `aaabdec` contains `abc` E: `abdec` 
        1. a
        2. aa
        3. aaa
        4. aaab
        5. aaabd
        6. aaabde
        7. aaabdec      Yes, contains all. Remove first, if still contains all
        8.  aabdec      Yes, contains all. Remove first, if still contains all
        9.   abdec      Yes, contains all. Remove first, if still contains all      * Best Case
        10.    bdec     No, does not contain all
        
        In the steps, we have a left and a right iterator. 
        The left stays at 0 until step 6->7, when it is moved.
        The right is moved every letter, until the letters in the current set
            are all in t.
            
        The hint was to use a frequency map, so we need to make sure all letters in t
        appear the correct amount of times. Lets use the steps above to consider that.
        The base is: [
            "a": 1, 
            "b": 1,
            "c": 1
        ]
        
        Using this approach, we need to make sure for each iteration, the counts are the same. 
        In step 1, a is good, but b and c are not, so we can move the iterator until step 3->4
        In step 4, we add a b, so a and b are good, but still missing c until step 7
        In step 7, we add a c. 
        Now that all letters are matching, we can move the front as long as they remain matching.
        When they no longer match, move the left to try to expand the string, when possible.
        
        Every time the window contains all required characters in t with equal or greater counts, 
        compare the length of the current string with the previously stored value. If shorter, update
        */
        var baseFrequencyMap: [Character: Int] = [:]
        var frequencyMap: [Character: Int] = [:]
        
        func isValidWindow( freq: [Character: Int], in base: [Character: Int]) -> Bool {
            for (char, count) in base {
                if freq[char, default: 0] < count {
                    return false
                }
            }
            return true
        }
        
        //  Fill the base
        for char in t {
            baseFrequencyMap[char, default: 0] += 1
        }
        
       while rightIterator < s.count {
            let currentChar = sArray[rightIterator]
            frequencyMap[currentChar, default: 0] += 1

            // Shrink only when valid
            while isValidWindow(freq: frequencyMap, in: baseFrequencyMap) && leftIterator <= rightIterator {
                let windowLength = rightIterator - leftIterator + 1
                if windowLength < smallestLength {
                    smallestString = String(sArray[leftIterator...rightIterator])
                    smallestLength = windowLength
                }

                let leftChar = sArray[leftIterator]
                frequencyMap[leftChar, default: 0] -= 1
                
                if frequencyMap[leftChar] == 0 {
                    frequencyMap.removeValue(forKey: leftChar)
                }

                leftIterator += 1
            }

            rightIterator += 1
        }

        
        //  If the smallest string is still the length of the full string, 
        //  t is not contained, so return empty
        return smallestLength == Int.max ? "" : smallestString
    }

    override func performTests() {
        print("Testing MinimumWindowSubstring\n")

        struct TestCase {
            let s: String
            let t: String
            let expected: String
        }

        let tests: [TestCase] = [
            // ✅ Standard case
            TestCase(s: "ADOBECODEBANC", t: "ABC", expected: "BANC"),

            // ✅ Entire string is answer
            TestCase(s: "a", t: "a", expected: "a"),

            // ❌ Not enough characters
            TestCase(s: "a", t: "aa", expected: ""),

            // ✅ Duplicate characters in t
            TestCase(s: "aaabdec", t: "abc", expected: "abdec"),

            // ✅ Multiple valid windows
            TestCase(s: "abbbbac", t: "abc", expected: "bac"),

            // ✅ Characters out of order
            TestCase(s: "cabefgecdaecf", t: "cae", expected: "aec"),

            // ✅ No overlap at all
            TestCase(s: "abcdef", t: "xyz", expected: ""),

            // ✅ Edge case: empty s
            TestCase(s: "", t: "a", expected: ""),

            // ✅ Edge case: empty t
            TestCase(s: "abc", t: "", expected: "")
        ]

        let header = "| Test # | Input (s, t)             | Expected |  Actual  | Pass  |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (index, test) in tests.enumerated() {
            let result = minWindow(test.s, test.t)
            let input = "(\(test.s), \(test.t))".padding(toLength: 25, withPad: " ", startingAt: 0)
            let expectedStr = "\"\(test.expected)\"".padding(toLength: 9, withPad: " ", startingAt: 0)
            let resultStr = "\"\(result)\"".padding(toLength: 9, withPad: " ", startingAt: 0)
            let passStr = (result == test.expected ? "✅" : "❌").padding(toLength: 5, withPad: " ", startingAt: 0)

            print("| \(String(index + 1).padding(toLength: 7, withPad: " ", startingAt: 0))" +
                  "| \(input)" +
                  "| \(expectedStr)" +
                  "| \(resultStr)" +
                  "| \(passStr)|")
        }
    }
}
