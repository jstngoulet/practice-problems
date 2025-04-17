For every time I ask for a coding challenge prompt, I want the following format: 

1. Description of the problem
2. Walkthrough of the problem with a sample edge case
3. Test cases that can be inserted into the file, as shown below.

The file I want generated is going to be a swift file, with a class inheriting from type: Problem. 

Example class: 

```swift

/**
	Problem Description
*/

import Foundation

class ProblemName: Problem {

	//	This function is called on init() for 
	//	every type of Problem	
	override func performTests() {
		//	Perform test cases here
	}

	//	This should be unique to the problem
	//	as defined in the description. 
	//	This will run in the `performTests()` function above
	func problemTempateHere() {}

}

```
In addition, all test cases should be defined as a Struct or Tuple (as long as it is consistent) and be used in the performTests() function. Sample code is: 

typealias TestCase = (input: Int, expected: Bool)
let tests: [TestCase] = []

Then, for every TestCase, you should call the function the problem requests to determine if the problem passes the test or not, and print the result in a nice, formatted table. The input properties can vary, but there should always be an expected value as the result, for what the test should result in.

Each list of tests should have at least 10 cases to validate against my function. 

For Reference, `Problem.swift` is defined as: 

```swift
import Foundation

class Problem: NSObject {
    
    override init() {
        super.init() 
    }
    
    func performTests() { }
    
}
```

Easch program is added to a list in `main.swift` and triggered to run when enabled: 

```swift

typealias ProblemExec = (problem: Problem, enabled: Bool)

let problems: [ProblemExec] = [
    (AddDigitsUntilOne(), false),
    (AnagramInspector(), false),
    ...
]

problems
    .filter({ $0.enabled })
    .forEach({ $0.problem.performTests() })
```