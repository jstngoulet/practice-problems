/**
 Adds two decimal strings and returns the resulting sum, preserving decimal precision.
 This class includes a method to solve the problem and a test runner to validate correctness.

 Use this class as part of a practice problem suite.
 */
final class AddDecimalStrings: Problem {
    /**
     Adds two decimal strings and returns their sum, digit-by-digit.

     - Parameters:
        - a: A non-negative decimal string (may contain a dot).
        - b: A non-negative decimal string (may contain a dot).
     - Returns: The sum of `a` and `b`, preserving fractional precision.
     */
    func addDecimals(_ a: String, _ b: String) -> String {
        
        //  To do this, we will have 2 character arrays. 
        //  We will need to convert the numbers in the following method: 
        /**
            "2.3" + "4.67" = "xx.xx"
            
            We can do this by addig 0s so that the decimal lines up and each
            array is the same length: 
            
            ["2", ".", "3", "0"]
            ["4", ".", "6", "7"]
            
            Steps: 
            1. Determine how long each string is on each side of decimal
            let (left1, right1) = a.split(by: ".")
            let (left2, right2) = b.split(by: ".")
            
            2. Now since we have the arrays (left and right), make sure they are the same size
            let leftDiff = abs(left1 - left2)
            let rightDiff = abs(right2 - left1)
            
            3. Add the correct amount of 0s to each side of each array
            (Top Left, Bottom Left, Top Right, Bottom Right)
            let tl = Array(repeating: "0", count: left1.count > left2.count ? leftDiff : 0)
            let bl = Array(repeating: "0", count: left2.count > left1.count ? leftDiff : 0)
            let tr = Array(repeating: "0", count: right1.count > right2.count ? leftDiff : 0)
            let br = Array(repeating: "0", count: right2.count > right1.count ? leftDiff : 0)
            
            4. Now, combine them
            let top = tl + left1 + ["."] + right1 + tr
            let bottom = bl + left2 + ["."] + right2 + br
            
            5. Now, for each number, starting at the back, convert to int and
            add up the numbers. If over 10, should carry that tens value over to 
            next set
            
                ["2", ".", "3", "0"]
            +   ["4", ".", "6", "7"]
            ------------------------
                                 7  + 0
                            9       + 0
                        .   9       + 0
                    6   .           + 0    
        */
        let topParts: [String] = a.components(separatedBy: ".")
        let bottomParts: [String] = b.components(separatedBy: ".")
        
        let (topLeft, topRight) = (topParts[0], topParts.count > 1 ? topParts[1] : "0")
        let (bottomLeft, bottomRight) = (bottomParts[0], bottomParts.count > 1 ? bottomParts[1] : "0")
        
        //  Store the counts
        let tlCount = topLeft.count
        let trCount = topRight.count
        let blCount = bottomLeft.count
        let brCount = bottomRight.count
        
        //  Build the "0" arrays 
        let tl: [Character] = Array(repeating: "0", count: blCount > tlCount ? blCount - tlCount : 0)
        let tr: [Character] = Array(repeating: "0", count: brCount > trCount ? brCount - trCount : 0)
        let bl: [Character] = Array(repeating: "0", count: tlCount > blCount ? tlCount - blCount : 0)
        let br: [Character] = Array(repeating: "0", count: trCount > brCount ? trCount - brCount : 0)
        
        //  Combine so we have everything lined up
        let top: [Character]       = tl +  Array(topLeft)      + ["."]     + Array(topRight)       + tr
        let bottom: [Character]    = bl +  Array(bottomLeft)   + ["."]     + Array(bottomRight)    + br
        
        //  Now, create a store for the remainder
        var currentRemainder: Int = 0
        let digitCount: Int = top.count
        var sumArray: [Character] = []
        
        for iter in 0..<digitCount {
            let reverseIter = digitCount - iter - 1
            if top[reverseIter] == "." {
                sumArray.insert(".", at: 0)
                continue
            }
            
            if let firstNumber: Int = Int(String(top[reverseIter]))
                , let secondNumber: Int = Int(String(bottom[reverseIter])) {
                let sum = firstNumber + secondNumber + currentRemainder
                let tens = sum / 10
                let ones = sum % 10
                let onesString = String(ones)
                
                if ones < 10, let first = onesString.first {
                    sumArray.insert(first, at: 0)
                }
                
                currentRemainder = tens
            } 
        }
        
        if currentRemainder > 0 {
            sumArray.insert(Character("\(currentRemainder)"), at: 0)
        }
        
        return String(sumArray)
    }

    override func performTests() {
        print("Testing AddDecimalStrings\n")

        struct TestCase {
            let a: String
            let b: String
            let expected: String
        }

        let tests: [TestCase] = [
            // ✅ Whole + fractional
            TestCase(a: "123.45", b: "76.55", expected: "200.00"),

            // ✅ Simple decimal add
            TestCase(a: "0.1", b: "0.02", expected: "0.12"),

            // ✅ Carry across decimal to integer part
            TestCase(a: "999.999", b: "0.001", expected: "1000.000"),

            // ✅ One whole, one decimal
            TestCase(a: "1", b: "999.9", expected: "1000.9"),

            // ✅ No decimal
            TestCase(a: "123", b: "456", expected: "579.0"),

            // ✅ All zeros
            TestCase(a: "0.000", b: "0.000", expected: "0.000"),

            // ✅ Uneven fractional lengths
            TestCase(a: "1.5", b: "2.25", expected: "3.75"),
            TestCase(a: "1.005", b: "2.5", expected: "3.505"),
        ]

        let header = "| Test # | Input (a, b)             | Expected         | Actual           | Pass  |"
        let divider = String(repeating: "-", count: header.count)
        print(header)
        print(divider)

        for (index, test) in tests.enumerated() {
            let result = addDecimals(test.a, test.b)
            let input = "(\(test.a), \(test.b))".padding(toLength: 25, withPad: " ", startingAt: 0)
            let expectedStr = test.expected.padding(toLength: 17, withPad: " ", startingAt: 0)
            let resultStr = result.padding(toLength: 17, withPad: " ", startingAt: 0)
            let passStr = (result == test.expected ? "✅" : "❌").padding(toLength: 5, withPad: " ", startingAt: 0)

            print("| \(String(index + 1).padding(toLength: 7, withPad: " ", startingAt: 0))" +
                  "| \(input)" +
                  "| \(expectedStr)" +
                  "| \(resultStr)" +
                  "| \(passStr)|")
        }
    }
}
