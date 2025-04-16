/**
## 🧠 Programming Challenge: **Anagram Inspector**

### 📝 Problem Statement

Write a function that determines whether two input strings are **anagrams** of each other. Two strings are anagrams if they contain the **same characters** in the **same frequency**, but in **different orders**. Ignore case and any non-alphabetic characters.

### ✒️ Function Signature

```python
def are_anagrams(str1: str, str2: str) -> bool:
```

### ✅ Input

- `str1`: A string of up to 1,000 characters.
- `str2`: A string of up to 1,000 characters.

### 🎯 Output

- Return `True` if the two strings are anagrams, `False` otherwise.

### 📌 Rules

- Ignore spaces, punctuation, and case sensitivity.
- Only alphabetical characters should be considered.
- `"Listen"` and `"Silent"` are valid anagrams.
- `"Hello"` and `"Olelh!"` are also anagrams (punctuation is ignored).

---

### 🧪 Test Cases

| Input 1         | Input 2         | Expected Output |
|----------------|-----------------|-----------------|
| "Listen"       | "Silent"        | `True`          |
| "Hello, World" | "dlroW ,olleH!" | `True`          |
| "Apple"        | "Pabble"        | `False`         |
| "Dormitory"    | "Dirty room!!"  | `True`          |
| "abc"          | "def"           | `False`         |

---

### 💡 Bonus Challenges (Optional)

1. **Group Anagrams**: Given a list of strings, group them into sets of anagrams.
2. **Real-time Detection**: Write a function that takes a stream of characters and checks after each input whether the current string is an anagram of a target word.
3. **Performance Boost**: Optimize your solution to handle 1 million character strings.

*/

import Foundation 

class AnagramInspector: Problem {
    
    override func performTests() {
        typealias TestCase = (str1: String, str2: String, expected: Bool)
        let tests: [TestCase] = [
            ("Listen", "Silent", true),
            ("Hello, World", "dlroW ,olleH", true),
            ("Apple", "Pabble", false),
            ("Dormitory", "Dirty room", true),
            ("abc", "def", false)
        ]

        for (iter, test) in tests.enumerated() {
            let result = areAnagrams(test.0, test.1)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \(isPassed ? "✅" : "❌")\t: \(test.str1)\t\(test.str2)\t\(result)")
        }

    }
    
    func areAnagrams(_ str1: String, _ str2: String) -> Bool {
        let ar1: [Character] = Array(sanitize(str1)).sorted()
        let ar2: [Character] = Array(sanitize(str2)).sorted()
        return ar1 == ar2
    }
    
    func sanitize(_ str: String) -> String {
        str
            .replacingOccurrences(of: " ", with: "")
            .lowercased()
    }

}