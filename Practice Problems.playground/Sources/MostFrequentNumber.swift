//
//  MostFrequentNumber.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//

import Foundation

class MostFrequentNumber: NSObject {
    
    /**
     Difficulty: Beginner
     
     Problem Statement:
     
     Write a function that takes an array of integers and returns the most frequently occurring element. If multiple elements have the same highest frequency, return any one of them.
     
     Example:
     ```swift
     print(mostFrequentElement([1, 3, 2, 3, 4, 1, 3]))
     // Output: 3
     
     print(mostFrequentElement([7, 7, 8, 8, 9, 9]))
     // Output: 7 (or 8 or 9, since they all appear twice)
     
     Constraints:
     
     The array will have at least one element.
     The numbers will be between -10^5 and 10^5.
     
     Hint:
     Use a dictionary ([Int: Int]) to count occurrences of each element.
     ```
     */
    
    override init() {
        super.init()
        performTests()
    }
    
    func performTests() {
        // Test Cases
        let testCases: [(input: [Int], expected: Int)] = [
            ([1, 3, 2, 3, 4, 1, 3], 3),
            ([7, 7, 8, 8, 9, 9], 7),  // Any of 7, 8, or 9 could be correct
            ([10, 20, 10, 30, 10, 20, 20], 10),
            ([5, 5, 5, 5], 5),
            ([100], 100),
            ([-1, -2, -1, -2, -1], -1)  // -1 appears the most
        ]
        
        // Running Tests
        for testCase in testCases {
            let result = mostFrequentElement(testCase.input)
            let passed = result == testCase.expected
            print("Input: \(testCase.input) -> Output: \(result) | Expected: \(testCase.expected) | Pass: \(passed ? "✅" : "❌")")
        }
    }
    
    func mostFrequentElement(_ inputArray: [Int]) -> Int {
        //  Use a set for each int as the following: [value: count]
        var currentFrequencies: [Int: Int] = [:]
        
        //  Set the base
        guard var mostFrequentElement = inputArray.first
        else {
            print("ERROR: A Single element is required")
            return -1
        }
        
        for item in inputArray {
            currentFrequencies[item, default: 0] += 1
            
            //  If the value is higher than the most frequent element, change it
            if let currentValue = currentFrequencies[item]
                , let maxItemAlready = currentFrequencies[mostFrequentElement]
                , currentValue > maxItemAlready {
                mostFrequentElement = currentValue
            }
        }
        
        return mostFrequentElement
    }
}
