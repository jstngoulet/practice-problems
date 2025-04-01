//
//  RotaryLock.swift
//  
//
//  Created by Justin Goulet on 3/29/25.
//
import Foundation

class RotaryLock {
    func performTests() {
        typealias TestCase = (N: Int, M: Int, C: [Int], expected: Int)
        
        let tests: [TestCase] = [
            (3, 3, [1, 2, 3], 2),
            (10, 4, [9, 4, 4, 8], 11),
            (N: 3, M: 3, C: [1, 2, 3], expected: 2),   // Simple increasing sequence
            (N: 3, M: 3, C: [3, 2, 1], expected: 3),   // Simple decreasing sequence
            (N: 12, M: 5, C: [1, 6, 11, 6, 1], expected: 10), // Moves across the wheel
            (N: 3, M: 3, C: [1, 2, 3], expected: 2),  // Moving 1 → 2 (1 sec), 2 → 3 (1 sec)
            (N: 3, M: 3, C: [3, 2, 1], expected: 2),  // Moving 1 → 3 (1 sec), 3 → 2 (1 sec)
            (N: 12, M: 3, C: [1, 11, 2], expected: 3),  // Moving 1 → 11 (2 sec), 11 → 2 (1 sec)
            (N: 5, M: 4, C: [4, 2, 5, 3], expected: 6),  // 1 → 4 (2 sec), 4 → 2 (2 sec), 2 → 5 (2 sec)
            (N: 10, M: 5, C: [5, 9, 1, 6, 3], expected: 10), // Complex case with multiple turns
            (N: 3, M: 3, C: [1, 2, 3], expected: 2),   // Moves: 1 → 2 (1s), 2 → 3 (1s) ✅
            (N: 3, M: 3, C: [3, 2, 1], expected: 3),   // Moves: 1 → 3 (1s), 3 → 2 (1s) ✅
            (N: 12, M: 3, C: [1, 11, 2], expected: 3), // Moves: 1 → 11 (2s), 11 → 2 (1s) ✅
            (N: 5, M: 4, C: [4, 2, 5, 3], expected: 6),// Moves: 1 → 4 (2s), 4 → 2 (2s), 2 → 5 (2s) ✅
            (N: 10, M: 5, C: [5, 9, 1, 6, 3], expected: 10), // ✅ Corrected Logic
            //            (N: 8, M: 3, C: [7, 4, 1], expected: 6),   // Moves: 1 → 7 (2s), 7 → 4 (3s), 4 → 1 (1s) ✅
            //            (N: 3, M: 3, C: [1, 2, 3], expected: 2),   // Start at 1 -> 2 seconds to go to 2 -> 2 seconds to go to 3
            //            (N: 3, M: 3, C: [3, 2, 1], expected: 3),   // Start at 1 -> 1 second to go to 3 -> 1 second to go to 2 -> 1 second to go to 1
            //            (N: 5, M: 5, C: [1, 3, 5, 4, 2], expected: 7),  // Start at 1 -> 2 seconds to go to 3 -> 2 seconds to go to 5 -> 1 second to go to 4 -> 2 seconds to go to 2
            //            (N: 7, M: 4, C: [7, 1, 3, 5], expected: 10),  // Start at 1 -> 6 seconds to go to 7 -> 0 seconds to go to 1 -> 2 seconds to go to 3 -> 2 seconds to go to 5
            //            (N: 10, M: 6, C: [1, 5, 3, 8, 2, 6], expected: 21), // Start at 1 -> 4 seconds to go to 5 -> 2 seconds to go to 3 -> 5 seconds to go to 8 -> 6 seconds to go to 2 -> 4 seconds to go to 6
            //            (N: 6, M: 2, C: [6, 3], expected: 8)  // Start at 1 -> 5 seconds to go to 6 -> 3 seconds to go to 3
            
            
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = getMinCodeEntryTime(test.N, test.M, test.C)
            let isPassed: Bool = result == test.expected
            
            print("Test \(iter + 1):: \(isPassed)")
        }
    }
    
    /**
     You're trying to open a lock. The lock comes with a wheel which has the integers 1 to N, arranged in a circular order around it (with integers 1 and N adjacent to each other). The wheel is initallly pointint to one.
     
     For example, the following depics the lock N = 12 (as is presented in the sample case
     ( Refer to a clock ), but with 1 at top, instead of first position.
     
     It takes one second to roate the wheel by one unit to an adjacent integer in either direction, and it takes no time to select an integer once the wheel is pointint to it.
     
     The lock will open if you enter a certain code. Teh code consists of a sequence of M integers, the ith of which is Ci.
     
     Determine the number of seconds required to select all M of the codes integers in order.
     
     Please take care to write a solution that runs within the time limit.
     
     Function definition:
     ```swift
     getMinCodeEntryTime(_ N: Int, M: Int, C: [Int]
     ```
     
     Sample cases:
     1.
     N = 3
     M = 3
     C = [1, 2, 3] (expected return = 2)
     
     2.
     N = 10
     M = 4
     C = [9, 4, 4, 8]
     */
    
    func getMinCodeEntryTime(
        _ N: Int,
        _ M: Int,
        _ C: [Int]
    ) -> Int {
        var secondsCounted = 0
        var lastNumber = 1 // Wheel starts at 1
        
        for number in C {
            let forward = abs(number - lastNumber)
            let reverse = N - abs(number-lastNumber)
            secondsCounted += min(forward, reverse)
            lastNumber = number
        }
        
        return secondsCounted
    }
}
