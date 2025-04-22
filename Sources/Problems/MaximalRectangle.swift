import Foundation

class MaximalRectangle: Problem {
    /**
     Finds the area of the largest rectangle consisting only of 1's in a given binary matrix.
    
     - Parameter matrix: A 2D array of Ints (0s and 1s) representing the binary matrix.
     - Returns: The area of the largest rectangle containing only 1's.
     */
    func maximalRectangle(_ matrix: [[Int]]) -> Int {

        /**
        Sample walkthrough:

        Matrix:
        1 1 0 1 1
        0 0 1 1 1
        0 1 1 1 0
        1 1 0 1 0
        0 1 0 1 1

        Strategy:
        Starting at every cell containing a `1`, treat it as the top-left corner of a possible rectangle.

        From this top-left cell, attempt to expand **downward row by row**.
        For each row during the downward traversal:
            - Count how many consecutive `1`s exist to the right starting from the current column.
            - Track the **minimum width** encountered so far — this defines the width of the current rectangle.
            - Multiply that width by the current height (i.e. how many rows have been successfully traversed).
            - Keep track of the maximum area found during this process.

        Example: Starting at (0, 0)
        Row 0: width = 2 (1 1) → area = 2
        Row 1: matrix[1][0] = 0 → break
        Max area from (0,0) = 2

        Example: Starting at (1, 2)
        Row 1: width = 3 (1 1 1) → area = 3
        Row 2: width = 3 (1 1 1) → area = 6
        Row 3: width = 1 (0 1 0) → width shrinks to 1 → area = 3
        Stop at row 4 (matrix[4][2] = 0)
        Max area from (1,2) = 6

        Patterns:
        - Each rectangle starts from a `1`, and grows downward.
        - Width is dynamically adjusted as the smallest row width encountered.
        - At every step we calculate area = width × height and compare to max.

        This approach ensures that:
        - All rectangles are fully filled with 1s.
        - Each possible rectangle is considered.
        - We avoid unnecessary rechecking of invalid sub-areas.
    */

        if matrix.isEmpty { return 0 }
        typealias Coordinate = (column: Int, row: Int)

        let rows = matrix.count
        let columns = matrix[0].count
        var coordinateMap: [Coordinate] = []  //  Map of coordinates where cell is 1
        var currentMax: Int = 0

        func areaFrom(topLeft: Coordinate, bottomRight: Coordinate) -> Int {
            let width = abs(bottomRight.column - topLeft.column) + 1
            let height = abs(bottomRight.row - topLeft.row) + 1
            print("Width: \(width), height: \(height)")
            return width * height
        }

        func isValid(coordinate: Coordinate) -> Bool {
            coordinate.row < rows
                && coordinate.column < columns
                && matrix[coordinate.row][coordinate.column] == 1
        }

        //  Create a coordinate map of all 1s and the coordinates
        for row in 0..<rows {
            for column in 0..<columns {
                if matrix[row][column] == 1 { coordinateMap.append((column, row)) }
            }
        }

        //  No ones found
        if coordinateMap.isEmpty { return 0 }
        
        for (startColumn, startRow) in coordinateMap {
            var width = Int.max

            for row in startRow..<rows {
                if matrix[row][startColumn] == 0 { break }
                var currentRowWidth = 0

                while startColumn + currentRowWidth < columns
                    && matrix[row][startColumn + currentRowWidth] == 1
                {
                    currentRowWidth += 1
                }

                width = min(width, currentRowWidth)
                let height = row - startRow + 1
                currentMax = max(currentMax, width * height)
            }
        }


        return currentMax
    }

    override func performTests() {
        print("Running tests for: \(type(of: self))\n")

        struct TestCase {
            let matrix: [[Int]]
            let expected: Int
        }

        let tests: [TestCase] = [
            // 2x2 square of 1s
            TestCase(matrix: [[1, 1], [1, 1]], expected: 4),

            // Vertical 3x1 rectangle
            TestCase(matrix: [[1], [1], [1]], expected: 3),

            // Horizontal 1x3 rectangle
            TestCase(matrix: [[1, 1, 1]], expected: 3),

            // Mixed, largest 2x2 block
            TestCase(
                matrix: [
                    [1, 0, 0, 0],
                    [1, 0, 1, 1],
                    [1, 0, 1, 1],
                    [0, 1, 0, 0],
                ], expected: 4),

            // All zeros
            TestCase(
                matrix: [
                    [0, 0],
                    [0, 0],
                ], expected: 0),

            // Single 1
            TestCase(
                matrix: [
                    [0, 0],
                    [0, 1],
                ], expected: 1),

            // Long mixed row with consecutive 1s
            TestCase(
                matrix: [
                    [1, 0, 1, 1, 1]
                ], expected: 3),

            // Sparse diagonal 1s
            TestCase(
                matrix: [
                    [1, 0, 0],
                    [0, 1, 0],
                    [0, 0, 1],
                ], expected: 1),

            // Full matrix of 1s
            TestCase(
                matrix: [
                    [1, 1, 1],
                    [1, 1, 1],
                ], expected: 6),

            // Inner rectangle of 1s
            TestCase(
                matrix: [
                    [0, 1, 1, 0],
                    [1, 1, 1, 1],
                    [0, 1, 1, 0],
                ], expected: 6),
        ]

        let header =
            "| Test # | Input Matrix                                 | Expected | Actual | Pass |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (i, test) in tests.enumerated() {
            let result = maximalRectangle(test.matrix)
            let pass = result == test.expected ? "✅" : "❌"
            let paddedInput = test.matrix.description.padding(
                toLength: 45, withPad: " ", startingAt: 0)
            let paddedExpected = "\(test.expected)".padding(
                toLength: 8, withPad: " ", startingAt: 0)
            let paddedResult = "\(result)".padding(toLength: 6, withPad: " ", startingAt: 0)
            print(
                "| \(String(format: "%-6d", i + 1)) | \(paddedInput) | \(paddedExpected) | \(paddedResult) | \(pass) |"
            )
        }
    }
}
