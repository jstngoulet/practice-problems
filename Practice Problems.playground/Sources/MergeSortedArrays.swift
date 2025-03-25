//
//  MergeSortedArrays.swift
//  
//
//  Created by Justin Goulet on 3/25/25.
//

import Foundation

class MergeSortedArrays: NSObject {
    
    /**
     Problem: Merge Sorted Arrays
     Description
     
     You are given two sorted integer arrays arr1 and arr2. Your task is to merge them into a single sorted array without using the built-in sorting function.
     
     Example
     ```swift
     let arr1 = [1, 3, 5, 7]
     let arr2 = [2, 4, 6, 8]
     print(mergeSortedArrays(arr1, arr2)) // Expected: [1, 2, 3, 4, 5, 6, 7, 8]
     ```
     Constraints
     
     The input arrays are already sorted in ascending order.
     The function should have a time complexity of O(n + m), where n is the length of arr1 and m is the length of arr2.
     The function should return a new array that contains all elements from both input arrays, sorted.
     
     Function Signature
     ```swift
     func mergeSortedArrays(_ arr1: [Int], _ arr2: [Int]) -> [Int]
     ```
     */
    
    override init() {
        super.init()
        performTests()
    }
    
    
    func performTests() {
        let testCases: [(arr1: [Int], arr2: [Int], expected: [Int])] = [
            // Test Case 1: Merging two sorted arrays of equal length
            ([1, 3, 5], [2, 4, 6], [1, 2, 3, 4, 5, 6]),
            
            // Test Case 2: Merging two sorted arrays where one is longer
            ([1, 2, 3], [4, 5, 6, 7, 8], [1, 2, 3, 4, 5, 6, 7, 8]),
            
            // Test Case 3: Merging when one array is empty
            ([], [1, 2, 3], [1, 2, 3]),
            
            // Test Case 4: Merging when both arrays are empty
            ([], [], []),
            
            // Test Case 5: Merging with duplicate values
            ([1, 2, 2, 3], [2, 3, 4, 4], [1, 2, 2, 2, 3, 3, 4, 4]),
            
            // Test Case 6: Merging arrays with negative numbers
            ([-5, -3, -1], [-4, -2, 0], [-5, -4, -3, -2, -1, 0]),
            
            // Test Case 7: Merging arrays with already merged values
            ([1, 2, 3, 4], [1, 2, 3, 4], [1, 1, 2, 2, 3, 3, 4, 4])
        ]
        
        testCases.forEach {
            let result = mergeSortedArrays($0.arr1, $0.arr2)
            let pass = result == $0.expected
            print("Input: \($0.arr1) + \($0.arr2) -> Output: \(result) | Expected: \($0.expected) | Pass: \(pass ? "✅" : "❌")")
        }
        
    }
    
    func mergeSortedArrays(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        
        var mergedArray: [Int] = []
        var array1Index: Int = 0
        var array2Index: Int = 0
        
        let array1Count: Int = arr1.count
        let array2Count: Int = arr2.count
        
        while (array1Index < array1Count && array2Index < array2Count) {
            
            if arr1[array1Index] < arr2[array2Index] {
                mergedArray.append(arr1[array1Index])
                array1Index += 1
            } else if arr1[array1Index] > arr2[array2Index] {
                mergedArray.append(arr2[array2Index])
                array2Index += 1
            }
            
        }
        
        //  Add remaining
        mergedArray.append(contentsOf: arr1[array1Index...])
        mergedArray.append(contentsOf: arr2[array2Index...])
        
        return mergedArray
    }
}
