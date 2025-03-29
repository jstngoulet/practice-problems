//
//  MergeIntervals.swift
//
//
//  Created by Justin Goulet on 3/28/25.
//

import Foundation

class MergeIntervals: NSObject {
    
    /**
     Problem: Merge Intervals
     Description:
     
     You are given a collection of intervals, where each interval is represented as a pair of integers [start, end] (inclusive). You need to merge all overlapping intervals and return an array of the merged intervals.
     
     Example 1:
     
     Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
     Output: [[1,6],[8,10],[15,18]]
     Explanation: The intervals [1,3] and [2,6] overlap, so they are merged into [1,6].
     Example 2:
     
     Input: intervals = [[1,4],[4,5]]
     Output: [[1,5]]
     Explanation: The intervals [1,4] and [4,5] are considered overlapping because they share a common boundary.
     
     Constraints:
     
     1 <= intervals.length <= 10^4
     intervals[i].length == 2
     0 <= start <= end <= 10^4
     Function Signature:
     ```swift
     func merge(intervals: [[Int]]) -> [[Int]]
     ```
     
     Hints:
     Sorting: First, sort the intervals by the starting value of each interval.
     Merging: Start from the first interval and keep merging overlapping intervals as you go along.
     */
    func performTests() {
        typealias TestCase = (input: [[Int]], expected: [[Int]])
        let testCases: [TestCase] = [
            // Test case 1: Standard overlapping intervals
            ([[1,3], [2,6], [8,10], [15,18]], [[1,6], [8,10], [15,18]]),  // [1,3] and [2,6] overlap and merge into [1,6]
            
            // Test case 2: No overlapping intervals
            ([[1,2], [3,4], [5,6]], [[1,2], [3,4], [5,6]]),  // No overlapping intervals, so they remain the same
            
            // Test case 3: Overlapping intervals with boundary touch
            ([[1,4], [4,5]], [[1,5]]),  // [1,4] and [4,5] touch at the boundary, so they merge into [1,5]
            
            // Test case 4: Single interval
            ([[1,5]], [[1,5]]),  // Only one interval, no change needed
            
            // Test case 5: Multiple intervals with no overlap
            ([[1,3], [5,8], [10,12]], [[1,3], [5,8], [10,12]]),  // No overlap, they stay the same
            
            // Test case 6: Full overlap (one interval inside another)
            ([[1,5], [2,3], [4,6]], [[1,6]]),  // All intervals merge into one: [1,6]
            
            // Test case 7: Multiple overlapping intervals
            ([[1,4], [2,6], [5,7], [8,10]], [[1,7], [8,10]]),  // The first three intervals merge into [1,7], and [8,10] remains as is
            
            // Test case 8: Fully nested intervals
            ([[1,2], [1,3], [2,3]], [[1,3]]),  // All intervals merge into one: [1,3]
            
            // Test case 9: Empty input
            ([], []),  // No intervals, so the result is an empty list
            
            // Test case 10: Intervals with the same start but different end
            ([[1,5], [1,6], [1,7]], [[1,7]]),  // All intervals merge into [1,7] since they have the same start
            
            // Basic merging
            ([[1, 3], [2, 6], [8, 10], [15, 18]],
             [[1, 6], [8, 10], [15, 18]]),
            
            // No merging required
            ([[1, 2], [3, 4], [5, 6]],
             [[1, 2], [3, 4], [5, 6]]),
            
            // Single interval case
            ([[5, 10]],
             [[5, 10]]),
            
            // Fully overlapping intervals
            ([[1, 5], [2, 3], [4, 6]],
             [[1, 6]]),
            
            // Touching intervals
            ([[1, 3], [3, 5]],
             [[1, 5]]),
            
            // Nested intervals
            ([[1, 10], [2, 6], [3, 5]],
             [[1, 10]]),
            
            // Unsorted input
            ([[8, 10], [1, 3], [2, 6]],
             [[1, 6], [8, 10]]),
            
            // Empty input
            ([],
             []),
            
            // Large range intervals
            ([[-100, 0], [-50, 50], [51, 100]],
             [[-100, 50], [51, 100]])
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
            let output = merge(intervals: testCase.input)
            let passed = output == testCase.expected ? "✅" : "❌"
            
            let inputStr = testCase.input.map { "\($0)" }.joined(separator: ", ")
            let row = formatRow(["\(index + 1)", "[\(inputStr)]", "\(testCase.expected)", "\(output)", passed])
            
            print(row)
        }
        
        print(separator)
    }
    
    typealias IntervalUsed = (start: Int, end: Int)
    
    func merge(intervals: [[Int]]) -> [[Int]] {
        let startingIntervals: [IntervalUsed] = intervals.compactMap({
            if $0.count != 2 { return nil }
            return ($0[0], $0[1])
        }).sorted(by: { $0.start < $1.start })
        
        var endingIntervals: [IntervalUsed] = []
        
        //  For every interval, see if it intersects one that already exists.
        //  If it does, grab it, and expand the origina as we go through the
        //  list. If it doesn't, add a new one
        var currentWorkingIter: Int = 0
        var endingIntervalUsed: Int = 0
        var latestRangeChanged: IntervalUsed?
        
        while currentWorkingIter < startingIntervals.count {
            
            let currentStep = startingIntervals[currentWorkingIter]
            
            guard let latestStep = latestRangeChanged
            else {
                latestRangeChanged = currentStep
                endingIntervals.append(currentStep)
                currentWorkingIter += 1
                continue
            }
            
            let doesIntersect = doesIntervalIntersect(latestStep, currentStep)
            
            //  If the latest range changed merges with the current,
            //  Update the latest range change.
            //  Else, add the latest range changed to teh new array
            //  and reset the latest range
            if doesIntersect {
                endingIntervals[endingIntervalUsed] = (latestStep.start, max(latestStep.end, currentStep.end))
                latestRangeChanged = endingIntervals[endingIntervalUsed]
            } else {
                endingIntervals.append(currentStep)
                endingIntervalUsed += 1
                latestRangeChanged = nil
            }
            
            currentWorkingIter += 1
        }
        
        return endingIntervals.compactMap({ [$0.start, $0.end]})
    }
    
    func doesIntervalIntersect(_ interval1: IntervalUsed, _ interval2: IntervalUsed) -> Bool {
        return interval2.start <= interval1.end && interval2.end >= interval1.start
    }
}
