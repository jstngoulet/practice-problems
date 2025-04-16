/**
## 🔐 Programming Challenge: Crack the Circular Lock

### Problem Description

You’re faced with a lock that consists of **two rotating wheels**, each labeled with the numbers from **1 to N**, arranged **circularly** (i.e., 1 is adjacent to N). Each wheel starts at **1**. 

To unlock it, you must enter a sequence of **M integers**, where each integer must be selected by one of the two wheels **in order**. At any point, you can choose either wheel to select the next integer in the code.

### Rules:
- It takes **1 second** to rotate a wheel by **1 unit** (in either direction).
- Selecting a number (once the wheel is pointing to it) takes **0 seconds**.
- You **must** select the code numbers **in order**, one at a time.
- You can decide **on the fly** which wheel to use for each code digit.

### Objective

Determine the **minimum total time in seconds** required to enter the full code.

---

### Input

- An integer `N` — the number of integers on each wheel (2 ≤ N ≤ 1000)
- An integer `M` — the length of the unlock code (1 ≤ M ≤ 1000)
- A list of `M` integers `C` (1 ≤ C[i] ≤ N) — the code to be entered

---

### Output

- A single integer representing the **minimum number of seconds** required to unlock the lock.

---

### Example

#### Input:
```
N = 10  
M = 5  
C = [3, 8, 9, 4, 5]
```

#### Output:
```
14
```

#### Explanation:
- Wheel A selects 3 (2 steps clockwise from 1)
- Wheel B selects 8 (3 steps clockwise from 1)
- Wheel A moves from 3 to 9 (either 6 or 4 steps → go counterclockwise in 4)
- Wheel B moves from 8 to 4 (either 6 or 4 steps → go clockwise in 4)
- Wheel A moves from 9 to 5 (either 6 or 4 steps → go counterclockwise in 4)
- Total = 2 + 3 + 4 + 4 + 4 = 17 — **Wait, we said 14?**
- So clearly there's a better assignment. Optimal path minimizes total moves across wheels.

---

### Notes

- Wheels are independent — both can rotate simultaneously, but only one wheel can be used per code digit.
- You’re free to switch back and forth between wheels however you see fit.
- The circular structure means distance from `a` to `b` is `min(|a - b|, N - |a - b|)`.

---

### Constraints

- Efficient solutions are expected. A brute-force approach will time out. Consider using dynamic programming or memoization.
*/

import Foundation

class RotaryLock2: Problem {
    
    override func performTests() {
        typealias TestCase = (dialNumbers: Int, comboLength: Int, combo: [Int], expected: Int)
        let tests: [TestCase] = [
            (3, 3, [1, 2, 3], 2),
            (10, 4, [9, 4, 4, 8], 6),
            
            //  Others
            (10, 5, [3, 8, 9, 4, 5], 14),
            (10, 5, [1, 1, 1, 1, 1], 0),
            (5, 3, [3, 3, 3], 2),
            (4, 4, [2, 3, 4, 1], 4),
            (12, 6, [6, 12, 1, 7, 3, 9], 15),
            (2, 4, [2, 1, 2, 1], 2),
            (1000, 1, [500], 499),
            (7, 3, [4, 1, 7], 6),
            (6, 5, [1, 6, 1, 6, 1], 5),
            (10, 4, [2, 9, 2, 9], 6)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = shortestTurns(test.0, test.1, test.combo)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \(isPassed ? "✅" : "❌")\tE: \(test.expected)\t R: \(result)")
        }
    }
    
    ///  Returns the shortest amount of time it takes to solve the puzzle
    /// - Parameters:
    ///   - N: Number of numbers in the lock ( 1 -> N )
    ///   - M: Number of numbers in the combo (c.Count)
    ///   - C: The numbers in the combination that all must be met
    /// - Returns: 
    func shortestTurns(_ N: Int, _ M: Int, _ C: [Int]) -> Int {
        /** GReedy, but not optimal
        var leftRotaryNumber: Int = 1
        var rightRotaryNumber: Int = 1
        var secondsTaken: Int = 0
        
        func shortestDistance(from current: Int, to newNumber: Int, length: Int) -> Int {
            let diff = abs(current - newNumber)
            return min(diff, length - diff)
        }
        
        //  Perform an action for every number in the combo
        for number in C {
            
            //  If the number is the same as one of the curent dials, skip it
            if number == leftRotaryNumber || number == rightRotaryNumber
            { continue }
            
            let leftDialDistance = shortestDistance(from: leftRotaryNumber, to: number, length: N)
            let rightDialDistance = shortestDistance(from: rightRotaryNumber, to: number, length: N)
            
            //  If the left dial distance is shorter, adjust the left dial and update
            //  Else, update the right dial
            if leftDialDistance <= rightDialDistance {
                //  Move left dial
                leftRotaryNumber = number
            } else {
                //  Move the right dial
                rightRotaryNumber = number
            }
            
            //  Increment by the lower value
            secondsTaken += min(leftDialDistance, rightDialDistance)
        }
        
        return secondsTaken*/
        let C = C.map { $0 - 1 } // Convert to 0-based for easier array indexing

        var dp = Array(repeating: Array(repeating: Int.max, count: N), count: N)
        dp[0][0] = 0 // both dials start at 1 → index 0

        func dist(_ a: Int, _ b: Int) -> Int {
            let d = abs(a - b)
            return min(d, N - d)
        }

        for i in 0..<M {
            var next = Array(repeating: Array(repeating: Int.max, count: N), count: N)
            let target = C[i]

            for left in 0..<N {
                for right in 0..<N {
                    let time = dp[left][right]
                    if time == Int.max { continue }

                    // Move left dial
                    let leftCost = time + dist(left, target)
                    next[target][right] = min(next[target][right], leftCost)

                    // Move right dial
                    let rightCost = time + dist(right, target)
                    next[left][target] = min(next[left][target], rightCost)
                }
            }

            dp = next
        }

        // Find minimum in final dp state
        return dp.flatMap { $0 }.min() ?? 0
    }
    
}