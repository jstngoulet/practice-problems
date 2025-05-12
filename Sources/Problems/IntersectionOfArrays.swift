import Foundation

class IntersectionOfTwoArrays: Problem {
    /**
     Given two arrays, find their intersection.
     Each element in the result must be unique and you may return the result in any order.

     - Parameters:
       - nums1: First list of integers.
       - nums2: Second list of integers.
     - Returns: An array containing the unique intersection elements.
     */
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        //  One liner (N * M)
        // return nums1.filter({ nums2.contains($0) })
        
        //  Walkthrough (more optimized)
        var num1Iter: Int = 0, num2Iter: Int = 0
        var intersecting: Set<Int> = []
        
        let sorted1 = nums1.sorted()
        let sorted2 = nums2.sorted()
        
        while num1Iter < sorted1.count && num2Iter < sorted2.count {
            let currentNum1 = sorted1[num1Iter]
            let currentNum2 = sorted2[num2Iter]
            
            if currentNum1 == currentNum2 {
                intersecting.insert(currentNum1)
                num1Iter += 1
                num2Iter += 1
            } else if currentNum1 < currentNum2 {
                num1Iter += 1
            } else if currentNum2 < currentNum1 {
                num2Iter += 1
            }
        }
        
        return Array(intersecting)
    }

    override func performTests() {
        print("=== IntersectionOfTwoArrays Tests ===")
        let header = "| #  | Input1            | Input2            | Expected   | Actual     | Pass |"
        let separator = String(repeating: "-", count: header.count)

        typealias TestCase = (nums1: [Int], nums2: [Int], expected: [Int])
        let tests: [TestCase] = [
            // Common elements
            ([1, 2, 2, 1], [2, 2], [2]),
            // Disjoint arrays
            ([4, 9, 5], [1, 2, 3], []),
            // Multiple common
            ([4, 9, 5], [9, 4, 9, 8, 4], [4,9]),
            // Identical arrays
            ([1, 2, 3], [1, 2, 3], [1,2,3]),
            // One empty array
            ([], [1, 2], []),
            // Both empty arrays
            ([], [], []),
            // No overlap
            ([1, 3, 5], [2, 4, 6], []),
            // Duplicates in both
            ([1, 2, 2, 1], [2, 2, 2], [2]),
            // Single matching element
            ([7,8,9], [9], [9]),
            // Large overlap
            ([1,2,3,4,5], [3,4,5,6,7], [3,4,5]),
        ]

        print(separator)
        print(header)
        print(separator)

        for (i, test) in tests.enumerated() {
            let result = Set(intersection(test.nums1, test.nums2))
            let expected = Set(test.expected)
            let passed = result == expected ? "✅" : "❌"

            let idx        = "\(i + 1)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let input1Str  = "\(test.nums1)".padding(toLength: 18, withPad: " ", startingAt: 0)
            let input2Str  = "\(test.nums2)".padding(toLength: 18, withPad: " ", startingAt: 0)
            let expectedStr = "\(Array(expected))".padding(toLength: 10, withPad: " ", startingAt: 0)
            let actualStr  = "\(Array(result))".padding(toLength: 10, withPad: " ", startingAt: 0)
            let passStr    = passed.padding(toLength: 4, withPad: " ", startingAt: 0)

            print("| \(idx) | \(input1Str) | \(input2Str) | \(expectedStr) | \(actualStr) | \(passStr) |")
        }

        print(separator)
    }
}
