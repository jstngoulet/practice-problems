/**
Sure! Here's a clear and challenging prompt with enough detail to engage a programmer, while setting precise expectations:

---

### 🧩 Crossword Grid Validator

**Difficulty:** 🟨 Intermediate  
**Topic:** Matrix Validation, Graph Traversal, Symmetry Detection  

#### Problem Statement

A standard **American-style crossword puzzle** uses an `N x N` grid consisting of black (`#`) and white (`.`) squares. These puzzles follow strict formatting rules to ensure fairness and readability. Your task is to write a program that **validates** whether a given grid qualifies as a proper crossword layout based on the following rules:

1. **Word Validity**  
   - Every white square (`.`) must be part of **at least one valid "across" word** and **one valid "down" word**.  
   - A valid word is a contiguous sequence of **3 or more white squares** in a row (either horizontally or vertically).

2. **Connectivity**  
   - All white squares must be **connected**, meaning it must be possible to reach any white square from any other by moving **up, down, left, or right** (no diagonals).

3. **Rotational Symmetry**  
   - The grid must be **180-degree rotationally symmetric**. That is, the cell at position `(i, j)` must match the cell at `(N-1-i, N-1-j)`.

---

#### Input

- An integer `N` (3 ≤ N ≤ 50), the size of the grid.
- Followed by `N` lines, each containing a string of `N` characters (`.` or `#`), representing the crossword grid.

---

#### Output

- Print `"Valid"` if the grid satisfies **all** the crossword rules above.
- Otherwise, print `"Invalid"`.

---

#### Example Input
```
5
.#..#
.#..#
#####
#..#.
#..#.
```

#### Example Output
```
Valid
```

---

#### Additional Notes

- Words can overlap and share letters (like a typical crossword).
- You may assume input is always well-formed and only contains valid characters.

*/

import Foundation

class DetermineIfCrosswordGrid: Problem {
    
    override func performTests() {
        struct TestCase {
            let gridSize: Int
            let input: [String]
            let expected: Bool
        }
        let testCases: [TestCase] = [
            // ✘ Only 2-letter "across"/"down" segments around the center
            TestCase(gridSize: 5, input: [
                ".#..#",
                ".#..#",
                "#####",
                "#..#.",
                "#..#."
            ], expected: false), 

            // ✘ Valid symmetry and connectivity, but no 3-letter words
            TestCase(gridSize: 5, input: [
                ".###.",
                ".#.#.",
                "#####",
                ".#.#.",
                ".###."
            ], expected: false), 

            // ✔ Horizontal and vertical 3-letter words centered
            TestCase(gridSize: 5, input: [
                "#####",
                "#...#",
                "#...#",
                "#...#",
                "#####"
            ], expected: true), 

             // ✘ Symmetry fails (not mirrored)
            TestCase(gridSize: 5, input: [
                "#...#",
                "#...#",
                "#...#",
                "#...#",
                "#...#"
            ], expected: false),

            // ✔ Diagonal wall, still forms valid 3-letter across/down segments
            TestCase(gridSize: 5, input: [
                "#####",
                "#...#",
                "#.#.#",
                "#...#",
                "#####"
            ], expected: true), 

            // ✔ Big grid, well structured, symmetry + word rules obeyed
            TestCase(gridSize: 7, input: [
                "#######",
                "###.###",
                "##...##",
                "#..#..#",
                "##...##",
                "###.###",
                "#######"
            ], expected: true), 

            // ✘ Vertical 3-letter word is fine, but others are not valid
            TestCase(gridSize: 5, input: [
                ".....",
                "..#..",
                "..#..",
                "..#..",
                "....."
            ], expected: false) 
        ]

        for (index, testCase) in testCases.enumerated() {
            // Call your validation function here with testCase.input
            // Compare result with testCase.expected and print pass/fail
            let result = isValidGrid(size: testCase.gridSize, grid: testCase.input)
            let isPassed = result == testCase.expected
            print("Test \(index + 1): \t\(isPassed ? "✅" : "❌")\t E: \(testCase.expected)\tR: \(result)")
        }
    }
    
    
    func isValidGrid(size: Int, grid: [String]) -> Bool {
        guard grid.count == size else { return false }
        
        enum WordDirection: String, Hashable {
            case horizontal, vertical
        }
        
        typealias WordOrigin = (x: Int, y: Int, direction: WordDirection, length: Int)
        
        for gridLine in grid {
            if gridLine.count != size {
                return false
            }
        }
        
        //  Create the grid in a usable format
        var newGrid: [[Character]] = Array(repeating: Array(repeating: "-", count: size), count: size)
        
        for row in 0..<size {
            for (column, letter) in grid[row].enumerated() {
                newGrid[row][column] = letter
            }
        }
        
        //  Determine if the grid is symetric
        //  The grid must be 180-degree symmetric: for any cell at position (i, j), 
        //  its mirrored cell at (N - 1 - i, N - 1 - j) must be the same (. or #).
        func isBoardSemetric() -> Bool {
            for row in 0..<size {
                for column in 0..<size {
                    let current = newGrid[row][column]
                    let mirrored = newGrid[size - 1 - row][size - 1 - column]
                    if current != mirrored {
                        return false
                    }
                }
            }
            return true
        }
        
        //  We now have the valid grid
        //  In order to achive this, we need to traverse through the board
        //  and for every white space, determine the length of it horizontally 
        //  and vertically. The min of the white space length is 3, 
        //  While the max is the size of the grid.
        
        //  For every space, determine the count of the word. 
        //  If a word is horizontal, we should only count the word if there is a black 
        //  to the left 
        //  If a word is vertical, we should only count it if there is a black space
        //  directly above it
        func spaceIsInBounds(row: Int, column: Int) -> Bool {
            (row >= 0 && column >= 0 && row < size && column < size)
        }
        
        func isWhite(row: Int, column: Int) -> Bool {
            spaceIsInBounds(row: row, column: column)
            && (newGrid[row][column] == ".")
        }
        
        func isBlack(row: Int, column: Int) -> Bool {
            spaceIsInBounds(row: row, column: column)
            && (newGrid[row][column] == "#")
        }
        
        func isStartOfVerticalWord(row: Int, column: Int) -> Bool {
            (
                isWhite(row: row, column: column)
                && (
                    (row == 0) 
                    || (isBlack(row: row - 1, column: column))
                )
            )
        }
        
        func isStartOfHorizontalWord(row: Int, column: Int) -> Bool {
            (
                isWhite(row: row, column: column)
                && ((column == 0) || isBlack(row: row, column: column - 1))
            )
        }
        
        func wordLength(at origin: WordOrigin) -> Int {
            if origin.x < 0 || origin.y < 0 || origin.x >= size || origin.y >= size
                || isBlack(row: origin.x, column: origin.y)
            { return 0 }    //  Do not count space
            
            //  Otherwise, return the sum recursively
            if origin.direction == .horizontal {
                return 1 + wordLength(at: (origin.x + 1, origin.y, origin.direction, 0))
            } else {
                return 1 + wordLength(at: (origin.x, origin.y + 1, origin.direction, 0))
            }
        }
        
        func isWord(at startOrigin: WordOrigin, connectedIn words: [WordOrigin]) -> Bool {
            typealias Coordinate = (x: Int, y: Int)
            typealias Line = (start: Coordinate, end: Coordinate, direction: WordDirection)
            
            func doesLine(_ line1: Line, intersect line2: Line) -> Bool {
                if line1.direction == line2.direction { return false }  //  Same direction
                let verticalLine = line1.direction == .vertical ? line1 : line2
                let horiztonalLine = line1.direction == .horizontal ? line1 : line2
                
                //  The lines are intersecting if the vertical line x is between the horiztaonl 
                //  line X's AND the horizontal line Y is between the vertical lines y (both inclusive)
                let verticalBetweenHorizontalXs = verticalLine.start.x >= horiztonalLine.start.x 
                    && verticalLine.start.x <= horiztonalLine.end.x
                let horizontalBetweenVerticalYs = horiztonalLine.start.y >= verticalLine.start.y
                    && horiztonalLine.start.y <= verticalLine.end.y
                    
                return verticalBetweenHorizontalXs && horizontalBetweenVerticalYs
            }
            
            let baseCoordinateStart: Coordinate = (startOrigin.x, startOrigin.y)
            let baseCoordinateEnd: Coordinate = startOrigin.direction == .horizontal 
                ? (startOrigin.x + startOrigin.length, startOrigin.y)
                : (startOrigin.x, startOrigin.y + startOrigin.length)
            let originLine = (baseCoordinateStart, baseCoordinateEnd, startOrigin.direction)
            
            for word in wordOrigins where word.direction != startOrigin.direction { //  Direction should not be the same
                //  For every word, determine the start and end coordinates
                //  And determine if the coordinates intersect
                let start = (word.x, word.y)
                let end = word.direction == .vertical ? (word.x, word.y + word.length) : (word.x + word.length, word.y)
                let wordLine = (start, end, word.direction)
                
                //  Now that we have the start and end coordinates of the given word., see if they intersect with the
                //  base word.
                //  We can stop as soon as an intersection is found for the starting word
                if doesLine(originLine, intersect: wordLine) {
                    return true
                }
            }
            
            //  No intersection found
            return false
        }
        
        //  Before we check words, check to see if the board is semetric
        if !isBoardSemetric() {
            return false
        }
        
        var wordOrigins: [WordOrigin] = []
        
        for row in 0..<size {
            for column in 0..<size {
                
                if isStartOfHorizontalWord(row: row, column: column) {
                    wordOrigins.append((row, column, .horizontal, wordLength(at: (row, column, .horizontal, 0))))
                }
                
                if isStartOfVerticalWord(row: row, column: column) {
                    wordOrigins.append((row, column, .vertical, wordLength(at: (row, column, .vertical, 0))))   
                }
            }
        }
        
        //  Filter for only the valid words
        let validWordOrigins = wordOrigins.filter({ $0.length >= 3})
        
        //  No valid words
        if validWordOrigins.isEmpty { return false }
        
        //  Now that we have "valid" words, we need to check for cnnectivity.
        //  Each word must be connected to another word
        let connectedWordOrigins = validWordOrigins.filter({isWord(at: $0, connectedIn: validWordOrigins)})
        
        //  All valid words must be connected
        return validWordOrigins.count == connectedWordOrigins.count
    }
    
}