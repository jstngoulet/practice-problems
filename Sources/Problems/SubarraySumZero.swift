/**
	Determines if there exists any contiguous subarray that sums to 0.

	- Parameter nums: An array of integers.
	- Returns: True if a subarray with sum 0 exists, otherwise false.
*/

import Foundation

class SubarraySumZero: Problem {

	typealias TestCase = (nums: [Int], expected: Bool)

	override func performTests() {
		print("Running tests for: \(Self.self)")

		let tests: [TestCase] = [
			// Subarray [1, 2, -3] sums to 0
			(nums: [1, 2, -3, 4], expected: true),

			// No subarray sums to 0
			(nums: [1, 2, 3], expected: false),

			// Single 0 element
			(nums: [0], expected: true),

			// Full array sums to 0
			(nums: [4, -4], expected: true),

			// Zero in the middle
			(nums: [4, -1, -3, 1, 2], expected: true),

			// Long array, no zero subarray
			(nums: [1, 2, 3, 4, 5, 6], expected: false),

			// Empty array
			(nums: [], expected: false)
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 40, expected: 10, actual: 10, pass: 6)

		let header = "| \(pad("Input", to: columnWidths.input)) | \(pad("Expected", to: columnWidths.expected)) | \(pad("Actual", to: columnWidths.actual)) | \(pad("Pass", to: columnWidths.pass))  |"
		let separator = String(repeating: "-", count: header.count)

		print(header)
		print(separator)

		for test in tests {
			let result = hasZeroSumSubarray(test.nums)
			let pass = result == test.expected ? "✅" : "❌"

			let inputStr = "[\(test.nums.prefix(10).map(String.init).joined(separator: ","))" + (test.nums.count > 10 ? ", ..." : "") + "]"

			print("| \(pad(inputStr, to: columnWidths.input)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Checks whether any contiguous subarray sums to zero.

		- Parameter nums: The array of integers to scan.
		- Returns: True if a zero-sum subarray exists, false otherwise.
	*/
	func hasZeroSumSubarray(_ nums: [Int]) -> Bool {
        var prefixSums: Set<Int> = [0]  //  Start at 0
        var currentSum: Int = 0
        
        for number in nums {
            currentSum += number
            if prefixSums.contains(currentSum) { return true }
            prefixSums.insert(currentSum)
        }
        
		return false
	}
}
