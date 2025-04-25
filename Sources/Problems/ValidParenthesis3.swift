import Foundation

class ValidParentheses3: Problem {
    /**
     Determines if the input string of brackets is valid.
    
     - Parameter s: A string containing just the characters '(', ')', '{', '}', '[' and ']'.
     - Returns: True if the input string is valid, false otherwise.
     */
    func isValid(_ s: String) -> Bool {
        if s.count % 2 != 0 { return false }
        let mapping: [Character: Character] = [
            "]": "[",
            "}": "{",
            ")": "("
        ]
        var stack: [Character] = []
        
        for char in s {
            //  If char is a closing one, must match the previous on an opening one
            if let opening = mapping[char] {
                guard let lastItem = stack.last, lastItem == opening
                else { return false }
                stack.removeLast()
            } else { 
                stack.append(char)
            }
        }
        
        return stack.isEmpty
    }

    override func performTests() {
        print("=== ValidParentheses Tests ===")
        let header = "| #  | Input           | Exp | Act | Pass |"
        let separator = String(repeating: "-", count: header.count)

        typealias TestCase = (input: String, expected: Bool)
        let tests: [TestCase] = [
            // Empty string is valid
            ("", true),
            // Single pair
            ("()", true),
            // Multiple nested pairs
            ("({[]})", true),
            // Mismatched
            ("(]", false),
            // Unclosed opening
            ("([", false),
            // Incorrect nesting
            ("([)]", false),
            // Proper sequence
            ("{[]}", true),
            // Extra closing bracket
            ("(()))", false),
            // Single open bracket
            ("(", false),
            // Complex valid case
            ("({[()]})", true),
        ]

        print(separator)
        print(header)
        print(separator)

        for (i, test) in tests.enumerated() {
            let result = isValid(test.input)
            let passed = result == test.expected ? "✅" : "❌"

            let idx = "\(i + 1)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let inputStr = "\(test.input)".padding(toLength: 15, withPad: " ", startingAt: 0)
            let expected = "\(test.expected)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let actual = "\(result)".padding(toLength: 3, withPad: " ", startingAt: 0)
            let passStr = passed.padding(toLength: 4, withPad: " ", startingAt: 0)

            print("| \(idx) | \(inputStr) | \(expected) | \(actual) | \(passStr) |")
        }

        print(separator)
    }
}
