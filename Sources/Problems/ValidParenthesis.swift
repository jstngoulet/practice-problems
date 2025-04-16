/**
	Checks whether a string containing only brackets is valid.

	- Parameter s: A string containing '(', ')', '{', '}', '[' and ']'.
	- Returns: True if the string is valid, false otherwise.
*/

import Foundation

class ValidParentheses: Problem {

	typealias TestCase = (input: String, expected: Bool)

	override func performTests() {
		let tests: [TestCase] = [
			// Simple balanced parentheses
			(input: "()", expected: true),

			// Multiple types of brackets
			(input: "()[]{}", expected: true),

			// Mismatched brackets
			(input: "(]", expected: false),

			// Correct types but wrong nesting order
			(input: "([)]", expected: false),

			// Properly nested
			(input: "{[]}", expected: true),

			// Empty string should be valid
			(input: "", expected: true),

			// Opening without closing
			(input: "(((", expected: false),

			// Closing without opening
			(input: ")))", expected: false),

			// Complex valid pattern
			(input: "([])[]({})", expected: true)
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
			let result = isValid(test.input)
			let pass = result == test.expected ? "✅" : "❌"
			print("| \(pad(test.input, to: columnWidths.input)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Determines whether the given string has valid parentheses.

		- Parameter s: The input string containing only '(', ')', '{', '}', '[' and ']'.
		- Returns: A boolean indicating whether the string is valid.
	*/
	func isValid(_ s: String) -> Bool {
        
        //  Create a dict of objects with key of opening bracket 
        //  and value of closing bracket. 
        //  This way, we can iterate through the string and add all the matching
        //  sets.
        let mappingDict: [Character: Character] = [
            "(": ")",
            "{": "}",
            "[": "]"
        ]
        /**
        - Create a stack
        - For each char in the string:
            - If it's an opening bracket, push it onto the stack
            - If it's a closing bracket:
                - If stack is empty → return false
                - Pop the top element, check if it matches the closing bracket
        - At the end, stack must be empty
        */
        var stack: [Character] = []

        for char in s {
            if mappingDict.keys.contains(char) {
                // it's an opening bracket
                stack.append(char)
                continue
            }
            
            // it's a closing bracket
            if stack.isEmpty || mappingDict[stack.removeLast()] != char {
                return false
            }
        }

        return stack.isEmpty
	}
}
