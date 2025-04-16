/**
	Continuously adds the digits of a number until a single-digit result is obtained.

	- Parameter num: A non-negative integer.
	- Returns: A single-digit integer that is the result of repeatedly summing the digits.
*/

import Foundation

class AddDigitsUntilOne: Problem {

	typealias TestCase = (input: Int, expected: Int)

	override func performTests() {
		print("Running tests for: \(Self.self)")

		let tests: [TestCase] = [
			// 3 + 8 = 11 → 1 + 1 = 2
			(input: 38, expected: 2),

			// Already a single digit
			(input: 0, expected: 0),

			// 9 → already single-digit
			(input: 9, expected: 9),

			// 2 + 7 = 9
			(input: 27, expected: 9),

			// 1 + 2 + 9 = 12 → 1 + 2 = 3
			(input: 129, expected: 3),

			// 999 → 9 + 9 + 9 = 27 → 2 + 7 = 9
			(input: 999, expected: 9),

			// 10 → 1 + 0 = 1
			(input: 10, expected: 1)
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 10, expected: 10, actual: 10, pass: 6)

		let header = "| \(pad("Input", to: columnWidths.input)) | \(pad("Expected", to: columnWidths.expected)) | \(pad("Actual", to: columnWidths.actual)) | \(pad("Pass", to: columnWidths.pass)) |"
		let separator = String(repeating: "-", count: header.count)

		print(header)
		print(separator)

		for test in tests {
			let result = addDigits(test.input)
			let pass = result == test.expected ? "✅" : "❌"
			print("| \(pad(String(test.input), to: columnWidths.input)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Repeatedly adds the digits of the number until a single-digit result remains.

		- Parameter num: The number to reduce.
		- Returns: The resulting single-digit integer.
	*/
	func addDigits(_ num: Int) -> Int {
        
        /**
        //  First, Convert to a string, 
        //  As the string will be an array of all the
        //  numbers in the number. 
        //  We will keep adding until the array only has one digit
        
        For example, the number 38 would turn into: 
        1. ["3", "8"]
        2. 3 + 8 = 11
        3. ["1", "1"]
        4. 1 + 1 = 2
        5. ["2"]    //Return here
        */
        let numberAsCharArray: [Character] = Array(String(num))
        
        if numberAsCharArray.count == 1, 
            let numberAsDigit = Int(String(numberAsCharArray[0])) {
            return numberAsDigit
        }
        
        //  If the count is more than 1, then we want to sum up each one
        let currentSum = numberAsCharArray.reduce(0) { partialResult, num in
            if let number = Int(String(num)) {
                return partialResult + number
            } else { return partialResult }
        }
        
        //  Now that we have the sum, recursivlly call function
		return addDigits(currentSum)
        
        /**
        For an O(1) solution, we could use the num % 9 solution, which is: 
        ```swift
        return num == 0 ? 0 : 1 + (num - 1) % 9
        ```
        🔄 Why Does This Work?
        Because:

        • The digital root of num is congruent to num mod 9
        • Except for numbers that are multiples of 9, where the result should be 9 (not 0)
        
        The formula 1 + (num - 1) % 9 elegantly avoids the 0 problem by shifting the range.
        */
	}
}
