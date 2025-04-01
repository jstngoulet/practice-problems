//
//  RotaryLock2.swift
//  
//
//  Created by Justin Goulet on 3/31/25.
//
import Foundation

class RotaryLock2 : NSObject {
    
    /**
     You are trying to open a lock. The lock comes with 2 wheels, each of which has the integers from
     1 to N, arranged in a circle in order around it (with integers 1 and N adjacent to each other). Each wheel
     is initially set to 1.
     
     It takes 1 second to rotate the wheen by 1 unit to an adjacent integer in either direction, and takes no time
     to select an integer once the wheel is pointing at it.
     
     The lock will open if you enter a certain code, C. The code consists of M integers, the ith of which
     is Ci. For each integer in teh sequence, you may select it with either of the 2 wheels. Determine
     the minimum  number of seconds required to select  all of M of the codes integers in order.
     */
    
    func performTests() {
        typealias TestCase = (numbersInCombo: Int, combinationLength: Int, lockCombination: [Int], expectedTries: Int)
        let testCases: [TestCase] = [
            (3, 3, [1, 2, 3], 2),
            (10, 4, [9, 4, 4, 8], 6),
            (3, 3, [1, 2, 3], 2),
            (10, 4, [9, 4, 4, 8], 6),
            (5, 5, [5, 1, 3, 2, 4], 6),
            (6, 3, [3, 6, 2], 4),
            (7, 6, [7, 1, 6, 2, 4, 3], 6)
        ]
        
        // 🔍 Run test cases
        let inputSize = (testCases.map { Array($0.lockCombination).description.count + 1 }.max() ?? 0)
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
            let output = getMinCodeEntryTime(testCase.0, testCase.1, testCase.2)
            let passed = output == testCase.expectedTries ? "✅" : "❌"
            
            let inputStr = testCase.lockCombination.map { "\($0)" }.joined(separator: ", ")
            let row = formatRow(["\(index + 1)", "[\(inputStr)]", "\(testCase.expectedTries)", "\(output)", passed])
            
            print(row)
        }
        
        print(separator)
    }
    
    // Write any import statements here
    
    func getMinCodeEntryTime(_ N: Int, _ M: Int, _ C: [Int]) -> Int {
        
        guard !C.isEmpty, M == C.count, let max = C.max(), max <= N else { return 0 }
        
        //  Create the starting digits
        var leftDialNumber: Int = 1, rightDialNumber: Int = 1
        
        //  Get the total entry time, increased
        var totalEntryTime: Int = 0
        
        //  For every number in C, which is the combination,
        //  We need to find the min distance from both dials to the next number
        for input in C {
            // If both dials are already on the input, do nothing
            if leftDialNumber == input || rightDialNumber == input {
                continue
            }
            
            // Calculate the clockwise and counter-clockwise distances for both dials
            let leftClockwise = abs(input - leftDialNumber)
            let leftCounterClockwise = N - leftClockwise
            let leftDialDistance = min(leftClockwise, leftCounterClockwise)
            
            let rightClockwise = abs(input - rightDialNumber)
            let rightCounterClockwise = N - rightClockwise
            let rightDialDistance = min(rightClockwise, rightCounterClockwise)
            
            // Move the closer dial
            if leftDialDistance <= rightDialDistance {
                leftDialNumber = input
                totalEntryTime += leftDialDistance
            } else {
                rightDialNumber = input
                totalEntryTime += rightDialDistance
            }
        }
        
        
        return totalEntryTime
    }
    
}
