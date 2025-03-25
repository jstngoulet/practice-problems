//
//  SecondLargestNumber.swift
//  
//
//  Created by Justin Goulet on 3/24/25.
//

import Foundation

class SecondLargestNumber: NSObject {
    
    /**
     Problem: Find the Second Largest Number
     Difficulty: Beginner
     
     Description:
     
     Write a function that takes an array of integers and returns the second largest number. If there is no second largest number (e.g., all elements are the same or there's only one element), return nil.
     
     Example Input & Output:
     ```swift
     print(findSecondLargest([10, 20, 4, 45, 99]))  // Output: 45
     print(findSecondLargest([5, 5, 5, 5]))        // Output: nil
     print(findSecondLargest([100]))               // Output: nil
     print(findSecondLargest([-2, -5, -1, -8]))    // Output: -2
     print(findSecondLargest([3, 3, 2, 1]))        // Output: 2
     ```
     
     Function Signature:
     ```swift
     func findSecondLargest(_ nums: [Int]) -> Int?
     ```
     
     Hints:
     You can iterate through the array to find the largest and second largest numbers.
     
     Be mindful of cases where all numbers are the same or when there’s only one number.
     */
    
    override init() {
        super.init()
        performTests()
    }
    
    func performTests() {
        let testCases: [(input: [Int], expected: Int?)] = [
            ([10, 20, 4, 45, 99], 45),     // Normal case
            ([5, 5, 5, 5], nil),           // All elements are the same
            ([100], nil),                   // Only one element
            ([-2, -5, -1, -8], -2),        // All negative numbers
            ([3, 3, 2, 1], 2),             // Duplicates with a second largest
            ([1, 2, 3, 4, 5], 4),          // Ordered increasing
            ([5, 4, 3, 2, 1], 4),          // Ordered decreasing
            ([7, 7, 6, 6, 5], 6),          // Multiple duplicates
            ([Int.min, Int.min + 1], Int.min),  // Edge case with min values
            ([42, 42, 100, 1000], 100),    // Large numbers with duplicates
            ([1, 1, 1, 2], 1),             // Only one distinct larger number
            ([10, 20, 30, 40, 50, 50], 40), // Last element is duplicate of the largest
            ([10, 20, 30, 30, 40, 40], 30), // Multiple duplicated values
            ([9, 9, 9, 8, 7, 6], 8),       // Multiple largest values, second largest at start
            ([0, -1, -2, -3, -4], -1),     // Mixed zero and negatives
            ([1, 2, 2, 2, 2, 3], 2),       // Large number of same elements with one distinct
            ([Int.max, Int.min], Int.min),  // Edge case with max and min values
            ([8, 8, 8, 7, 6, 5, 5, 5], 7), // Larger dataset with many duplicates
            ([1000, 999, 998, 997, 996], 999) // Large decreasing sequence
        ]
        
        for testCase in testCases {
            let result = findSecondLargest(testCase.input)
            let isPassing = result == testCase.expected
            print("Input: \(testCase.input) -> Output: \(String(describing: result)) | Expected: \(String(describing: testCase.expected)) | Pass: \(isPassing)")
        }
        
    }
    
    /**
     Hints:
     You can iterate through the array to find the largest and second largest numbers.
     
     Be mindful of cases where all numbers are the same or when there’s only one number.
     */
    func findSecondLargest(_ nums: [Int]) -> Int? {
        
        //  Return nil if empty
        guard let largestNumber = nums.max()
            else { return nil }
        
        var secondLargestNumber: Int?
        
        for number in nums {
            if let second = secondLargestNumber {
                //  If there already is a second largest, just compare
                if number > second,
                   number < largestNumber {
                    secondLargestNumber = number
                }
            } else if number < largestNumber {
                //  Not yet set, only set if less than largest
                secondLargestNumber = number
            }
        }
        
        return secondLargestNumber
    }
}
