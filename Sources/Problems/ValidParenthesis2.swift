/**
### **Problem: Valid Parentheses**

#### **Problem Statement:**

Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['`, and `']'`, determine if the input string is **valid**.

A string is valid if:
1. Open brackets are closed by the same type of brackets.
2. Open brackets are closed in the correct order.
3. Every closing bracket has a corresponding opening bracket of the same type.

---

**Function Signature:**
```swift
func isValid(_ s: String) -> Bool
```
*/

import Foundation

class ValidParentheses2: Problem {
    
    /**
     Determines if the string of brackets is valid.
     
     - Parameter s: A string containing only '(', ')', '{', '}', '[' and ']'.
     - Returns: A boolean indicating whether the string is valid.
     */
    func isValid(_ s: String) -> Bool {
        /**
            Walkthrough:
            In order to acheieve this, we need to consider both the count and the
            order in which the parenthesis are shown. We can do this by using a stack
        
            For the example, let's just walk through `()[]{}`
            1. Open parenthesis. the next one should be matching
            2. The next one is matching. Move on
            3. Open square bracket. The next one should be mathing
            4. It is. Move on
            5. Open curly bracket. The next one should be matching.
            6. It is. Move on
        
            -- Okay .. no odd ones here. --
        
            let's use a more advanced one: `{[()]}`
            1. Open Curly to start next one should be matching or open
            2. It is an open square. Keep note of open
            3. Next one is an open paren. Keep note.
            4. Next one is closed. we should remove the previous and determine if it is matching
                It is. Move on (fail if not)
            5. Next one is closed square. Should remove top of stack and determine if it is matching
                It is. Move on (fail if not)
            6. Next one is closed curly. Should remove top of stack and determine if it is matching
                It is. Move on. 
                
            At the end of the loop of chars, we need to check to see if the stack is empty. 
            Only if the stack is empty is it valid at this point.
            
            What do we need: 
            - Reference to matching front and backs
            - Stack to keep track of open
            - Loop to go through string array of parentheses
        */
        if s.count % 2 != 0 { return false }    //  Cannot be valid on odd numbers
        let parenReference: [Character: Character] = [
            "]": "[",   //  We are using backwards as we want to see if the opening one was the previous
            "}": "{",
            ")": "("    
        ]
        var currentStack: [Character] = []
        
        for char in s {
            if let correspondingOpeningBracket = parenReference[char] {
                
                //  Check the last item and compare. If not the same, 
                //  Fails. Else, just remove it from stack
                guard let last = currentStack.last, 
                last == correspondingOpeningBracket
                     else { return false }
                
                currentStack.removeLast()
            } else {
                //  If the item is an opening bracket, we just want to append to our array
                currentStack.append(char)
            }
        }
        
        return currentStack.isEmpty
    }

    override func performTests() {
        print("Running tests for: ValidParentheses2\n")
        
        struct TestCase {
            let input: String
            let expected: Bool
        }
        
        let tests: [TestCase] = [
            // Test 1: Basic valid pair
            TestCase(input: "()", expected: true),
            // Test 2: Multiple valid types
            TestCase(input: "()[]{}", expected: true),
            // Test 3: Nested valid brackets
            TestCase(input: "{[()]}", expected: true),
            // Test 4: Mismatched types
            TestCase(input: "(]", expected: false),
            // Test 5: Improper nesting
            TestCase(input: "([)]", expected: false),
            // Test 6: Only an opening brace
            TestCase(input: "{", expected: false),
            // Test 7: Empty string (valid)
            TestCase(input: "", expected: true),
            // Test 8: All closers
            TestCase(input: "]]", expected: false),
            // Test 9: All openers
            TestCase(input: "[[", expected: false),
            // Test 10: Unmatched opener at end
            TestCase(input: "{[](", expected: false),
        ]
        
        print("| Test # | Input       | Expected | Actual   | Pass |")
        print("|--------|-------------|----------|----------|------|")
        
        for (i, test) in tests.enumerated() {
            let actual = isValid(test.input)
            let paddedInput = test.input.padding(toLength: 11, withPad: " ", startingAt: 0)
            let paddedExpected = "\(test.expected)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let paddedActual = "\(actual)".padding(toLength: 8, withPad: " ", startingAt: 0)
            let result = actual == test.expected ? "✅" : "❌"
            print("| \(String(format: "%-6d", i + 1)) | \(paddedInput) | \(paddedExpected) | \(paddedActual) | \(result) |")
        }
    }
}