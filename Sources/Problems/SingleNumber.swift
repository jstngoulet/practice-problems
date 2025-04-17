/**
	Finds the number that appears only once in an array where every other number appears twice.

	- Parameter nums: An array of integers.
	- Returns: The single number that appears exactly once.
*/

import Foundation

class SingleNumber: Problem {

	typealias TestCase = (nums: [Int], expected: Int)

	override func performTests() {
		print("Running tests for: \(Self.self)")

		let tests: [TestCase] = [
			// Single number at the end
			(nums: [2, 2, 1], expected: 1),

			// Single number at the beginning
			(nums: [4, 1, 2, 1, 2], expected: 4),

			// Large identical group
			(nums: [99, 1, 99], expected: 1),

			// All negative values
			(nums: [-1, -1, -3], expected: -3),

			// Single element
			(nums: [42], expected: 42)
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
			let result = singleNumber(test.nums)
			let pass = result == test.expected ? "✅" : "❌"

			let inputStr = "[\(test.nums.prefix(10).map(String.init).joined(separator: ","))" + (test.nums.count > 10 ? ", ..." : "") + "]"

			print("| \(pad(inputStr, to: columnWidths.input)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Finds the single number in the array where every other appears exactly twice.

		- Parameter nums: The array of integers.
		- Returns: The number that appears only once.
	*/
	func singleNumber(_ nums: [Int]) -> Int {        
        /**
        XOR Example: 

        nums = [2, 2, 1]

        Step-by-step XOR:
        0 ^ 2 = 2  
        2 ^ 2 = 0  
        0 ^ 1 = 1 ✅

        */
		return nums.reduce(0, ^)    //  Pass the XOR Operator to compare
	}
}
