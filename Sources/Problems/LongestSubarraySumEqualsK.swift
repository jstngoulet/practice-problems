import Foundation

class LongestSubarraySumEqualsK: Problem {
    /**
     Returns the length of the longest contiguous subarray that sums to `k`.
    
     - Parameters:
        - nums: The array of integers.
        - k: The target sum.
     - Returns: The length of the longest subarray whose elements sum to `k`.
     */
    func maxSubArrayLen(_ nums: [Int], _ k: Int) -> Int {
        
        /**
            Walkthrough: 
            
            Starting with: 1, 2, 3, 4, 5 -> 7
            
            //  Lets start finding the sums
            1. index 0, we have one. we need 6 more to get 7
            to do this, there are actually a couple ways to get 6: 
             • 1 + 2 + 3
             • 1 + 5
             
             What are some ways to do this? 
             1. if we have 1, the next number is 2. We are still under 7
                1 + 2
                Now, we need 5 more. what is the next number?
                1 + 2 + 3
                We are still under 7. (6) but now, the next numbder needed is 1, so that wont work
                
            2.  If we have 1, we know we need to get k. So we know that our current requirement is 1 - k = next
                This way, we could build it going up. Trying out
                1 - 7 = 6
                Great, now our current sum is 6, and we are searching the new array for numbers that add to 6
        */
        var prefixIndex: [Int: Int] = [0: -1]    //  See 0 at index -1
        var currentSum: Int = 0
        var maxLength: Int = 0
        
        for (iter, number) in nums.enumerated() {
            currentSum += number
            let missing = currentSum - k
            if let previous = prefixIndex[missing] {
                maxLength = max(maxLength, iter - previous)
            } 
            
            if prefixIndex[currentSum] == nil {
                prefixIndex[currentSum] = iter
            }   
        }
        
        return maxLength
    }

    override func performTests() {
        print("Running tests for: \(type(of: self))\n")

        struct TestCase {
            let nums: [Int]
            let k: Int
            let expected: Int
        }

        let tests: [TestCase] = [
            // Subarray [1, -1, 5, -2] = 3
            TestCase(nums: [1, -1, 5, -2, 3], k: 3, expected: 4),

            // Subarray [3, 1, -1] = 3
            TestCase(nums: [2, 3, 1, -1, 2], k: 3, expected: 3),

            // Subarray [1, 1, 1] = 3
            TestCase(nums: [1, 1, 1, 1, 1], k: 3, expected: 3),

            // Only one element equals k
            TestCase(nums: [1, 2, 3], k: 3, expected: 2),

            // No subarray equals k
            TestCase(nums: [1, 2, 3], k: 7, expected: 0),

            // Whole array equals k
            TestCase(nums: [1, -1, 1, 1], k: 2, expected: 4),

            // Negative values
            TestCase(nums: [-2, -1, 2, 1], k: 1, expected: 2),

            // Single element
            TestCase(nums: [3], k: 3, expected: 1),

            // Empty array
            TestCase(nums: [], k: 3, expected: 0),

            // All zeroes, looking for sum 0
            TestCase(nums: [0, 0, 0, 0], k: 0, expected: 4),
        ]

        let header = "| Test # | Input (nums, k)                    | Expected | Actual | Pass |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (i, test) in tests.enumerated() {
            let result = maxSubArrayLen(test.nums, test.k)
            let pass = result == test.expected ? "✅" : "❌"
            let inputStr = "(\(test.nums), \(test.k))".padding(
                toLength: 32, withPad: " ", startingAt: 0)
            let expectedStr = "\(test.expected)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let actualStr = "\(result)".padding(toLength: 6, withPad: " ", startingAt: 0)
            print(
                "| \(String(format: "%-6d", i + 1)) | \(inputStr) | \(expectedStr) | \(actualStr) | \(pass) |"
            )
        }
    }
}
