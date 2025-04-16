import Foundation

class FactorialCalculation: Problem {
    
    override func performTests() {
        typealias TestCase = (num: Int, expected: Int) 
        let tests: [TestCase] = [
            (0, 1),        // Edge case: 0! = 1
            (1, 1),        // 1! = 1
            (2, 2),        // 2! = 2
            (3, 6),        // 3! = 6
            (4, 24),       // 4! = 24
            (5, 120),      // 5! = 120
            (6, 720),      // 6! = 720
            (7, 5040),     // 7! = 5040
            (10, 3628800), // 10! = 3,628,800
            (12, 479001600), // 12! = 479,001,600
            (15, 1307674368000), // 15! = 1,307,674,368,000
            (20, 2432902008176640000), // 20! = 2,432,902,008,176,640,000
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = determineFactorial(of: test.num)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌") \t\(test.num) -> \(result)\t\tExpected: \(test.expected)")
        }
    }
    
    func determineFactorial(of number: Int) -> Int {
        if number == 1 { return number }
        else if number == 0 { return 1 }
        
        return number * determineFactorial(of: number - 1)
    }
    
}