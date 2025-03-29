//
//  GridPath.swift
//  
//
//  Created by Justin Goulet on 3/27/25.
//
import Foundation

class GridPath: NSObject {
    
    /**
     Problem: Unique Paths in a Grid
     Description:
     
     A robot is located at the top-left corner of an m x n grid. The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid.
     
     How many unique paths are there to reach the bottom-right corner?
     
     Constraints:
     1 ≤ m, n ≤ 100
     The grid's dimensions are within reasonable limits for dynamic programming.
     Function Signature:
     ```swift
     func uniquePaths(_ m: Int, _ n: Int) -> Int
     ```
     Example 1:
     Input: m = 3, n = 7
     Output: 28
     Explanation: There are 28 unique paths to the bottom-right corner.
     
     Example 2:
     Input: m = 3, n = 2
     Output: 3
     Explanation: There are 3 unique paths to the bottom-right corner.
     
     Example 3:
     Input: m = 1, n = 1
     Output: 1
     Explanation: There's only 1 way to stay at the start position.
     
     Hint:
     
     You can use dynamic programming to build a solution that calculates the number of ways to reach each cell in the grid.
     Think about the number of ways to reach a position based on the number of ways to reach the previous cells (above and to the left).
     */
    
    func performTests() {
        let testCases: [(m: Int, n: Int, expectedResult: Int)] = [
            (m: 3, n: 7, expectedResult: 28),  // Example 1
            (m: 3, n: 2, expectedResult: 3),   // Example 2: 3x2 grid (3 paths)
            (m: 7, n: 3, expectedResult: 28),  // 7x3 grid (28 paths)
            (m: 1, n: 1, expectedResult: 1),   // 1x1 grid (only 1 path)
            (m: 5, n: 5, expectedResult: 70),  // 5x5 grid (70 paths)
            (m: 10, n: 10, expectedResult: 48620), // 10x10 grid (48620 paths)
            (m: 2, n: 1, expectedResult: 1),   // 2x1 grid (only 1 path)
            (m: 1, n: 10, expectedResult: 1),  // 1x10 grid (only 1 path)
            (m: 6, n: 6, expectedResult: 252), // 6x6 grid (252 paths)
            (m: 4, n: 6, expectedResult: 15),  // 4x6 grid (15 paths)
        ]
        
        for testCase in testCases {
            let result = uniquePaths(testCase.m, testCase.n)
            print("Test case: m = \(testCase.m), n = \(testCase.n)")
            print("Expected: \(testCase.expectedResult), Got: \(result)")
            print(result == testCase.expectedResult ? "✅ Passed" : "❌ Failed")
            print("---")
        }
        
    }
    
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var dynamicProgrammingArray: [Int] = Array(repeating: 1, count: n)
        
        for _ in 1..<m {
            for j in 1..<n {
                dynamicProgrammingArray[j] += dynamicProgrammingArray[j - 1]
            }
        }
        
        return dynamicProgrammingArray[n - 1]
    }
}
