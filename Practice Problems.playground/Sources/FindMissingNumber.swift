//
//  FindMissingNumber.swift
//  
//
//  Created by Justin Goulet on 3/24/25.
//

import Foundation

class FindMissingNumber: NSObject {
    
    /**
     Problem: Find the Missing Number
     You are given an array of n integers, where each integer is between 1 and n (inclusive), but one number is missing. Write a function findMissingNumber that returns the missing number in the array.
     
     Function Signature:
     ```swift
     func findMissingNumber(_ nums: [Int]) -> Int
     ```
     
     Example:
     ```swift
     findMissingNumber([3, 7, 1, 2, 8, 4, 5])
     // Output: 6
     
     findMissingNumber([1, 2, 3, 5])
     // Output: 4
     
     Constraints:
     The array contains n-1 numbers, and each integer is between 1 and n (inclusive).
     The length of the array nums is between 1 and 1000.
     
     Hints:
     You can calculate the sum of all the numbers from 1 to n (which is n * (n + 1) / 2), and then subtract the sum of the numbers in the array. The difference will be the missing number.
     ```
     */
    override init() {
        super.init()
        print(findMissingNumber([3, 7, 1, 2, 8, 4, 5]))
        // Output: 6
        
        print(findMissingNumber([1, 2, 3, 5]))
        // Output: 4
        
        print(findMissingNumber([1]))
        // Output: 2
        
        print(findMissingNumber([2, 3, 4, 5]))
        // Output: 1
        
        print(findMissingNumber([1, 2, 3, 4]))
        // Output: 5
        
        print(findMissingNumber([1, 2, 3, 5, 6, 7, 8]))
        // Output: 4
        
        print(findMissingNumber([10, 11, 12, 14, 15]))
        // Output: 13
        
        print(findMissingNumber([1, 2, 3, 5, 6, 7, 8, 9, 10]))
        // Output: 4
        
    }
    
    func findMissingNumber(_ nums: [Int]) -> Int {
        let count = nums.count
        
        // Constraints: The array contains n-1 numbers, and each integer is between 1 and n (inclusive).
        if count < 1 || count > 999 { // Ensures that the array size is within bounds
            print("ERROR: Array size should be between 1 and 999")
            return -1
        }
        
        // Find the maximum value in the array
        guard let maxNumber = nums.max() else {
            print("ERROR: Unable to find max value.")
            return -1
        }
        
        // Expected sum for numbers from 1 to (n+1)
        let expectedSum = (maxNumber * (maxNumber + 1)) / 2
        
        // Sum of numbers in the array
        let sumOfNumbersListed = nums.reduce(0, +)
        
        // The missing number
        let missingNumber = expectedSum - sumOfNumbersListed
        
        // If missingNumber is 0, that means the missing number is actually the next one after maxNumber.
        return missingNumber == 0 ? maxNumber + 1 : missingNumber
    }
}
