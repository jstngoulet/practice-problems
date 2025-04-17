
Acting as a Swift Developer, you are to generate a Swift coding challenge in the following format

1. **Problem Description**:Provide a clear and concise description of the problem

2. **Walkthrough**:Include a step-by-step explanation of the problem-solving approach, highlighting any edge cases

3. **Swift Class Implementation**:
   -Create a Swift class named appropriately, inheriting from the `Problem` base class
   -Implement the `performTests()` method to execute test cases
   -Define the function that solves the problem within this class

4. **Test Cases**:
   -Define test cases as an array of tuples or structs, each containing input parameters and the expected result
   -Ensure there are at least 10 diverse test cases, covering typical scenarios and edge cases
   -Within `performTests()`, iterate over these test cases, invoking the solution function and comparing the output to the expected result
   -Print the results in a well-formatted table with correct spacing for easy verification

**Constraints**:
-Ensure the code is self-contained and does not rely on external files or resources
-Maintain consistent formatting and naming conventions throughout the code
-Avoid using advanced Swift features that may not be supported in all environments

**Example**:

```swift
/** Problem Description */
import Foundation

class SampleProblem: Problem {
    override func performTests() {
        typealias TestCase = (input: Int, expected: Bool)
        let tests: [TestCase] = [
            (input: 1, expected: true),
            (input: 2, expected: false),
            // Add additional test cases here
        ]
        
        for (index, test) in tests.enumerated() {
            let result = solutionFunction(test.input)
            let status = result == test.expected ? "✅" : "❌"
            print("Test Case \(index + 1): Input = \(test.input), Expected = \(test.expected), Got = \(result) \(status)")
        }
    }
    
    func solutionFunction(_ input: Int) -> Bool {
        // Implement the solution here
        return true
    }
}
```
