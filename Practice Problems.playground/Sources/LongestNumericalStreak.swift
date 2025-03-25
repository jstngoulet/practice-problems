//
//  LongestNumericalStreak.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//

import Foundation

class LongestNumericalStreak: NSObject {
    
    /**
     Problem: Longest Consecutive Sequence
     Difficulty: Intermediate
     
     Problem Statement:
     
     Given an unsorted array of integers, find the length of the longest consecutive sequence of numbers.
     
     You must solve this in O(n) time complexity.
     
     Example:
     ```swift
     print(longestConsecutive([100, 4, 200, 1, 3, 2]))
     // Output: 4 (The longest consecutive sequence is [1, 2, 3, 4])
     
     print(longestConsecutive([9, 1, 4, 7, 3, 2, 6, 5, 8, 0]))
     // Output: 10 (The longest sequence is [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
     
     Constraints:
     
     The array may contain negative numbers and duplicates.
     The numbers will be between -10^6 and 10^6.
     The length of the array is at most 10^5.
     
     Hint:
     Using a Set to track numbers and checking only when a number is the start of a sequence can optimize performance.
     ```
     */
    
    override init() {
        super.init()
        performTests()
    }
    
    func performTests() {
        // Test Cases
        let testCases: [(input: [Int], expected: Int)] = [
            ([100, 4, 200, 1, 3, 2], 4),  // Sequence: [1, 2, 3, 4]
            ([9, 1, 4, 7, 3, 2, 6, 5, 8, 0], 10),  // Sequence: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
            ([1, 3, 5, 7, 9], 1),  // No consecutive sequence, only single elements
            ([1, 2, 0, 1], 3),  // Sequence: [0, 1, 2]
            ([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 10),  // Already sorted sequence [0..9]
            ([10, 20, 30, 40], 1),  // No consecutive sequence, just gaps
            ([10, 9, 8, 7, 6, 5, 4, 3, 2, 1], 10),  // Reverse sorted sequence [1..10]
            ([0], 1),  // Single element, output should be 1
            ([], 0)  // Empty array, should return 0
        ]
        
        // Running Tests
        for testCase in testCases {
            let result = longestConsecutive(testCase.input)
            let passed = result == testCase.expected
            print("Input: \(testCase.input) -> Output: \(result) | Expected: \(testCase.expected) | Pass: \(passed ? "✅" : "❌")")
        }
        
    }
    
    func longestConsecutive(_ numbers: [Int]) -> Int {
        
        //  For each number in the set, add it. Then, check to see if there is a number adjacent
        //  (less or greater) already in the set. If there is, add it, if not, advance and clear
        
        //  We need it to be max of n, so let's start the loop there
        /// Lets start with just getting it working
        let currentSet: Set<Int> = Set(numbers) //  Gets distinct values, too
        var maxSequence: Int = 0
        var currentSequence: Int = 0
        
        for item in currentSet {
            currentSequence = 0
            
            while currentSet.contains(item - currentSequence) {
                currentSequence += 1
            }
            
            maxSequence = max(maxSequence, currentSequence)
        }
        
        return maxSequence
    }
}
