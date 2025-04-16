
import Foundation

class MaxSubarraySum: Problem {
    
    /**
    
    Problem Title: Maximum Subarray Sum (Kadane’s Algorithm)

    Problem Description:

    Given an integer array nums, find the contiguous subarray (containing at least one number) 
    that has the largest sum and return its sum.

    You need to implement a function in Swift:
    ```swift
    func maxSubArraySum(nums: [Int]) -> Int
    ```
    
    Example 1:
    ```swift
    let nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
    let result = maxSubArraySum(nums: nums)
    print(result)
    // Expected Output: 6
    ```
    Explanation: The subarray [4, -1, 2, 1] has the largest sum = 6.
    
    Example 2: 
    ```swift
    let nums = [1]
    let result = maxSubArraySum(nums: nums)
    print(result)
    // Expected Output: 1
    ```
    
    Example 3: 
    ```swift
    let nums = [-1, -2, -3, -4]
    let result = maxSubArraySum(nums: nums)
    print(result)
    // Expected Output: -1
    ```
    
    Constraints:
    - The length of the array nums is between 1 and 10^5.
    - nums[i] is an integer in the range [-10^4, 10^4].
    
    Notes:
    - You should implement the solution with O(n) time complexity and O(1) space complexity.
    - The problem can be solved using Kadane's Algorithm, which is a well-known dynamic programming technique.
    */
    
    override func performTests() {
        typealias TestCase = (input: [Int], expected: Int)
        let tests: [TestCase] = [
            ([-2, 1, -3, 4, -1, 2, 1, -5, 4], 6),
            ([1], 1),
            ([5, 4, -1, 7, 8], 23),
            ([-1, -2, -3, -4], -1),
            ([0, 0, 0, 0], 0),
            ([-2, -3, 4, -1, -2, 1, 5, -3], 7),
            ([1, 2, 3, 4, 5], 15),
            ([-5, 1, 2, 3, -1, 2, -1], 8),
            ([8, -19, 5, -4, 20], 21),
            ([-2, 1], 1)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = maxSubArraySum(nums: test.input)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "PASSED" : "FAILED")\t\tResult: \(result)\t\(test.input)")
        }
    }
    
    func maxSubArraySum(nums: [Int]) -> Int {
        var bestSum: Int = Int.min
        var currentSum: Int = 0
        
        for number in nums {
            currentSum = max(number, currentSum + number)
            bestSum = max(currentSum, bestSum)
        }
        
        return bestSum
    }
    
}