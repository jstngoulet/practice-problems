/**
	Returns all elements of a 2D matrix in spiral order.
*/

import Foundation

class SpiralOrderMatrix: Problem {

	typealias TestCase = (matrix: [[Int]], expected: [Int])

	override func performTests() {
		print("Running tests for: \(Self.self)")

		let tests: [TestCase] = [
			// 3x3 matrix, spiral order wraps inward
			(matrix: [
				[1, 2, 3],
				[4, 5, 6],
				[7, 8, 9]
			], expected: [1, 2, 3, 6, 9, 8, 7, 4, 5]),

			// 2x2 square matrix
			(matrix: [
				[1, 2],
				[3, 4]
			], expected: [1, 2, 4, 3]),

			// Single row, should traverse left to right
			(matrix: [
				[1, 2, 3, 4]
			], expected: [1, 2, 3, 4]),

			// Single column, top to bottom
			(matrix: [
				[1],
				[2],
				[3],
				[4]
			], expected: [1, 2, 3, 4]),

			// Empty matrix
			(matrix: [], expected: [])

		]

		func pad(_ string: String, to length: Int) -> String {
			if string.count >= length { return String(string.prefix(length)) }
			return string + String(repeating: " ", count: length - string.count)
		}

		let columnWidths = (input: 35, expected: 30, actual: 30, pass: 6)

		let header = "| \(pad("Input Matrix", to: columnWidths.input)) | \(pad("Expected", to: columnWidths.expected)) | \(pad("Actual", to: columnWidths.actual)) | \(pad("Pass", to: columnWidths.pass))  |"
		let separator = String(repeating: "-", count: header.count)

		print(header)
		print(separator)

		for test in tests {
			let result = spiralOrder(test.matrix)
			let pass = result == test.expected ? "✅" : "❌"

			let inputStr = "[" + test.matrix.map { "[" + $0.map(String.init).joined(separator: ",") + "]" }.joined(separator: ", ") + "]"
			let expectedStr = "[\(test.expected.map(String.init).joined(separator: ", "))]"
			let resultStr = "[\(result.map(String.init).joined(separator: ", "))]"

			print("| \(pad(inputStr, to: columnWidths.input)) | \(pad(expectedStr, to: columnWidths.expected)) | \(pad(resultStr, to: columnWidths.actual)) | \(pad(pass, to: columnWidths.pass)) |")
		}
	}

	/**
		Traverses a matrix in spiral order.

		- Parameter matrix: The 2D matrix to traverse.
		- Returns: A flattened array in spiral order.
	*/
	func spiralOrder(_ matrix: [[Int]]) -> [Int] {
		// Return empty array if input is empty
		if matrix.isEmpty { return [] }

		let n = matrix.count
		let m = matrix[0].count

		// This array will hold the spiral traversal result
		var orderedArray: [Int] = []

		// Enum to track direction of movement
		enum Direction {
			case right, down, left, up

			// Provides the next direction in clockwise order
			var next: Direction {
				switch self {
					case .right: return .down
					case .down: return .left
					case .left: return .up
					case .up: return .right
				}
			}
		}

		// Boundaries for traversal
		var minRow = 0, maxRow = n - 1
		var minColumn = 0, maxColumn = m - 1

		// Track current position in matrix
		var currentRow = 0, currentColumn = 0

		// Initial direction is to move right
		var currentDirection: Direction = .right

		// Continue until boundaries collapse inward
		while minRow <= maxRow && minColumn <= maxColumn {
			switch currentDirection {

				case .right:
					// Traverse from left to right
					while currentColumn <= maxColumn {
						orderedArray.append(matrix[currentRow][currentColumn])
						currentColumn += 1
					}
					// Revert overshoot and update boundaries
					currentColumn -= 1
					currentRow += 1
					minRow += 1

				case .down:
					// Traverse from top to bottom
					while currentRow <= maxRow {
						orderedArray.append(matrix[currentRow][currentColumn])
						currentRow += 1
					}
					currentRow -= 1
					currentColumn -= 1
					maxColumn -= 1

				case .left:
					// Traverse from right to left
					while currentColumn >= minColumn {
						orderedArray.append(matrix[currentRow][currentColumn])
						currentColumn -= 1
					}
					currentColumn += 1
					currentRow -= 1
					maxRow -= 1

				case .up:
					// Traverse from bottom to top
					while currentRow >= minRow {
						orderedArray.append(matrix[currentRow][currentColumn])
						currentRow -= 1
					}
					currentRow += 1
					currentColumn += 1
					minColumn += 1
			}

			// Advance to the next direction
			currentDirection = currentDirection.next
		}

		return orderedArray
	}
}
