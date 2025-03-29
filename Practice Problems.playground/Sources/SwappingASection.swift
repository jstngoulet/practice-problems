//
//  SwappingASection.swift
//  
//
//  Created by Justin Goulet on 3/27/25.
//

import Foundation

class SwappSection: NSObject {
    
    /**
     Problem Description
     Given a list, the task is to sort it using the following method: reverse(lst, i, j), which reverses the sublist of lst from index i to index j, inclusive. Your goal is to implement the sorting of the list using only this reverse operation.
     
     Constraints
     The list contains integers.
     The reverse operation is the only allowed operation to modify the list.
     You must figure out how to repeatedly apply reverse to sort the list.
     */
    func performTests() {
        typealias TestCase = (input: [Int], start: Int, end: Int, expected: [Int])
        
        let testCases: [TestCase] = [
            // Example 1: Reverse a sublist from index 0 to 3
            ([4, 3, 2, 1], 0, 3, [1, 2, 3, 4]),  // Reverse the entire list to sort it
            
            // Example 2: Reverse a sublist from index 0 to 2
            ([2, 3, 1], 0, 2, [1, 3, 2]),  // Reverse from index 0 to 2 to make it [1, 3, 2]
            
            // Example 3: Reverse a sublist from index 1 to 2
            ([1, 2, 3], 1, 2, [1, 3, 2]),  // Reverse sublist [2, 3] to get [1, 3, 2]
            
            // Edge case: Single element (No change)
            ([5], 0, 0, [5]),  // Reversing a single element doesn’t change the list
            
            // Edge case: Empty list (No change)
            ([], 0, 0, []),  // An empty list remains unchanged
            
            // Example with larger list: Reverse a portion in the middle
            ([1, 2, 3, 4, 5], 1, 3, [1, 4, 3, 2, 5]),  // Reverse the sublist [2, 3, 4] to get [1, 4, 3, 2, 5]
            
            // Example with larger numbers: Reverse part of the list
            ([1000, 2000, 3000, 4000], 1, 3, [1000, 4000, 3000, 2000]),  // Reverse [2000, 3000, 4000] to get [1000, 4000, 3000, 2000]
            
            // Test case with a larger list (reversing the sublist in the middle)
            ([7, 5, 3, 8, 6, 1, 4, 2], 2, 5, [7, 5, 1, 6, 8, 3, 4, 2]),  // Reverse [3, 8, 6, 1] to get [7, 5, 1, 6, 8, 3, 4, 2]
            
            //  Test Case longer
            (Array(0...18), 3, 14, Array(0..<3) + Array(Array(3...14).reversed()) + Array(15...18)),
            
            // Test case with negative values: Reverse the sublist with negative numbers
            ([-5, -3, -4, -2], 1, 3, [-5, -2, -4, -3]),  // Reverse [-3, -4, -2] to get [-5, -2, -4, -3]
            
            // Test case with all equal values (No change expected)
            ([9, 9, 9, 9], 0, 3, [9, 9, 9, 9]),  // Reversing the entire list with identical elements gives the same list
        ]
        
        // 🔍 Run test cases
        let inputSize = (testCases.map { Array($0.input).description.count + 1 }.max() ?? 0)
        let colWidths = [8, inputSize, inputSize, inputSize, 8]  // Adjust column widths dynamically
        
        func formatRow(_ values: [String]) -> String {
            return zip(values, colWidths).map { $0.padding(toLength: $1, withPad: " ", startingAt: 0) }.joined(separator: "| ")
        }
        
        let header = formatRow(["Test #", "Input", "Expected", "Output", "Result"])
        let separator = String(repeating: "-", count: header.count)
        
        print(separator)
        print(header)
        print(separator)
        
        for (index, testCase) in testCases.enumerated() {
            let output = reverse(list: testCase.input, from: testCase.start, to: testCase.end)
            let passed = output == testCase.expected ? "✅" : "❌"
            
            let inputStr = testCase.input.map { "\($0)" }.joined(separator: ", ")
            let row = formatRow(["\(index + 1)", "[\(inputStr)]", "\(testCase.expected)", "\(output)", passed])
            
            print(row)
        }
        
        print(separator)
    }
    
    func reverse<T>(list: [T], from i: Int, to j: Int) -> [T] {
        let count = list.count
        
        guard i < count && j < count && count > 1
        else { return list }
        
        let reversedSection: [T] = Array(list[i...j]).reversed()
        return Array(list[0..<i]) + Array(reversedSection) + list[(j+1)...]
        
        // Below works too, if asked to break it out
        //        let listCount = list.count
        //        let arraySwapCount = j - i
        //
        //        guard i < listCount
        //                && j < listCount
        //                && listCount > 1
        //                && i < j
        //        else { return list }
        //
        //        var newArray: [T] = list
        //        var arrayToReverse = Array(newArray[i...j])
        //
        //        var leftIter: Int = 0
        //
        //        while leftIter < arraySwapCount - leftIter {
        //            arrayToReverse.swapAt(leftIter, arraySwapCount - leftIter)
        //            leftIter += 1
        //        }
        //
        //        //return t for now
        //        return Array(list[..<i]) + arrayToReverse + Array(list[(j+1)...])
    }
}
