import Foundation

class ClimbStairs: Problem {
    /**
     You are climbing a staircase. It takes n steps to reach the top.
     Each time you can either climb 1 or 2 steps.
     In how many distinct ways can you climb to the top?
    
     - Parameter n: The total number of steps in the staircase.
     - Returns: The number of distinct ways to reach the top.
     */
    func climbStairs(_ n: Int) -> Int {
        // Implementation goes here
        /**
            BReakdown: 
            - Let's climb the stairs all by singles first, 
            - Then, let's climb by all singles, except the last one by 2
            - Then, all singles, but the last 2 by 2
        */
        //  Recursive
        // if n == 0 || n == 1 { return 1 }
        // return climbStairs(n - 1) + climbStairs(n - 2)
        
        //  DP: REcursive, but keep track of previous steps
        var memo: [Int: Int] = [:]
        
        func climb(_ i: Int) -> Int {
            if i == 0 || i == 1 { return 1 }
            if let cached = memo[i] { return cached }
            memo[i] = climb(i-1) + climb(i-2)
            return memo[i, default: 0]
        }
        
        return climb(n)
    }

    override func performTests() {
        print("=== ClimbStairs Tests ===")
        let header = "| #  | Input | Expected | Actual | Pass |"
        let separator = String(repeating: "-", count: header.count)

        typealias TestCase = (n: Int, expected: Int)
        let tests: [TestCase] = [
            // Edge case: 0 steps
            (0, 1),
            // 1 step
            (1, 1),
            // 2 steps: [1+1, 2]
            (2, 2),
            // 3 steps: [1+1+1, 1+2, 2+1]
            (3, 3),
            // 4 steps: [1+1+1+1, 1+1+2, 1+2+1, 2+1+1, 2+2]
            (4, 5),
            // 5 steps (Fibonacci sequence)
            (5, 8),
            // 10 steps
            (10, 89),
            // 15 steps
            (15, 987),
            // 20 steps
            (20, 10946),
            // 25 steps
            (25, 121393),
        ]

        print(separator)
        print(header)
        print(separator)

        for (i, test) in tests.enumerated() {
            let result = climbStairs(test.n)
            let passed = result == test.expected ? "✅" : "❌"

            let idx = "\(i + 1)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let inputStr = "\(test.n)".padding(toLength: 5, withPad: " ", startingAt: 0)
            let expected = "\(test.expected)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let actual = "\(result)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let passStr = passed.padding(toLength: 4, withPad: " ", startingAt: 0)

            print("| \(idx) | \(inputStr) | \(expected) | \(actual) | \(passStr) |")
        }

        print(separator)
    }
}