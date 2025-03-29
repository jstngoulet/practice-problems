//
//  MaxDiners.swift
//  
//
//  Created by Justin Goulet on 3/28/25.
//

import Foundation

class MaxDiners: NSObject {
    func performTests() {
        typealias TestCase = (seatCount: Int, spaceBetween: Int, seatsTaken: Int, seatsAssigned: [Int], expected: Int)
        let testCases: [(N: Int, K: Int, M: Int, S: [Int], expectedResult: Int)] = [
            (10, 1, 2, [2, 6], 3),   // Seats at [2,6], can add at [4,9,10] → 3
            (15, 2, 3, [3, 8, 14], 3), // Seats at [3,8,14], can add at [1,6,11] → 3
            (10, 2, 0, [], 3),       // No seats taken, can fit at [1,4,7,10] → 3
            (20, 3, 5, [2, 5, 8, 11, 14], 2), // Limited gaps, can add at [18, 20] → 2
            (5, 1, 1, [3], 2)        // Only 1 seat taken, can add at [1,5] → 2
        ]
        
        let inputSize = 25
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
            let output = getMaxAdditionalDinersCount(testCase.N, testCase.K, testCase.M, testCase.S)
            let passed = output == testCase.expectedResult ? "✅" : "❌"
            
            let inputStr = testCase.S.map { "\($0)" }.joined(separator: ", ")
            let row = formatRow(["\(index + 1)", "[\(inputStr)]", "\(testCase.expectedResult)", "\(output)", passed])
            
            print(row)
        }
        
        print(separator)
    }
    
    /**
     /// [0, 1, 0, 0, 0, 1, 0, 0, 0, 0]
     N = 10 //  Number of seats
     k = 1  //  Space between
     M = 2  //  Seats taken
     
     S = [2, 6] //  Seats taken
     
     Create an array to represent above.
     Then, for every seat taken, determine if a new diner can fit bwtween them consider the range
     Then, slice it down
     
     For the above, a seat should be added at 4, 8 and 10, so shoudl return 3
     
     A cafeteria table consists of a row of N seats, numbered from 1 to N from left to right. Social distancing guidelines require that every diner be seated such that K seats to their left and K seats to their right (or all the remaining seats to that side if there are fewer than K) remain empty.
     There are currently M diners seated at the table, the ith of whom is in seat Si
     ​    
     . No two diners are sitting in the same seat, and the social distancing guidelines are satisfied.
     Determine the maximum number of additional diners who can potentially sit at the table without social distancing guidelines being violated for any new or existing diners, assuming that the existing diners cannot move and that the additional diners will cooperate to maximize how many of them can sit down.
     Please take care to write a solution which runs within the time limit.
     */
    
    func getMaxAdditionalDinersCount(_ N: Int, _ K: Int, _ M: Int, _ S: [Int]) -> Int {
        guard M > 0 else {
            // If there are no occupied seats, fit as many diners as possible.
            return (N + K) / (K + 1)
        }
        
        let sortedS = S.sorted()
        var maxDiners = 0
        
        // Check space before the first occupied seat
        let firstGap = sortedS[0] - 1
        maxDiners += firstGap / (K + 1)
        
        // Check gaps between occupied seats
        for i in 0..<M-1 {
            let gap = sortedS[i+1] - sortedS[i] - 1
            maxDiners += max(0, (gap - K) / (K + 1))
        }
        
        // Check space after the last occupied seat
        let lastGap = N - sortedS[M-1]
        maxDiners += lastGap / (K + 1)
        
        return maxDiners
    }
}
