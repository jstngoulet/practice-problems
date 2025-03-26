//
//  SubarraySum.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//

import Foundation

/**
 Problem: Subarray Sum Equals K
 
 Difficulty: Medium
 Description:
 Given an array of integers nums and an integer k, return the total number of continuous subarrays whose sum equals k.
 
 Example 1:
 Input:
 ```swift
 let nums = [1, 1, 1]
 let k = 2
 ```
 Output:
 ```swift
 2
 ```
 Explanation:
 
 There are two subarrays that sum to k: [1,1] (at indices 0-1 and 1-2).
 
 Example 2:
 Input:
 ```swift
 let nums = [3, 4, 7, 2, -3, 1, 4, 2]
 let k = 7
 ```
 
 Output:
 ```swift
 4
 ```
 Explanation:
 
 The subarrays that sum to 7 are:
 
 [3, 4]
 [7]
 [4, 7, 2, -3, 1]
 [1, 4, 2]
 
 Constraints:
 1 <= nums.length <= 2 * 10⁴
 -1000 <= nums[i] <= 1000
 -10⁷ <= k <= 10⁷
 
 Function Signature:
 ```swift
 func subarraySum(_ nums: [Int], _ k: Int) -> Int {
 // Your implementation
 }
 ```
 Hints
 
 A brute force solution would check all subarrays, but it’s O(n²).
 Try using prefix sums and a hash map to store sums seen so far.
 The key idea is: if sum[j] - sum[i] == k, then sum[i] must have existed before.
 */
class SubarraySum: NSObject {
    
    func performTests() {
        struct TestCase {
            let input: [Int]
            let target: Int
            let expected: Int
        }
        
        // Define test cases
        let testCases: [TestCase] = [
            TestCase(input: [3, 4, 7, 2, -3, 1, 4, 2], target: 7, expected: 4),
            TestCase(input: [1, 2, 3], target: 3, expected: 2),
            TestCase(input: [1, 1, 1], target: 2, expected: 2),
            TestCase(input: [1], target: 1, expected: 1),
            TestCase(input: [1, -1, 1, 1], target: 1, expected: 5)
        ]
        
        for testCase in testCases {
            let output = subarraySum(testCase.input, testCase.target)
            let pass = output == testCase.expected
            print(
    """
    Input: \(testCase.input)
    Target: \(testCase.target)\tOutput: \(output)\tExpected: \(testCase.expected)\t\tPass: \(pass ? "✅" : "❌")
    
    """
            )
        }
    }
    
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        
        //  Similar to an anagram sear4ch, we want to find the number of times the
        //  values in the `nums` array equals k (similar to number of anagrams in the string)
        var currentSum: Int = 0
        var sumsFound: Int = 0
        var sumPrefixes: [Int: Int] = [0:1]
        
        //  Reference
        let count: Int = nums.count
        
        for num in nums {
            
            currentSum += num
            let needed = currentSum - k
            
            if let previousReports = sumPrefixes[needed] {
                sumsFound += previousReports
            }
            
            sumPrefixxes[currentSum, default: 0] += 1
        }
        
        return sumsFound
    }
}
