/**
	Determines whether an array contains any duplicate integers.

	- Parameter nums: An array of integers.
	- Returns: True if any integer appears at least twice, otherwise false.
*/

import Foundation

class ContainsDuplicate: Problem {

	typealias TestCase = (nums: [Int], expected: Bool)

	override func performTests() {
		print("Running tests for: \(Self.self)")

		let tests: [TestCase] = [
			// All unique values
			(nums: [1, 2, 3, 4, 5], expected: false),

			// Single duplicate
			(nums: [1, 2, 3, 4, 1], expected: true),

			// Multiple duplicates
			(nums: [5, 5, 5, 5], expected: true),

			// Large input with a single repeated number at the end
			(nums: Array(0...9999) + [9999], expected: true),

			// Only one element
			(nums: [42], expected: false),

			// Empty input
			(nums: [], expected: false)
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 40, expected: 10, actual: 10, pass: 6)

		let header = "| \(pad("Input", to: columnWidths.input)) | \(pad("Expected", to: columnWidths.expected)) | \(pad("Actual", to: columnWidths.actual)) | \(pad("Pass", to: columnWidths.pass)) |"
		let separator = String(repeating: "-", count: header.count)

		print(header)
		print(separator)

		for test in tests {
			let result = containsDuplicate(test.nums)
			let pass = result == test.expected ? "✅" : "❌"

			let inputStr = "[\(test.nums.prefix(10).map(String.init).joined(separator: ","))" + (test.nums.count > 10 ? ", ..." : "") + "]"

			print("| \(pad(inputStr, to: columnWidths.input)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Checks if any number appears more than once in the list.

		- Parameter nums: The list of integers.
		- Returns: True if any integer is duplicated; false otherwise.
	*/
	func containsDuplicate(_ nums: [Int]) -> Bool {
		return nums.count != Set(nums).count
	}
}
