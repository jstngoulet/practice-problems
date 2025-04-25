import Foundation

/**
	Given an array of integers and a target value, returns the indices of the two numbers that add up to the target.

	- Parameters:
	  - nums: The array of integers.
	  - target: The target sum to find.
	- Returns: A tuple containing the indices of the two numbers that sum to the target, or (-1, -1) if not found.
*/
class TwoSumIndices: Problem {

	typealias TestCase = (input: ([Int], Int), expected: (Int, Int))

	override func performTests() {
		print("Running tests for: \(Self.self)")

		let tests: [TestCase] = [
			// 2 + 7 = 9
			(input: ([2, 7, 11, 15], 9), expected: (0, 1)),

			// 3 + 3 = 6
			(input: ([3, 2, 3], 6), expected: (0, 2)),

			// 2 + 4 = 6
			(input: ([3, 2, 4], 6), expected: (1, 2)),

			// 1 + 3 = 4
			(input: ([1, 2, 3], 4), expected: (0, 2)),

			// Negative numbers: -1 + 1 = 0
			(input: ([-1, -2, -3, -4, -5], -8), expected: (2, 4)),

			// First and last: 5 + 4 = 9
			(input: ([5, 1, 2, 3, 4], 9), expected: (0, 4)),

			// Duplicate numbers
			(input: ([1, 1, 2, 3], 2), expected: (0, 1)),

			// Long array
			(input: ((0..<1000).map { $0 } + [1001], 1999), expected: (998, 1000)),

			// Zero-sum pair
			(input: ([0, 4, 3, 0], 0), expected: (0, 3)),

			// One valid pair near the end
			(input: ([10, 15, 3, 7], 17), expected: (0, 3))
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 30, expected: 14, actual: 14, pass: 6)

		let header: String = "| " + pad("Input (nums, target)", to: columnWidths.input)
			+ " | " + pad("Expected", to: columnWidths.expected)
			+ " | " + pad("Actual", to: columnWidths.actual)
			+ " | " + pad("Pass", to: columnWidths.pass)
			+ " |"

		let separator: String = "|"
			+ String(repeating: "-", count: columnWidths.input + 2) + "|"
			+ String(repeating: "-", count: columnWidths.expected + 2) + "|"
			+ String(repeating: "-", count: columnWidths.actual + 2) + "|"
			+ String(repeating: "-", count: columnWidths.pass + 2) + "|"

		print(header)
		print(separator)

		for test in tests {
			let (nums, target) = test.input
			let result = twoSum(nums, target)
			let pass = result == test.expected ? "✅" : "❌"
			let inputStr = "(\(nums.prefix(5))..., \(target))"
			print("| \(pad(inputStr, to: columnWidths.input)) | \(pad(String(describing: test.expected), to: columnWidths.expected)) | \(pad(String(describing: result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Returns indices of the two numbers that sum to the target.

		- Parameters:
		  - nums: The list of integers.
		  - target: The target sum.
		- Returns: A tuple with the two indices, or (-1, -1) if not found.
	*/
	func twoSum(_ nums: [Int], _ target: Int) -> (Int, Int) {
        /**
            Walkthrough: (Brute Force)
            1, 2, 3, 4, 5 -> 7
            
            1. 1 + 2    != 7
            2. 1 + 3    != 7
            3. 1 + 4    != 7
            
            Walkthrough: (Dict): 
            For every number
                Check to see the difference needed
                If the difference needed exists, return the index
                If not found, save and move on
            
        */
        if nums.count < 2 { return (-1, -1) }
        
        var numMatch: [Int: Int] = [:]
        
        for (lIter, num) in nums.enumerated() {
            let pair = target - num
            if let rIter = numMatch[pair] {
                return (
                    min(lIter, rIter), 
                    max(lIter, rIter)
                )
            }
            numMatch[num] = lIter
        }
        
		return (-1, -1)
	}
}
