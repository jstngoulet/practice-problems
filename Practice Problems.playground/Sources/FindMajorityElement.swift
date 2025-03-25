//
//  FindMajorityElement.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//
import Foundation

class MajorityElement: NSObject {
    /**
     ### **Problem: Find the Majority Element**
     
     #### **Difficulty:** Medium
     
     #### **Problem Statement:**
     Given an array of integers `nums`, return the majority element. The majority element is the element that appears **more than** `n/2` times in the array, where `n` is the length of the array. You may assume that the input always has a majority element.
     
     #### **Function Signature:**
     ```swift
     func findMajorityElement(_ nums: [Int]) -> Int
     ```
     
     #### **Example Test Cases:**
     
     | **Input** | **Output** | **Expected** | **Pass** |
     |-----------|-----------|-------------|----------|
     | `[3, 2, 3]` | `3` | `3` | ✅ |
     | `[2, 2, 1, 1, 1, 2, 2]` | `2` | `2` | ✅ |
     | `[5, 5, 5, 5, 2, 3, 5, 4, 5]` | `5` | `5` | ✅ |
     | `[1]` | `1` | `1` | ✅ |
     | `[6, 6, 6, 7, 7]` | `6` | `6` | ✅ |
     
     #### **Constraints:**
     - `1 <= nums.length <= 5 * 10^4`
     - `-10^9 <= nums[i] <= 10^9`
     - The majority element **always** exists in the array.
     
     #### **Hint:**
     Try using the **Boyer-Moore Voting Algorithm** to optimize your solution to **O(n) time and O(1) space**. 🚀
     
     */
    
    override init() {
        super.init()
        performTests()
    }
    
    func performTests() {
        let testCases: [(input: [Int], expected: Int)] = [
            ([3, 2, 3], 3),
            ([2, 2, 1, 1, 1, 2, 2], 2),
            ([1, 1, 1, 2, 3, 1, 1], 1),
            ([5, 5, 5, 5, 1, 2, 5, 5], 5),
            ([7, 8, 7, 7, 8, 7, 7, 8, 8, 7], 7)
        ]
        
        for test in testCases {
            let result = findMajorityElement(test.input)
            print("Input: \(test.input) -> Output: \(result) | Expected: \(test.expected) | Pass: \(result == test.expected ? "✅" : "❌")")
        }
    }
    
    func findMajorityElement(_ nums: [Int]) -> Int {
        guard var currentMarjorityElement = nums.first else {
            print("ERROR: Element needs 1 element")
            return -1
        }
        
        //  First, count them all, then figure out the highest value, where
        //   the majority is n / 2
        var counts: [Int: Int] = [:]
        let marjorityFactor: Int = nums.count / 2
        
        for number in nums {
            counts[number, default: 0] += 1
        }
        
        return counts.first(where: {$0.value > marjorityFactor})?.key
        ?? currentMarjorityElement
    }
}
