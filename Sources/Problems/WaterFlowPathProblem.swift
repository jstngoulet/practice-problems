/**
 Represents a coding problem that checks whether water can flow from the top-left
 to the bottom-right of a given elevation grid. Water can only flow to adjacent
 cells (up, down, left, right) of equal or lower elevation. This class includes
 a method to solve the problem and a test runner to validate correctness.

 Use this class as part of a practice problem suite.
 */
final class WaterFlowPathProblem: Problem {
    /**
     Determines if water can flow from the top-left cell to the bottom-right
     cell in a grid of elevations. Water can only move to adjacent cells (up, down,
     left, right) that have equal or lower elevation.

     - Parameter grid: A 2D array of integers representing elevation at each point.
     - Returns: `true` if water can reach the bottom-right cell, otherwise `false`.
     */
    func canWaterFlow(_ grid: [[Int]]) -> Bool {
        if grid.isEmpty { return false }

        typealias Coordinate = (row: Int, column: Int)
        let maxRows = grid.count
        let maxColumns = grid[0].count

        var visited = Array(repeating: Array(repeating: false, count: maxColumns), count: maxRows)

        func dfs(coordinate: Coordinate, previousValue: Int) -> Bool {
            let (row, col) = coordinate

            // Boundary check
            if row < 0 || row >= maxRows || col < 0 || col >= maxColumns {
                return false
            }

            // Elevation rule check
            if grid[row][col] > previousValue {
                return false
            }

            // Visited check
            if visited[row][col] {
                return false
            }

            // Reached target
            if row == maxRows - 1 && col == maxColumns - 1 {
                return true
            }

            // Mark as visited
            visited[row][col] = true

            let current = grid[row][col]

            return dfs(coordinate: (row + 1, col), previousValue: current)
                || dfs(coordinate: (row - 1, col), previousValue: current)
                || dfs(coordinate: (row, col + 1), previousValue: current)
                || dfs(coordinate: (row, col - 1), previousValue: current)
        }

        return dfs(coordinate: (0, 0), previousValue: grid[0][0])
    }


    override func performTests() {
        print("Testing WaterFlowPathProblem")

        struct TestCase {
            let grid: [[Int]]
            let expected: Bool
        }

        let tests: [TestCase] = [
            // ✅ Path downhill to destination
            TestCase(grid: [
                [5, 4, 3],
                [6, 3, 2],
                [7, 6, 1]
            ], expected: true),

            // ❌ Only uphill paths available
            TestCase(grid: [
                [1, 2, 3],
                [2, 3, 4],
                [3, 4, 5]
            ], expected: false),

            // ✅ All same height
            TestCase(grid: [
                [2, 2],
                [2, 2]
            ], expected: true),

            // ❌ No path due to surrounding higher elevations
            TestCase(grid: [
                [5, 6],
                [6, 5]
            ], expected: false),

            // ✅ Z-shaped downhill path
            TestCase(grid: [
                [8, 7, 6],
                [9, 7, 5],
                [9, 8, 4]
            ], expected: true),

            // ✅ Right and Down-shaped, Blocked in Middle
            TestCase(grid: [
                [5, 4, 3],
                [6, 9, 2],
                [7, 6, 1]
            ], expected: true),

            // ✅ Single cell
            TestCase(grid: [
                [1]
            ], expected: true),

            // ❌ Two cells uphill
            TestCase(grid: [
                [1, 2]
            ], expected: false),

            // ✅ Two cells flat
            TestCase(grid: [
                [3, 3]
            ], expected: true),

            // ✅ Edge-only path
            TestCase(grid: [
                [9, 9, 9],
                [8, 1, 8],
                [7, 7, 7]
            ], expected: true)
        ]

        let header = "| Test # | Input Grid                          | Expected | Actual   | Pass |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (index, test) in tests.enumerated() {
            let inputStr = test.grid.map { $0.description }.joined(separator: " ")
            let expectedStr = String(test.expected)
            let actualStr = String(canWaterFlow(test.grid))
            let passStr = test.expected == canWaterFlow(test.grid) ? "✅" : "❌"

            let row = "| \(String(index + 1).padding(toLength: 6, withPad: " ", startingAt: 0))" +
                      "| \(inputStr.padding(toLength: 35, withPad: " ", startingAt: 0))" +
                      "| \(expectedStr.padding(toLength: 9, withPad: " ", startingAt: 0))" +
                      "| \(actualStr.padding(toLength: 9, withPad: " ", startingAt: 0))" +
                      "| \(passStr.padding(toLength: 4, withPad: " ", startingAt: 0)) |"
            print(row)
        }
    }
}
