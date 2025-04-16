/**
	Finds the length of the longest consecutive elements sequence in an unsorted array.

	- Parameter nums: An array of integers (not necessarily sorted).
	- Returns: The length of the longest consecutive sequence that can be formed.
*/

import Foundation

class LongestConsecutiveSequence: Problem {

	typealias TestCase = (nums: [Int], expected: Int)

	override func performTests() {
		let tests: [TestCase] = [
			// Longest sequence is [1, 2, 3, 4]
			(nums: [100, 4, 200, 1, 3, 2], expected: 4),

			// Already ordered: [0, 1, 2, 3, 4]
			(nums: [0, 1, 2, 3, 4], expected: 5),

			// Empty input
			(nums: [], expected: 0),

			// Single element
			(nums: [5], expected: 1),

			// Longest sequence is [10, 11, 12]
			(nums: [10, 5, 12, 11, 30], expected: 3),

			// Sequence includes negative values: [-2, -1, 0, 1]
			(nums: [0, -1, 1, -2, 5, 6], expected: 4),

			// All values are the same
			(nums: [1, 1, 1], expected: 1)
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 30, expected: 10, actual: 10, pass: 6)

		let header = "| \(pad("Input", to: columnWidths.input)) | \(pad("Expected", to: columnWidths.expected)) | \(pad("Actual", to: columnWidths.actual)) | \(pad("Pass", to: columnWidths.pass)) |"
		let separator = String(repeating: "-", count: header.count)

		print(header)
		print(separator)

		for test in tests {
			let result = longestConsecutive(test.nums)
			let pass = result == test.expected ? "✅" : "❌"
			let inputStr = "\(test.nums)"

			print("| \(pad(inputStr, to: columnWidths.input)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Finds the longest sequence of consecutive integers in an unsorted list.

		- Parameter nums: An array of integers.
		- Returns: The length of the longest consecutive elements sequence.
	*/
	func longestConsecutive(_ nums: [Int]) -> Int {
        
        if nums.isEmpty { return 0 }
        
        //  Add all items to a set, for O(1) lookup
        let itemSet: Set<Int> = Set(nums)   //  This is O(N)
        var currentMax: Int = 0
        
        //  Now, we need to iterate through each number, 
        //  and while we do this, keep track to see if num + i
        //  is within the set, keeping track of the current
        //  count of i (max) while we iterate though each element        
        for item in nums {
            //  Only start a sequence if `item-1` is not in the set
            //  This is because we only care for the start of the sequence
            if !itemSet.contains(item - 1) {
                var currentNumber = item
                var currentStreak: Int = 1  //  Start at 1
                
                //  Now, check the streak
                while itemSet.contains(currentNumber + 1) {
                    currentStreak += 1
                    currentNumber += 1
                }
                
                //  Kepp track of the max
                currentMax = max(currentMax, currentStreak)
            }
        }
        
		return currentMax
	}
}
