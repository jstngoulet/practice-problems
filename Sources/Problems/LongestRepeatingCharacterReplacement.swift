import Foundation

/**
	Finds the length of the longest substring containing the same letter after at most `k` character replacements.

	- Parameters:
	  - s: The input string containing only uppercase English letters.
	  - k: The maximum number of character replacements allowed.
	- Returns: The length of the longest substring with repeating characters after up to `k` changes.
*/
class LongestRepeatingCharacterReplacement: Problem {

	typealias TestCase = (input: (String, Int), expected: Int)

	override func performTests() {
		print("Running tests for: \(Self.self)")

		let tests: [TestCase] = [
			(input: ("A", 1), expected: 1),
			(input: ("AAAA", 2), expected: 4),
			(input: ("AABABBA", 1), expected: 4),
			(input: ("ABBB", 2), expected: 4),
			(input: ("ABCD", 0), expected: 1),
			(input: ("ABCDE", 2), expected: 3),
			(input: ("ABAB", 5), expected: 4),
			(input: ("BBBB", 1), expected: 4),
			(input: ("BAAAB", 2), expected: 5),
			(input: ("", 3), expected: 0)
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 26, expected: 10, actual: 10, pass: 6)

		let header: String = "| " + pad("Input (s, k)", to: columnWidths.input)
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
			let (s, k) = test.input
			let result = characterReplacement(s, k)
			let pass = result == test.expected ? "✅" : "❌"
			let inputString = "(\(s), \(k))"
			print("| \(pad(inputString, to: columnWidths.input)) | \(pad(String(test.expected), to: columnWidths.expected)) | \(pad(String(result), to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Calculates the maximum length of a substring with repeating characters after up to `k` replacements.

		- Parameters:
		  - s: The string to process.
		  - k: The maximum number of changes allowed.
		- Returns: The length of the longest uniform substring possible with at most `k` changes.
	*/
	func characterReplacement(_ s: String, _ k: Int) -> Int {
        var charCounts: [Character: Int] = [:]
        var leftIterator:  Int = 0, rightIterator: Int = 0
        var foundMax: Int = 0
        let sArray: [Character] = Array(s)
        
        while rightIterator < s.count {
            let currentChar = sArray[rightIterator]
            charCounts[currentChar, default: 0] += 1
            
            let maxLength: Int = charCounts.values.max() ?? 0
            let windowSize = abs(rightIterator - leftIterator) + 1
            
            if windowSize - maxLength > k && leftIterator < s.count {
                let leftChar = sArray[leftIterator]
                charCounts[leftChar, default: 0] -= 1
                
                if charCounts[leftChar, default: 0] == 0 {
                    charCounts.removeValue(forKey: leftChar)
                }
                
                leftIterator += 1
            } else {
                foundMax = max(windowSize, foundMax)
            }
            
            rightIterator += 1
        }
        
		return foundMax
	}
}
