/**

## 🧩 Challenge: **Group Anagrams**

### 📝 Problem Statement

Given a list of strings, group them into sets of **anagrams**. Two strings are anagrams if they contain the same characters, in the same frequency, but in a different order. Your task is to group the input strings into distinct sets where each set contains only anagrams of each other.

### ✒️ Function Signature

```swift
func groupAnagrams(_ strs: [String]) -> [[String]]
```

### ✅ Input

- `strs`: A list of strings, where each string has a length between 1 and 100. The total number of strings is between 1 and 1,000.
- Strings may contain lowercase and uppercase alphabets, but your solution should be case insensitive.

### 🎯 Output

- Return a list of lists where each inner list contains **anagrams**. 
- Each group of anagrams should be sorted alphabetically. 
- The groups themselves can be in any order.

### 📌 Constraints

1. **Anagram Definition**: Two strings are anagrams if their sorted character sequences are the same. For example, "eat" and "tea" are anagrams, while "eat" and "tan" are not.
2. **Case Insensitivity**: Ensure your solution is case-insensitive (e.g., "abc" and "ABC" are considered anagrams).
3. **Time Complexity**: Try to implement a solution that is efficient in time complexity. A brute-force solution can work, but it might be less optimal with large inputs.
4. **Edge Case**: Handle the case where the list has only one string, which should return a list containing one group with the single string.

### 📌 Example

#### Input
```swift
["eat", "tea", "tan", "ate", "nat", "bat"]
```

#### Output
```swift
[
    ["eat", "tea", "ate"],
    ["tan", "nat"],
    ["bat"]
]
```

- **Explanation**: 
    - "eat", "tea", and "ate" are anagrams and should be grouped together.
    - "tan" and "nat" are anagrams and form another group.
    - "bat" does not have any anagrams in this list, so it forms its own group.

#### Input
```swift
["a"]
```

#### Output
```swift
[
    ["a"]
]
```

- **Explanation**: Since there's only one string, it forms its own group.

#### Input
```swift
["abc", "bca", "cab", "xyz", "zyx"]
```

#### Output
```swift
[
    ["abc", "bca", "cab"],
    ["xyz", "zyx"]
]
```

### 🧪 Test Cases

| Input                          | Output                                  |
|---------------------------------|-----------------------------------------|
| `["eat", "tea", "tan", "ate", "nat", "bat"]` | `[["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]` |
| `["a"]`                         | `[["a"]]`                               |
| `["abc", "bca", "cab", "xyz", "zyx"]` | `[["abc", "bca", "cab"], ["xyz", "zyx"]]` |
| `["", ""]`                       | `[["", ""]]`                            |
| `["hello", "oellh", "world"]`    | `[["hello", "oellh"], ["world"]]`      |

### 💡 Bonus

1. **Optimize**: Can you optimize the solution to handle large inputs (up to 1,000 strings)?
2. **Use Hashing**: Implement a solution that uses a hash map (dictionary) to store and group anagrams efficiently.
3. **Sorting**: Experiment with different ways of sorting the strings, either by character counts or sorting the string characters.

### 🎯 Grading Criteria

- **Correctness**: Does the solution group the strings correctly into anagrams?
- **Efficiency**: Is the solution optimized for performance, especially with large inputs?
- **Edge Case Handling**: Does the solution handle cases like empty strings, a single string, or repeated strings appropriately?
- **Code Readability**: Is the solution clean, easy to understand, and well-documented?

*/
import Foundation

class GroupAnagrams: Problem {
    
    override func performTests() {
        typealias TestCase = (input: [String], expected: [[String]])
        let testCases: [TestCase] = [
                (
                    ["eat", "tea", "tan", "ate", "nat", "bat"],
                    [["ate", "eat", "tea"], ["tan", "nat"], ["bat"]]
                ),
                (
                    ["a"],
                    [["a"]]
                ),
                (
                    ["abc", "bca", "cab", "xyz", "zyx"],
                    [["abc", "bca", "cab"], ["xyz", "zyx"]]
                ),
                (
                    ["", ""],
                    [["", ""]]
                ),
                (
                    ["hello", "oellh", "world"],
                    [["hello", "oellh"], ["world"]]
                )
            ]

            // Print table header
            print("╔═══════╤══════════════════════════════════════════════════╤══════════════════════════════════════════════════╤══════════╗")
            print("║ Test  │ Input                                            │ Expected Output                                  │ Passed   ║")
            print("╟───────┼──────────────────────────────────────────────────┼──────────────────────────────────────────────────┼──────────╢")

            for (index, testCase) in testCases.enumerated() {
                let (input, expected) = testCase
                let result = groupAnagrams(input)

                // Normalize the output and expected for comparison (sort inner and outer arrays)
                let normalize: ([[String]]) -> [[String]] = { groups in
                    return groups.map { $0.sorted() }.sorted { $0.first ?? "" < $1.first ?? "" }
                }

                let passed = normalize(result) == normalize(expected)

                // Convert arrays to pretty strings for printing
                let inputStr = input.description.padding(toLength: 48, withPad: " ", startingAt: 0)
                let expectedStr = expected.description.padding(toLength: 48, withPad: " ", startingAt: 0)
                let passedStr = passed ? "✅" : "❌"

                print("║ #\(index + 1)    │ \(inputStr) │ \(expectedStr) │ \(passedStr)       ║")
            }

            print("╚═══════╧══════════════════════════════════════════════════╧══════════════════════════════════════════════════╧══════════╝")

    }
    
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        
        if strs.isEmpty { return [] }
        var currentGroups: [String: [String]] = [:]
        
        for word in strs {
            let key = String(word.lowercased().filter({ $0.isLetter }).sorted())
            currentGroups[key, default: []].append(word)
        }
        return Array(currentGroups.values)
    }
    
}