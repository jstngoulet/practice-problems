import Foundation


class DetermineIfPalindrome: Problem {
    
    override func performTests() {
        typealias TestCase = (word: String, expected: Bool)
        
        let tests: [TestCase] = [
            ("dog", false),
            ("mom", true), 
            ("dad", true), 
            ("Race Car", true)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = test.word.isPalindrome
            let isPassed = test.expected == result
            print("Test \(iter + 1): \t\(test.word) \t\(isPassed ? "PASSED" : "FAILED")")
        }
    }
    
}

extension String {
    var isPalindrome: Bool {
        determineIfPalindrome(str: self)
    }
    
    private func determineIfPalindrome(str: String) -> Bool {
        let cleanString = str.lowercased().replacingOccurrences(of: " ", with: "")
        return cleanString == String(Array(cleanString).reversed())
    }
}