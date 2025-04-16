/**
	Return the index of the first non-repeating character in a string.

	- Parameter s: A string consisting of lowercase English letters.
	- Returns: The index of the first non-repeating character. If none exists, returns -1.
*/

import Foundation

class FirstUniqueCharacter: Problem {

	typealias TestCase = (input: String, expected: Int)

	override func performTests() {
		let tests: [TestCase] = [
			// "l" appears once at index 0
			(input: "leetcode", expected: 0),

			// "v" is the first character to appear only once (index 2)
			(input: "loveleetcode", expected: 2),

			// All characters are repeated
			(input: "aabb", expected: -1),

			// Empty string should return -1
			(input: "", expected: -1),

			// "z" appears only once at index 2
			(input: "xxyz", expected: 2),

			// Single character string is trivially unique
			(input: "z", expected: 0),

			// "b" is the first character that appears only once (index 3)
			(input: "aaabcccdeeef", expected: 3),

			// All characters repeated
			(input: "aabbcc", expected: -1)
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 20, expected: 10, actual: 10, pass: 6)

		let header = "| \(pad("Input", to: columnWidths.input)) | \(pad("Expected", to: columnWidths.expected)) | \(pad("Actual", to: columnWidths.actual)) | \(pad("Pass", to: columnWidths.pass)) |"
		let separator = String(repeating: "-", count: header.count)

		print(header)
		print(separator)

		for test in tests {
			let result = firstUniqChar(test.input)
			let pass = result == test.expected ? "✅" : "❌"

			print("| \(pad(test.input, to: columnWidths.input)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	func firstUniqChar(_ s: String) -> Int {
		// Dictionary to store all indices for each character
		var characterAtIndices: [Character: [Int]] = [:]
		
		for (iter, char) in s.enumerated() {
			characterAtIndices[char, default: []].append(iter)
		}
		
		// Return the first character whose index list has only one entry
		for (iter, char) in s.enumerated() {
			if characterAtIndices[char]?.count == 1 {
				return iter
			}
		}
		
		return -1
	}
}
