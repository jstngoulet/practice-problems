
/**
    Merge 2 Arrays (unsorted)
*/

import Foundation

class Merge2Arrays: Problem {
    
    override func performTests() {
        typealias TestCase = (ar1: [Int], ar2: [Int], expected: [Int])
        let tests: [TestCase] = [
            ([], [], []),                               // both empty
            ([1, 3, 5], [], [1, 3, 5]),                 // second empty
            ([], [2, 4, 6], [2, 4, 6]),                 // first empty
            ([1, 3, 5], [2, 4, 6], [1, 2, 3, 4, 5, 6]), // interleaved merge
            ([1, 2, 3], [4, 5, 6], [1, 2, 3, 4, 5, 6]), // all from l1 first
            ([4, 5, 6], [1, 2, 3], [1, 2, 3, 4, 5, 6]), // all from l2 first
            ([1, 1, 2], [1, 3, 4], [1, 1, 1, 2, 3, 4]), // with duplicates
        ]
        
        let stringTests: [(ar1: [String], ar2: [String], expected: [String])] = [
            (["a", "c", "e"], [], ["a", "c", "e"]),
            ([], ["b", "d", "f"], ["b", "d", "f"]),
            (["a", "c", "e"], ["b", "d", "f"], ["a", "b", "c", "d", "e", "f"]),
            (["apple", "orange"], ["banana", "peach"], ["apple", "banana", "orange", "peach"]),
            (["aa", "ab"], ["aa", "ac"], ["aa", "aa", "ab", "ac"])
        ]
        
        for (iter, test) in tests.enumerated() {            
            //  Now that we merge the 2 lists, do basic
            let result = merge(ar1: test.0, ar2: test.1)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\tarr1: \(test.0)\t\tarr2: \(test.1)\t\tResult: \(result)")
        }
        
        for (iter, test) in stringTests.enumerated() {            
            //  Now that we merge the 2 lists, do basic
            let result = merge(ar1: test.0, ar2: test.1)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\tarr1: \(test.0)\tarr2: \(test.1) Result: \(result)")
        }
    }
    
    
    func merge<T: Comparable>(ar1: [T], ar2: [T]) -> [T] {
        
        var finalArray: [T] = []
        var leftIter: Int = 0, rightIter: Int = 0
        
        if ar1.isEmpty { return ar2 }
        if ar2.isEmpty { return ar1 }
        
        while leftIter < ar1.count, rightIter < ar2.count {
            let leftVal = ar1[leftIter]
            let rightVal = ar2[rightIter]
            
            if leftVal <= rightVal {
                finalArray.append(leftVal)
                leftIter += 1
            } else {
                finalArray.append(rightVal)
                rightIter += 1
            }
            
        }
            
        finalArray += ar1[leftIter..<ar1.count]
        finalArray += ar2[rightIter..<ar2.count]        
        
        return finalArray
    }
    
}