/**

## 🔐 One-Dial Lock Puzzle

You're trying to open a combination lock with a **single rotating dial**.

- The dial has numbers from `1` to `N`, arranged in a circle.
- At any moment, the dial can rotate **clockwise or counter-clockwise** by 1 unit per second.
- The dial starts at position `1`.

You're given a list of `M` numbers — the **unlock code sequence**. To open the lock, you must enter each number **in order**, moving the dial to point at the correct number each time.

**Your task** is to compute the **minimum number of seconds** required to enter the full code.

---

### ⏱️ Dial Rules

- Moving from number `a` to number `b` takes `min(abs(a - b), N - abs(a - b))` seconds.
- Selecting a number when the dial is pointing at it takes **no time**.
- You must move to each number in the code sequence in the exact given order.

---

### 📥 Input

- An integer `N` — the total number of positions on the dial (`2 ≤ N ≤ 10⁴`)
- An integer `M` — the length of the unlock code (`1 ≤ M ≤ 10⁴`)
- An array `C` of `M` integers — the code to enter (`1 ≤ C[i] ≤ N`)

---

### 📤 Output

- A single integer — the **minimum total time** (in seconds) needed to enter the code.

---

### 💡 Example

```plaintext
Input:
N = 10
M = 4
C = [9, 4, 4, 8]

Output:
6
```

### 🧮 Explanation:

- Start at `1` → move to `9` → takes 2 seconds
- `9` → `4` → takes 5 seconds (counter-clockwise)
- `4` → `4` → takes 0 seconds (already there)
- `4` → `8` → takes 1 second

**Total = 2 + 5 + 0 + 1 = 8**

*/
import Foundation

class RotaryLock: Problem {
    override func performTests() {
        typealias TestCase = (numbers: Int, comboLength: Int, combo: [Int], expected: Int)
        let tests: [TestCase] = [
            (10, 4, [9, 4, 4, 8], 11),        // Walkthrough: 1→9 (2), 9→4 (5), 4→4 (0), 4→8 (1)
            (3, 3, [1, 2, 3], 2),             // 1→1 (0), 1→2 (1), 2→3 (1)
            (5, 5, [5, 1, 2, 3, 4], 5),       // 1→5 (1), 5→1 (1), 1→2 (1), 2→3 (1), 3→4 (1)
            (10, 1, [1], 0),                  // Already at 1
            (12, 3, [7, 1, 12], 13),          // 1→7 (6), 7→1 (6), 1→12 (1)
            (8, 4, [2, 4, 6, 8], 7),          // 1→2 (1), 2→4 (2), 4→6 (2), 6→8 (2)
            (100, 2, [51, 1], 100),           // 1→51 (50), 51→1 (50)
            (4, 5, [2, 2, 2, 2, 2], 1),       // 1→2 (1), then no movement
            (7, 3, [7, 1, 4], 5),             // 1→7 (1), 7→1 (1), 1→4 (3)
            (2, 6, [2, 1, 2, 1, 2, 1], 6)     // Flipping back and forth each time
        ]

        for (iter, test) in tests.enumerated() {
            let result = shortestTurns(test.numbers, test.comboLength, test.combo)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\tE: \(test.expected)\tR: \(result)")
        }
    }
    
    ///  Calculates the time required at one number a second to perform teh combo in shortest path
    /// - Parameters:
    ///   - N: Quanity of numbers on the dial
    ///   - M: Quantity of numbers in the combo
    ///   - C: The combination trying to solve
    /// - Returns: The time in seconds it takes to achieve the dial in shortest single path
    func shortestTurns(_ N: Int, _ M: Int, _ C: [Int]) -> Int {
        var seconds: Int = 0        //  Start at 0, hasn't moved yet
        var dialPosition: Int = 1   //  Start at 1
     
        func shortestDistance(from current: Int, to number: Int) -> Int {
            let distance = abs(number - current)
            return min(distance, N - distance)  //  Left and right way
        }
        
        //  For every number in the combo, run through it and grab the shortest distance
        //  After the distance is updated, set the new dial position
        for comboNumber in C {            
            seconds += shortestDistance(from: dialPosition, to: comboNumber)
            dialPosition = comboNumber
        }
     
        return seconds   
    }
}