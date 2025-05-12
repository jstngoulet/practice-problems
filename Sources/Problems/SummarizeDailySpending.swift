import Foundation

class SummarizeDailySpending: Problem {
    /**
     Summarizes daily spending from a list of (date, amount) transactions.
    
     - Parameter transactions: An array of tuples where each tuple contains a date string (`YYYY-MM-DD`) and a Double representing the transaction amount.
     - Returns: An array of tuples with each date and the total amount spent on that date, sorted chronologically.
     */
    func summarizeSpending(_ transactions: [(String, Double)]) -> [(String, Double)] {
       var dailyTransactions: [String: Double] = [:]
       
       for (date, amount) in transactions {
            dailyTransactions[date, default: 0] += amount
       }
       
        return dailyTransactions
            .map { ($0.key, $0.value )}
            .sorted { $0.0 < $1.0 }
    }

    override func performTests() {
        print("Running tests for: SummarizeDailySpending")

        struct TestCase {
            let input: [(String, Double)]
            let expected: [(String, Double)]
        }

        let tests: [TestCase] = [
            // Test 1: Multiple transactions per day
            TestCase(
                input: [
                    ("2025-05-10", 12.50), ("2025-05-12", 8.00), ("2025-05-10", 5.75),
                    ("2025-05-11", 20.00),
                ],
                expected: [("2025-05-10", 18.25), ("2025-05-11", 20.00), ("2025-05-12", 8.00)]
            ),

            // Test 2: Single transaction per day
            TestCase(
                input: [("2025-05-01", 10.00), ("2025-05-02", 20.00)],
                expected: [("2025-05-01", 10.00), ("2025-05-02", 20.00)]
            ),

            // Test 3: Unordered dates
            TestCase(
                input: [("2025-05-03", 15.00), ("2025-05-01", 5.00), ("2025-05-02", 10.00)],
                expected: [("2025-05-01", 5.00), ("2025-05-02", 10.00), ("2025-05-03", 15.00)]
            ),

            // Test 4: No transactions
            TestCase(
                input: [],
                expected: []
            ),

            // Test 5: Same day, exact same amount twice
            TestCase(
                input: [("2025-05-05", 7.77), ("2025-05-05", 7.77)],
                expected: [("2025-05-05", 15.54)]
            ),

            // Test 6: Large set with duplicates
            TestCase(
                input: [
                    ("2025-01-01", 1.0), ("2025-01-01", 2.0), ("2025-01-02", 3.0),
                    ("2025-01-02", 4.0),
                ],
                expected: [("2025-01-01", 3.0), ("2025-01-02", 7.0)]
            ),

            // Test 7: Negative transactions (refunds)
            TestCase(
                input: [("2025-06-01", 10.0), ("2025-06-01", -3.0)],
                expected: [("2025-06-01", 7.0)]
            ),

            // Test 8: High precision decimals
            TestCase(
                input: [("2025-05-06", 1.1234), ("2025-05-06", 2.8766)],
                expected: [("2025-05-06", 4.0)]
            ),

            // Test 9: Future dates
            TestCase(
                input: [("2026-01-01", 100.0), ("2025-12-31", 50.0)],
                expected: [("2025-12-31", 50.0), ("2026-01-01", 100.0)]
            ),

            // Test 10: Mixed date order and refunds
            TestCase(
                input: [("2025-01-02", 20.0), ("2025-01-01", 30.0), ("2025-01-02", -5.0)],
                expected: [("2025-01-01", 30.0), ("2025-01-02", 15.0)]
            ),
        ]

        // Print header
        // Print header
        let header = [
            "Test#".padding(toLength: 6, withPad: " ", startingAt: 0),
            "Output".padding(toLength: 40, withPad: " ", startingAt: 0),
            "Expected".padding(toLength: 40, withPad: " ", startingAt: 0),
            "Pass",
        ].joined(separator: " | ")
        print(header)
        print(String(repeating: "-", count: header.count))

        for (i, test) in tests.enumerated() {
            let output = summarizeSpending(test.input)
            let pass = output.elementsEqual(
                test.expected, by: { $0.0 == $1.0 && abs($0.1 - $1.1) < 0.001 })

            let testNum = "\(i + 1)".padding(toLength: 6, withPad: " ", startingAt: 0)
            let outputStr = "\(output)".padding(toLength: 40, withPad: " ", startingAt: 0)
            let expectedStr = "\(test.expected)".padding(toLength: 40, withPad: " ", startingAt: 0)
            let passStr = pass ? "✅" : "❌"

            print("\(testNum) | \(outputStr) | \(expectedStr) | \(passStr)")
        }
    }
}
