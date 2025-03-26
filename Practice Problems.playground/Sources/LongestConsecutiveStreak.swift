//
//  LongestConsecutiveStreak.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//

import Foundation

class LongestConsecutiveStreak: NSObject {
    
    /**
     Longest Consecutive Sequence
     Problem Statement
     
     Given an unsorted array of integers, write a function to find the length of the longest consecutive sequence of numbers.
     A consecutive sequence is a series of numbers in which each number is exactly one greater than the previous number.
     
     Requirements
     
     Your algorithm must run in O(n) time complexity.
     The input is an array of integers, which may include duplicates and negative numbers.
     The output is an integer representing the length of the longest consecutive sequence found in the array.
     Function Signature
     ```swift
     func longestConsecutive(_ nums: [Int]) -> Int
     ```
     Example Cases
     
     Input    Expected Output
     [100, 4, 200, 1, 3, 2]    4 ([1,2,3,4] is the longest sequence)
     [9, 1, 4, 7, 3, -1, 0, 5, 8, -2, 6]    7 ([-2,-1,0,1,2,3,4])
     [1, 2, 0, 1]    3 ([0,1,2])
     [10, 20, 30]    1 (Each number is isolated)
     []    0 (Empty array)
     Constraints
     
     0 <= nums.count <= 10^5
     -10^9 <= nums[i] <= 10^9
     */
    
    func performTests() {
        let testCases: [(input: [Int], expected: Int)] = [
            ([100, 4, 200, 1, 3, 2], 4),  // [1,2,3,4] is the longest sequence
            ([9, 1, 4, 7, 3, -1, 0, 5, 8, -2, 6], 7), // [-2,-1,0,1,2,3,4]
            ([1, 2, 0, 1], 3), // [0,1,2]
            ([10, 20, 30], 1), // No consecutive sequence, max length is 1
            ([], 0), // Empty array, result is 0
            ([5, 6, 1, 2, 3, 4], 6), // [1,2,3,4,5,6]
            ([1, 2, 3, 5, 6, 7, 8, 10, 11, 12], 4), // [5,6,7,8]
            ([1, 3, 5, 2, 4, 8, 7, 6, 9], 9), // Full sequence 1-9
            ([1, 2, 3, 100, 101, 102, 103, 104], 5), // [100,101,102,103,104]
            ([0, 0, 0, 1, 2, 3, 4, 0], 5) // [0,1,2,3,4]
        ]
        
        for (index, testCase) in testCases.enumerated() {
            let result = longestConsecutive(testCase.input)
            let passed = result == testCase.expected
            print("Test Case \(index + 1): Input: \(testCase.input) | Output: \(result) | Expected: \(testCase.expected) | Pass: \(passed ? "✅" : "❌")")
        }
    }
    
    func longestConsecutive(_ nums: [Int]) -> Int {
        //  As you progress through, add each item to the array.
        //  Check the set to see if there is another item adjacent
        let currentSet: Set<Int> = Set(nums)
        var maxStreak: Int = 0
        
        for number in currentSet {
            //  Check to see if it is a start of  sequence
            var currentNumber: Int = number
            var iter: Int = 0
            
            while currentSet.contains(currentNumber) {
                currentNumber += 1
                iter += 1
            }
            
            maxStreak = max(maxStreak, iter)
        }
        
        return maxStreak
    }
}
