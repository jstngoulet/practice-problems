/**
	Given daily temperatures, calculates the number of days to wait for a warmer temperature.

	- Parameter temps: An array of daily temperatures.
	- Returns: An array where each value represents the number of days to wait for a warmer day.
*/

import Foundation

class DailyTemperatures: Problem {

	typealias TestCase = (temps: [Int], expected: [Int])

	override func performTests() {
		print("Running tests for: \(Self.self)")

		let tests: [TestCase] = [
			// General case
			(temps: [73, 74, 75, 71, 69, 72, 76, 73], expected: [1, 1, 4, 2, 1, 1, 0, 0]),

			// No warmer days
			(temps: [90, 80, 70], expected: [0, 0, 0]),

			// Only one future warmer day
			(temps: [70, 80, 60], expected: [1, 0, 0]),

			// Same temperature every day
			(temps: [70, 70, 70, 70], expected: [0, 0, 0, 0]),

			// Monotonically increasing
			(temps: [60, 65, 70, 75], expected: [1, 1, 1, 0]),

			// Single entry
			(temps: [70], expected: [0]),

			// Empty input
			(temps: [], expected: [])
		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 40, expected: 25, actual: 25, pass: 6)

		let header = "| \(pad("Input", to: columnWidths.input)) | \(pad("Expected", to: columnWidths.expected)) | \(pad("Actual", to: columnWidths.actual)) | \(pad("Pass", to: columnWidths.pass)) |"
		let separator = String(repeating: "-", count: header.count)

		print(header)
		print(separator)

		for test in tests {
			let result = dailyTemperatures(test.temps)
			let pass = result == test.expected ? "✅" : "❌"

			let inputStr = "[\(test.temps.prefix(10).map(String.init).joined(separator: ","))" + (test.temps.count > 10 ? ", ..." : "") + "]"
			let expectedStr = "[\(test.expected.map(String.init).joined(separator: ", "))]"
			let resultStr = "[\(result.map(String.init).joined(separator: ", "))]"

			print("| \(pad(inputStr, to: columnWidths.input)) | \(pad(expectedStr, to: columnWidths.expected)) | \(pad(resultStr, to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Calculates how many days it will take to reach a warmer temperature.

		- Parameter temps: An array of temperatures.
		- Returns: An array of wait times.
	*/
	func dailyTemperatures(_ temps: [Int]) -> [Int] {
        var daysUntilTemps: [Int] = []

        for (i, temp) in temps.enumerated() {
            let futureTemps = Array(temps[(i+1)...])    // Start *after* current
            if let warmerIndex = futureTemps.firstIndex(where: { $0 > temp }) {
                daysUntilTemps.append(warmerIndex + 1)          // +1 to offset for skipped element
            } else {
                daysUntilTemps.append(0)
            }
        }
        
        /** Stack based Approach
        var stack: [Int] = []
        var daysUntilTemps: [Int] = Array(repeating: 0, count: temps.count)

        for iter in 0..<temps.count {
		    // Check all unresolved colder days
            while let last = stack.last, temps[iter] > temps[last] {
                stack.removeLast()
                daysUntilTemps[last] = iter - last
            }
            stack.append(iter)
        }
        */

        return daysUntilTemps
	}
}
