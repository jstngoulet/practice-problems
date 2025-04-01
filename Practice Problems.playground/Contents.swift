import Foundation
import PlaygroundSupport

class DriverApplication: NSObject {
}
            
            

DriverApplication()
PlaygroundPage.current.needsIndefiniteExecution = true

/**
 
 
 
 
 func performTests() {
 let result = getMinProblemCount(6, [1, 2, 3, 4, 5, 6])
 print("Result: \(result)")
 }
 
 func getMinProblemCount(_ N: Int, _ S: [Int]) -> Int {
 
 var possibleProblems: Int = 0
 let sortedScores: [Int] = S.sorted()
 let maxScore: Int = sortedScores[N-1] & 1 == 0 ? sortedScores[N-1] : sortedScores[N-1] + 1
 let lowestMaxScore: Int = maxScore / 2
 
 
 return possibleProblems
 }
 
 func getUniformIntegerCountInInterval(_ A: Int, _ B: Int) -> Int {
 
 var tensDigit = A % 10 // For 75, will be 2
 var currentRepeatingDigit: Int = Int(A / 10) //  will be 7
 let startingPoint: Int = currentRepeatingDigit * (10 * tensDigit)//  Wil be 70
 
 let startingNumbersArray: [Int] = Array(repeating: currentRepeatingDigit, count: tensDigit)
 let startingAsString: String = startingNumbersArray.map({ String($0) }).joined()
 var countingNumber: Int = Int(startingAsString) ?? 0
 
 let baseAdditor: [Int] = Array(repeating: 1, count: tensDigit)
 var currentAdditorString: String = baseAdditor.map({ String($0) }).joined()
 var currentCount: Int = countingNumber > A ? 0 : 1
 
 while countingNumber < B {
 let newAdditor: Int = Int(currentAdditorString) ?? 0 //  Should be 11 to start
 var newCountingNumber = countingNumber + newAdditor
 let newTens: Int = newCountingNumber % 10
 
 if newTens != tensDigit {
 currentAdditorString += "1"
 tensDigit = newTens
 newCountingNumber += 1  //  Add one as the tens changed
 }
 countingNumber = newCountingNumber
 currentCount += 1
 }
 
 return currentCount
 }
 */

/**
 A positive integer is considered uniform if all of its digits are equal. For example,
 222
 222 is uniform, while
 223
 223 is not.
 
 for num in A...B {
 let str = String(num)
 var isUniform: Bool = true
 var firstNumber = str.first
 
 for char in str {
 if char != firstNumber {
 isUniform = false
 break
 }
 }
 
 count += isUniform ? 1 : 0
 
 }
 */
