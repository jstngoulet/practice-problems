/**
    File for all Sorting algortihms
*/

import Foundation

class Sorting: Problem {
 
    override func performTests() {
        typealias TestCase = (list: [Int], expected: [Int])
        let tests: [TestCase] = [
            // Edge cases
            ([], []),
            ([1], [1]),
            
            // Already sorted
            ([1, 2, 3], [1, 2, 3]),

            // Reverse order
            ([5, 4, 3, 2, 1], [1, 2, 3, 4, 5]),

            // Duplicates
            ([3, 1, 2, 3], [1, 2, 3, 3]),

            // All same elements
            ([7, 7, 7, 7], [7, 7, 7, 7]),

            // Random unsorted
            ([8, 3, 1, 7, 0, 10, 2], [0, 1, 2, 3, 7, 8, 10]),
            ([4, 2, 6, 9, 1, 7], [1, 2, 4, 6, 7, 9]),

            // Negative numbers
            ([-3, -1, -4, 2, 0], [-4, -3, -1, 0, 2]),

            // Large values
            ([1000, 999, 1001, -1000], [-1000,  999, 1000, 1001])
        ]
        
        for (iter, test) in tests.enumerated() {
            let qs = timed("Quicksort") {
                quickSort(list: test.list)
            }
            var isPassed = qs == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")")
            
            let ms = timed("MergeSort") {
                mergeSort(list: test.list)
            }
            isPassed = ms == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")")
        }
        
    }
    
    func timed<T>(_ label: String = "Execution", block: () -> T) -> T {
        let start = Date()
        let result = block()
        let elapsed = Date().timeIntervalSince(start)
        print("\(label) took \(String(format: "%.4f", elapsed)) seconds")
        return result
    }
    
    func quickSort<T: Comparable>(list: [T]) -> [T] {
    
        //  Step 1: 
        //  Pick a pivot point. 
        guard let pivot = list.last else { return list }
        
        //  Step 2: 
        //  Partition: 
        let group1 = list.filter({$0 < pivot})
        let group2 = list.filter({ $0 > pivot })
        let pivotGroup = list.filter({ $0 == pivot })
        
        return quickSort(list: group1) + pivotGroup + quickSort(list: group2)
    }
    
    func mergeSort<T: Comparable>(list: [T]) -> [T] {
        if list.count <= 1 { return list }
        
        //  Split the array into halves
        let left = Array(list[..<(list.count/2)])
        let right = Array(list[((list.count/2)...)])
        
        //  Sort the left and right side
        let sortedLeft = mergeSort(list: left)
        let sortedRight = mergeSort(list: right)
        
        return mergeSortMerge(sortedLeft, sortedRight)
    }
    
    private func mergeSortMerge<T: Comparable>(_ a: [T], _ b: [T]) -> [T] {
        var result: [T] = []
        var leftIter: Int = 0, rightIter: Int = 0
        
        while leftIter < a.count && rightIter < b.count {
            if a[leftIter] < b[rightIter] {
                result.append(a[leftIter])
                leftIter += 1
            } else {
                result.append(b[rightIter])
                rightIter += 1
            }
        }
        
        result += a[leftIter..<a.count]
        result += b[rightIter..<b.count]
        
        return result
    }
    
}