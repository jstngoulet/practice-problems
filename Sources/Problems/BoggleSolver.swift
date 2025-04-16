
/**
### **Boggle Problem Prompt**

#### Problem Description:

Given a **2D grid** of characters (a Boggle board), your task is to **find all possible words** that can be formed from the letters of the grid by starting at any letter and moving to adjacent letters in any direction (horizontally, vertically, or diagonally), and not reusing the same cell in the same word.

The words must be valid according to a given **dictionary**. A valid word is one that appears in the dictionary and has at least 3 characters.

#### Input:
- A **2D grid** of characters `board`, where each element is a lowercase English letter (`board[i][j]`).
- A **dictionary** of valid words, which is a set or list of strings.

#### Output:
- Return a list of all words found in the dictionary that can be formed from the given board.

#### Constraints:
- The grid will have a maximum size of `m x n` (where `1 ≤ m, n ≤ 10`).
- The dictionary will have a maximum size of `k` words, where `1 ≤ k ≤ 1000`.
- The characters in the grid and dictionary are lowercase English letters (`a-z`).
- Words in the result should be **unique** (no duplicates).

#### Example:

##### Input:
```swift
board = [
    ["o", "a", "a", "n"],
    ["e", "t", "a", "e"],
    ["i", "h", "k", "r"],
    ["i", "f", "l", "v"]
]
dictionary = ["oath", "pea", "eat", "rain", "hike"]
```

##### Output:
```swift
["eat", "oath", "hike"]
```

##### Explanation:
- The words "eat", "oath", and "hike" can be formed on the board.
- "pea" and "rain" do not appear on the board.

#### Problem Constraints and Considerations:
1. The word must be formed by adjacent letters, meaning each letter must be directly next to the previous letter in one of the eight directions (horizontally, vertically, or diagonally).
2. A cell in the grid cannot be used more than once in the same word.
3. The dictionary could contain words that are not possible to form from the board (so they should be ignored in the result).
4. The result should contain the found words in any order.

---

### **Approach**

1. **Trie Data Structure**:
   - A **Trie** (prefix tree) is an efficient data structure for storing and searching words.
   - We can insert all words in the dictionary into the Trie. This helps us quickly check if a prefix exists in the dictionary while performing the search on the board.

2. **Backtracking**:
   - We will perform a **backtracking search** starting from each cell in the board.
   - For each cell, we will explore all possible adjacent cells recursively and keep forming words as we go. Each time we form a valid word, we add it to the result set.

3. **Pruning**:
   - While searching, we can prune the search:
     - If the current prefix is not a valid prefix in the dictionary, we stop searching down that path.
     - If the current word is already found, we don't process it again.

4. **Visited Cells**:
   - We will mark cells as visited during each search to ensure that we don’t reu
*/

import Foundation

class BoggleSolver: Problem {
    
    override func performTests() {
        typealias TestCase = (board: [[Character]], rows: Int, columns: Int, dict: [String], expected: [String])
        let tests: [TestCase] = [
            // Test case 1
            (
                [
                    ["o", "a", "a", "n"],
                    ["e", "t", "a", "e"],
                    ["i", "h", "k", "r"],
                    ["i", "f", "l", "v"]
                ], 
                4, 4, ["oath", "pea", "eat", "rain", "hike"],
                ["eat", "oath"].sorted()
            ),
            
            // Test case 2
            (
                [
                    ["t", "r", "e", "t"],
                    ["r", "e", "s", "t"],
                    ["e", "s", "t", "r"],
                    ["t", "r", "e", "t"]
                ], 
                4, 4, ["test", "rest", "dog", "cat"],
                ["test", "rest"].sorted()
            ),
            
            // Test case 3: Board with a word but no valid dictionary words
            (
                [
                    ["a", "b", "c"],
                    ["d", "e", "f"],
                    ["g", "h", "i"]
                ],
                3, 3, ["bed", "dog", "cat"],
                ["bed"]
            ),
            
            // Test case 4: Only one valid word in dictionary, small board
            (
                [
                    ["a", "b", "c"],
                    ["d", "e", "f"],
                    ["g", "h", "i"]
                ],
                3, 3, ["abc", "dog", "cat"],
                ["abc"].sorted()
            ),
            
            // Test case 5: No valid word in dictionary
            (
                [
                    ["a", "b", "c"],
                    ["d", "e", "f"],
                    ["g", "h", "i"]
                ],
                3, 3, ["jkl", "mno", "pqr"],
                []
            ),
            
            // Test case 6: Larger board with multiple valid dictionary words
            (
                [
                    ["w", "o", "r", "d"],
                    ["l", "o", "v", "e"],
                    ["l", "o", "o", "k"],
                    ["b", "r", "a", "d"]
                ],
                4, 4, ["word", "love", "look", "brad", "rod"],
                ["word", "love", "look", "brad"].sorted()
            ),
            
            // Test case 7: Empty board
            (
                [],
                0, 0, ["word", "love"],
                []
            ),
            
            // Test case 8: Large grid with simple dictionary
            (
                [
                    ["w", "o", "r", "l", "d"],
                    ["l", "o", "v", "e", "d"],
                    ["r", "o", "v", "e", "o"],
                    ["v", "e", "o", "d", "l"],
                    ["e", "o", "v", "e", "w"]
                ],
                5, 5, ["word", "love", "love", "world", "lo", "vowel", "row"],
                ["lo", "love", "row", "world"].sorted()
            )
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = findWords(in: test.board, rows: test.rows, columns: test.columns, wordDictionary: test.dict).sorted()
            let isPassed = result == test.expected
            print("Test \(iter + 1): \(isPassed ? "✅" : "❌")\n\tE: \(test.expected)\n\tR: \(result)\n")
        }
    }
    
    /**
    ["o", "a", "a", "n"],
    ["e", "t", "a", "e"],
    ["i", "h", "k", "r"],
    ["i", "f", "l", "v"]
    */
    func findWords(in board: [[Character]], rows: Int, columns: Int, wordDictionary: [String]) -> [String] {
        
        var wordList: Set<String> = []
        
        //  Base visited is used twice
        let baseVisited: [[Bool]] = Array(repeating: Array(repeating: false, count: columns), count: rows)
        
        //  set default to false
        var visitedCells: [[Bool]] = baseVisited    
        
        func dfsWordSearch(x: Int, y: Int, currentWord: String) {
            // Boundary conditions
            if x < 0 || y < 0 { return }
            if y >= columns || x >= rows { return }
            if visitedCells[x][y] == true { return }
            
            // Add current cell to the word
            let newWord: String = currentWord + String(board[x][y])
            
            // If the word is in the dictionary, add it to the result
            if wordDictionary.contains(newWord) {
                wordList.insert(newWord)
            }
            
            // Mark the current cell as visited
            visitedCells[x][y] = true
            
            // Explore all 4 possible directions (up, down, left, right)
            dfsWordSearch(x: x + 1, y: y, currentWord: newWord)  // right
            dfsWordSearch(x: x - 1, y: y, currentWord: newWord)  // left
            dfsWordSearch(x: x, y: y + 1, currentWord: newWord)  // down
            dfsWordSearch(x: x, y: y - 1, currentWord: newWord)  // up
            
            // Backtrack and unmark the cell as visited
            visitedCells[x][y] = false
        }
        
        //  Create the word list
        //  Run through for every letter as a starting point
        for letterx in 0..<columns {
            for letterY in 0..<rows {
                dfsWordSearch(x: letterx, y: letterY, currentWord: "")
            }
        }
        
        return Array(wordList)
    }
    
    
}