//
//  TraverseGridForWord.swift
//  
//
//  Created by Justin Goulet on 3/31/25.
//

import Foundation

class TraverseGridForWord: NSObject {
    
    /**
     Given a 2D matrix of characters and a target word, write a function that returns whether
     the word can be found in the matrix by going left-to-right, or up-to-down.
     
     For Example, given teh following matrix:
     ```swift
     
     ```
     and the target word "FOAM", you should return true, since it"s the leftmost column.
     Similarly, given the target word "MASS", you should return true, since it"s the last row.
     */
    
    func performTests() {
        typealias TestCase = (grid: [[Character]], word: String, expected: Bool)
        
        let tests: [TestCase] = [
            (grid: [
                ["F", "A", "C", "I"],
                ["O", "B", "Q", "P"],
                ["A", "N", "O", "B"],
                ["M", "A", "S", "S"]
            ], word: "FOAM", expected: true),   // Vertical match (first column)
            
            (grid: [
                ["F", "A", "C", "I"],
                ["O", "B", "Q", "P"],
                ["A", "N", "O", "B"],
                ["M", "A", "S", "S"]
            ], word: "MASS", expected: true),   // Horizontal match (last row)
            
            (grid: [
                ["F", "A", "C", "I"],
                ["O", "B", "Q", "P"],
                ["A", "N", "O", "B"],
                ["M", "A", "S", "S"]
            ], word: "FACI", expected: true),   // Horizontal match (first row)
            
            (grid: [
                ["F", "A", "C", "I"],
                ["O", "B", "Q", "P"],
                ["A", "N", "O", "B"],
                ["M", "A", "S", "S"]
            ], word: "BQP", expected: true),    // Horizontal match (second row)
            
            (grid: [
                ["F", "A", "C", "I"],
                ["O", "B", "Q", "P"],
                ["A", "N", "O", "B"],
                ["M", "A", "S", "S"]
            ], word: "BAN", expected: false),   // Not a straight line
            
            (grid: [
                ["F", "A", "C", "I"],
                ["O", "B", "Q", "P"],
                ["A", "N", "O", "B"],
                ["M", "A", "S", "S"]
            ], word: "FOB", expected: true),   //  Staircase
            
            (grid: [
                ["F", "A", "C", "I"],
                ["O", "B", "Q", "P"],
                ["A", "N", "O", "B"],
                ["M", "A", "S", "S"]
            ], word: "PICA", expected: true),   //  Staircase
            
            (grid: [
                ["H", "E", "L", "L", "O"]
            ], word: "HELLO", expected: true),  // Single row match
            
            (grid: [
                ["H"],
                ["E"],
                ["L"],
                ["L"],
                ["O"]
            ], word: "HELLO", expected: true),  // Single column match
            
            (grid: [
                ["A"]
            ], word: "A", expected: true),      // Single character match
            
            (grid: [
                ["A"]
            ], word: "B", expected: false),     // Single character mismatch
            
            // Large matrix test
            (grid: Array(repeating: Array(repeating: "A", count: 1000), count: 1000), word: "AAAAA", expected: true),
            (grid: Array(repeating: Array(repeating: "A", count: 1000), count: 1000), word: "BBBBB", expected: false)
        ]
        
        //        for (iter, test) in tests.enumerated() {
        //            let result = isWord(test.word, in: test.grid)
        //            let isPassed = result == test.expected
        //            print("Test \(iter + 1): \tPassed: \(isPassed ? "✅" : "❌")")
        //        }
        
        // Helper function to pad strings for formatting.
        func pad(_ string: String, width: Int) -> String {
            return string.padding(toLength: width, withPad: " ", startingAt: 0)
        }
        
        // Helper function to format a matrix into a string.
        func formatMatrix(_ matrix: [[Character]]) -> String {
            return matrix.map { row in row.map { String($0) }.joined(separator: " ") }.joined(separator: "\n")
        }
        
        // Define column widths.
        let col1Width = 6, col2Width = 10, col3Width = 10, col4Width = 10, col5Width = 6
        
        // Print table header.
        print("+" + String(repeating: "-", count: 5) +
              "+" + String(repeating: "-", count: 12) +
              "+" + String(repeating: "-", count: 12) +
              "+" + String(repeating: "-", count: 8) + "+")
        print("| #   | Word       | Expected   | Got    |")
        print("+" + String(repeating: "-", count: 5) +
              "+" + String(repeating: "-", count: 12) +
              "+" + String(repeating: "-", count: 12) +
              "+" + String(repeating: "-", count: 8) + "+")
        
        // Run test cases and print each result.
        for (index, test) in tests.enumerated() {
            let result = isWord(test.word, in: test.grid)
            
            let pass = result == test.expected ? "✅" : "❌"
            print("| \(pad(String(index + 1), width: 3)) | " +
                  pad(test.word, width: 10) + " | " +
                  pad(String(test.expected), width: 10) + " | " +
                  pad(String(result), width: 6) + " |")
        }
        
        // Print footer line.
        print("+" + String(repeating: "-", count: 5) +
              "+" + String(repeating: "-", count: 12) +
              "+" + String(repeating: "-", count: 12) +
              "+" + String(repeating: "-", count: 8) + "+")
        
    }
    
    /**/
    func isWord(_ word: String, in grid: [[Character]]) -> Bool {
        guard !grid.isEmpty, !word.isEmpty else { return false }
        
        let rows = grid.count
        let cols = grid[0].count
        let wordArray = Array(word)
        
        // DFS that explores adjacent cells in all 4 directions.
        func dfs(_ x: Int, _ y: Int, _ index: Int, _ visited: inout [[Bool]]) -> Bool {
            // If we've matched all letters, return true.
            if index == wordArray.count { return true }
            
            // Check bounds.
            if x < 0 || x >= rows || y < 0 || y >= cols { return false }
            // Skip already visited cells.
            if visited[x][y] { return false }
            // Check if the current cell matches the current letter.
            if grid[x][y] != wordArray[index] { return false }
            
            // Mark this cell as visited.
            visited[x][y] = true
            
            // Explore all 4 adjacent directions.
            let found = dfs(x + 1, y, index + 1, &visited) ||
            dfs(x - 1, y, index + 1, &visited) ||
            dfs(x, y + 1, index + 1, &visited) ||
            dfs(x, y - 1, index + 1, &visited)
            
            // Unmark this cell for backtracking.
            visited[x][y] = false
            
            return found
        }
        
        // Initialize a visited matrix.
        var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
        
        // Try every cell as a starting point.
        for i in 0..<rows {
            for j in 0..<cols {
                if grid[i][j] == wordArray[0] {
                    if dfs(i, j, 0, &visited) {
                        return true
                    }
                }
            }
        }
        
        return false
    }
}
