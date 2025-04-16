import Foundation

/**
Problem Title: Word Ladder Transformation

Problem Description:

Given two words, start and end, and a dictionary of valid words, you need to write a function that 
determines the shortest transformation sequence from start to end, such that:

Only one letter can be changed at a time.
Each transformed word must exist in the dictionary.
Write a function in Swift called 
shortestTransformationSequence(start: String, end: String, wordList: [String]) -> [String]? 
that returns the sequence of words in the shortest transformation from start to end. If no such sequence 
exists, return nil.

You are allowed to assume the following:

The dictionary contains unique words.
The word list has at least one word and can contain up to 1000 words.
The length of each word is between 1 and 10 characters.

Example 1:
```swift
let start = "hit"
let end = "cog"
let wordList = ["hot", "dot", "dog", "lot", "log", "cog"]
let result = shortestTransformationSequence(start: start, end: end, wordList: wordList)
print(result)
// Expected Output: ["hit", "hot", "dot", "dog", "cog"]
```

Example 2: 
```swift
let start = "hit"
let end = "cog"
let wordList = ["hot", "dot", "dog", "lot", "log"]
let result = shortestTransformationSequence(start: start, end: end, wordList: wordList)
print(result)
// Expected Output: nil
```

Function Signature:
```swift
func shortestTransformationSequence(start: String, end: String, wordList: [String]) -> [String]?
```

Constraints:

- The length of the start, end, and words in wordList are all within the range of 1 to 10 characters.
- The word list has a size between 1 and 1000.
- The start and end words are guaranteed to be of the same length.

Hints:

- You can treat this problem as a graph traversal problem, where each word is a node, and an edge 
exists between two nodes if their words differ by exactly one character.
- A breadth-first search (BFS) is a good fit for this problem to ensure 
the shortest transformation sequence is found.

This question requires a combination of algorithmic thinking (graph traversal) and knowledge of 
data structures like sets, queues, and maps in Swift. The use of BFS ensures that the problem is solved 
optimally in terms of the shortest transformation sequence.
*/
class WordLadder: Problem {
    
    override func performTests() {
        typealias TestCase = (start: String, end: String, wordSet: [String], expected: [String]?)
        let tests: [TestCase] = [
            ("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"], ["hit", "hot", "dot", "dog", "cog"]), 
            ("hit", "cog", ["hot", "dot", "dog", "lot", "log"], nil)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = shortestTransformationSequence(start: test.0, end: test.1, wordList: test.2)
            let isPassed = test.expected == result
            print("Test \(iter + 1): Result: \(isPassed ? "PASSED" : "FAILED")\t Result: \(result ?? [])")
        }
    }
    
    func shortestTransformationSequence(
        start: String, 
        end: String, 
        wordList: [String]
    ) -> [String]? {
        //  Create a set to make list O(1) Lookup
        var wordSet: Set<String> = Set(wordList)
        
        if !wordSet.contains(end) { return nil }
        
        //  Create a lookup for a word and a path
        var queue: [(word: String, path: [String])] = [(start, [start])]
        
        //  Remove the current word to remove duplicates
        wordSet.remove(start)
        
        while !queue.isEmpty {
            
           let currentItem = queue.removeFirst()
            
            if currentItem.word == end {
                return currentItem.path
            }
            
            //  For every letter in the current word, swap out the next iterator
            /**
            For example, if we have the start word, `dog` and end word `cat`, 
            compared to the list: `["dog", "cog", "tag", "bag", "sat"]
            We would have the following iterations: 
            1. dog
            2. aog..         Exists in set? F
                    bog..    Exists in set? F
                    cog..    Exists in set? T  -> Keep going to find other iterations, but now, break and continue
                    ...
            3. cag..         Exists in set? F
                    cbg..    Exists in set? F
                    ccg..    Exists in set? F 
                    ...
            4. Note that we have both trains going now. so, now, think of it as a grid. 
                We want the grid to keep finding results that will eventually contain words and create our path
            */
            for iter in 0..<currentItem.word.count {
                var wordArray: [Character] = Array(currentItem.word.lowercased())    //  Better index
                //  Create loop through all letters
                for letter in "abcdefghijklomnopqrstuvwxyz" {
                    //  update the letter at the current iterator
                    wordArray[iter] = letter
                    let newWord = String(wordArray)
                    
                    //  If the set contains the new word, advance
                    if wordSet.contains(newWord) {
                        var updatedPath = currentItem.path
                        updatedPath.append(newWord)
                        queue.append((newWord, updatedPath))
                        wordSet.remove(newWord)
                    }
                }
            }
        }

        return nil
    }
}