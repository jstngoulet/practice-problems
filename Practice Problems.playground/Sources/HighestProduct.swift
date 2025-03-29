//
//  HighestProduct.swift
//  
//
//  Created by Justin Goulet on 3/27/25.
//

import Foundation

class HighestProduct: NSObject {
    
    /**
     🔥 Problem: Maximum Product Subarray
     Description
     
     Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest product, and return that maximum product.
     
     🛠 Constraints
     1 ≤ nums.length ≤ 10^5
     -10 ≤ nums[i] ≤ 10
     The product will always fit within a 32-bit signed integer.
     
     🧩 Example Cases
     Input                      Output      Explanation
     nums = [2,3,-2,4]          6           The subarray [2,3] has the max product 6.
     nums = [-2,0,-1]           0           The subarray [0] has the max product 0.
     nums = [-2,3,-4]           24          The subarray [-2,3,-4] has the max product 24.
     nums = [1,2,3,4]           24          The whole array [1,2,3,4] is the max product.
     nums = [-1,-2,-3,-4]       24          The subarray [-1,-2,-3,-4] has the max product 24.
     
     🔍 Hint 1: Negative Numbers Can Flip the Product
     Unlike the maximum sum subarray (Kadane’s Algorithm), the product can be tricky because a negative number can flip the sign.
     For example:
     If you have [-2, 3, -4], multiplying -2 * 3 gives -6, but adding -4 (-6 * -4) gives 24, which is larger than 3 alone.
     
     🔍 Hint 2: Keep Track of Both Max and Min Product
     Since a negative number can flip the max product into a min product, you should track both the max and min products at each step.
     If nums[i] is negative, swapping the min and max might help.
     
     🔍 Hint 3: Use a Single Pass (O(n) Solution)
     Instead of checking every subarray (O(n²)), traverse the array once.
     Maintain:
     maxProduct (biggest product so far)
     minProduct (smallest product so far, useful when encountering a negative number)
     
     🔍 Hint 4: When to Reset?
     If nums[i] == 0, restart tracking from i+1, since multiplying by 0 always resets the product.
     */
    
    func performTests() {
        typealias TestCase = (input: [Int], expected: Int)
        let tests: [TestCase] = [
            ([2,3,-2,4], 6),                // The subarray [2,3] has the max product 6.
            ([-2,0,-1], 0),                 // The subarray [0] has the max product 0.
            ([1], 1),                       // The only element is 1.
            ([-1], -1),                     // The only element is -1.
            ([0,0,0], 0),                   // The max product is 0.
            ([-2,3,-4], 24),                // The subarray [-2,3,-4] has the max product 24.
            ([-1,-2,-3,-4], 24),            // The subarray [-1,-2,-3,-4] has the max product 24.
            ([-1,2,3,-4,5,-6], 720),        // The subarray [2,3,-4,5,-6] has the max product 720.
            ([-2,0,-3,4,-1,2,1,-5,4], 160), // The subarray [4,-1,2,1] has the max product 48.
            ([0,1,2,3,0,4,5,6], 120),       // The subarray [4,5,6] has the max product 120.
            ([2,2,2,2,2], 32),              // The whole array [2,2,2,2,2] has the max product 32.
            ([-2,-2,-2,-2], 16)             // The subarray [-2,-2,-2,-2] has the max product 16.
        ]
        
        // 🔍 Run test cases
        let colWidths = [8, 35, 10, 10, 8]  // Adjust column widths dynamically
        
        func formatRow(_ values: [String]) -> String {
            return zip(values, colWidths).map { $0.padding(toLength: $1, withPad: " ", startingAt: 0) }.joined(separator: "| ")
        }
        
        let header = formatRow(["Test #", "Input", "Expected", "Output", "Result"])
        let separator = String(repeating: "-", count: header.count)
        
        print(separator)
        print(header)
        print(separator)
        
        for (index, testCase) in tests.enumerated() {
            let output = findMaximumProduct(int: testCase.input)
            let passed = output == testCase.expected ? "✅" : "❌"
            
            let inputStr = testCase.input.map { "\($0)" }.joined(separator: ", ")
            let row = formatRow(["\(index + 1)", "[\(inputStr)]", "\(testCase.expected)", "\(output)", passed])
            
            print(row)
        }
        
        print(separator)
    }
    
    func findMaximumProduct(int values: [Int]) -> Int {
        if values.isEmpty { return 0 }
        
        var maxProduct: Int = values[0]
        var minProduct: Int = values[0]
        var result: Int = values[0]
        
        var index: Int = 1
        
        while index < values.count {
            var currentValue = values[index]
            
            //  Use hint of swapping
            if currentValue < 0 {
                swap(&maxProduct, &minProduct)
            }
            
            maxProduct = max(currentValue, currentValue * maxProduct)
            minProduct = min(currentValue, currentValue * minProduct)
            
            //  Get the max
            result = max(result, maxProduct)
            
            index += 1
        }
        
        return result
    }
}
