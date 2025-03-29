//
//  Fibonaci.swift
//  
//
//  Created by Justin Goulet on 3/24/25.
//

import Foundation

class Fibonaci {
    
    
    /**
     Problem: Fibonacci Sequence
     Write a function fibonacci that takes an integer n and returns the n-th Fibonacci number.
     
     Fibonacci Sequence:
     The Fibonacci sequence is a series of numbers where each number is the sum of the two preceding ones, starting from 0 and 1. The sequence looks like this:
     
     0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...
     
     Function Signature:
     ```swift
     func fibonacci(_ n: Int) -> Int
     ```
     
     Example:
     ```swift
     fibonacci(0)
     // Output: 0
     
     fibonacci(1)
     // Output: 1
     
     fibonacci(5)
     // Output: 5
     
     fibonacci(10)
     // Output: 55
     ```
     
     Constraints:
     The input n is a non-negative integer (0 ≤ n ≤ 30).
     
     Hints:
     You can solve this with either a recursive or an iterative approach. Iterative is more efficient for larger numbers.
     For n = 0, return 0. For n = 1, return 1.
     */
    
//    override init() {
//        super.init()
//        
//        print(fibonacci(0))
//        // Output: 0
//        
//        print(fibonacci(1))
//        // Output: 1
//        
//        print(fibonacci(5))
//        // Output: 5
//        
//        print(fibonacci(10))
//        // Output: 55
//        
//    }
    
    func fibonacci(_ n: Int) -> Int {
        var fibNumbers: [Int] = [0, 1]
        var fibCount = fibNumbers.count
        
        if fibCount > n {
            return fibNumbers[n]
        }
        
        //       else, calculate and append
        while fibCount <= n {
            let newNum = fibNumbers[fibCount - 1] + fibNumbers[fibCount - 2]
            fibNumbers.append(newNum)
            fibCount += 1
        }
        return fibNumbers[n]
    }
    
}
