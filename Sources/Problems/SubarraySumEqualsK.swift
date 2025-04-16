/**
	Count the number of continuous subarrays that sum up to a target value k.

	- Parameters:
		- nums: An array of integers (can include negative numbers).
		- k: The target sum for subarrays.
	- Returns: The total count of continuous subarrays whose elements sum to exactly k.
*/

import Foundation

class SubarraySumEqualsK: Problem {

	typealias TestCase = (nums: [Int], k: Int, expected: Int)

	override func performTests() {
		let tests: [TestCase] = [
			// Two subarrays [1,1] and [1,1] sum to 2
			(nums: [1, 1, 1], k: 2, expected: 2),

			// One subarray [3] sums to 3
			(nums: [1, 2, 3], k: 3, expected: 2),

			// Multiple overlapping zero-sum subarrays
			(nums: [0, 0, 0, 0], k: 0, expected: 10),

			// No subarray sums to k
			(nums: [1, 2, 3], k: 7, expected: 0),

			// Negative numbers included
			(nums: [1, -1, 0], k: 0, expected: 3),

			// Single element matches k
			(nums: [5], k: 5, expected: 1),

			// All elements sum up to k
			(nums: [2, 4, 1, 1, 2], k: 10, expected: 1)
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 25, k: 6, expected: 10, actual: 10, pass: 6)

		let header = "| \(pad("Input", to: columnWidths.input)) | \(pad("K", to: columnWidths.k)) | \(pad("Expected", to: columnWidths.expected)) | \(pad("Actual", to: columnWidths.actual)) | \(pad("Pass", to: columnWidths.pass)) |"
		let separator = String(repeating: "-", count: header.count)

		print(header)
		print(separator)

		for test in tests {
			let result = subarraySum(test.nums, test.k)
			let pass = result == test.expected ? "✅" : "❌"
			let inputStr = "\(test.nums)"

			print("| \(pad(inputStr, to: columnWidths.input)) | \(pad(String(test.k), to: columnWidths.k)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	///  Calculate the number of subarrays whose sum equal k
    /// - Parameters:
    ///   - nums:   The numbers in the array
    ///   - k:      The sum in which we are seeking
    /// - Returns:  The number of possible subarrays whose sums equal k
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        
        var prefixSums: [Int: Int] = [0:1]
        var currentSum: Int = 0
        var sumsFound: Int = 0
        
        for num in nums {
            currentSum += num
            sumsFound += prefixSums[currentSum - k, default: 0]
            prefixSums[currentSum, default: 0] += 1
        }
        
		return sumsFound
	}
}
