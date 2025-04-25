import Foundation

class FactorialCalculation: Problem {
    
    override func performTests() {
        typealias TestCase = (num: Int, expected: Int)
        let tests: [TestCase] = [
            (0, 1), (1, 1), (2, 2), (3, 6), (4, 24),
            (5, 120), (6, 720), (7, 5040), (10, 3628800),
            (12, 479001600), (15, 1307674368000), (20, 2432902008176640000),
        ]

        print(String(repeating: "-", count: 69))
        print("| #   | Inp | Expected              | Actual                | Pass  |")
        print(String(repeating: "-", count: 69))

        for (i, test) in tests.enumerated() {
            let result = determineFactorial(of: test.num)
            let pass = result == test.expected ? "✅" : "❌"

            let idx = "\(i + 1)".padding(toLength: 4, withPad: " ", startingAt: 0)
            let input = "\(test.num)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let expected = "\(test.expected)".padding(toLength: 21, withPad: " ", startingAt: 0)
            let actual = "\(result)".padding(toLength: 21, withPad: " ", startingAt: 0)
            let passStr = pass.padding(toLength: 5, withPad: " ", startingAt: 0)

            print("| \(idx)| \(input) | \(expected) | \(actual) | \(passStr)|")
        }

        print(String(repeating: "-", count: 69))
    }
    
    func determineFactorial(of number: Int) -> Int {
        if number <= 1 { return 1 }
        return number * determineFactorial(of: number - 1)
    }
    
}