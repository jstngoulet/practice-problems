/**

*/
import Foundation

class DeflatedDisks: Problem {
    
    override func performTests() {
        typealias TestCase = (inputCount: Int, input: [Int], expected: Int) 
        let tests: [TestCase] = [
            (5, [2, 5, 3, 6, 5], 3),
            (3, [100, 100, 100], 2),
            (4, [6, 5, 4, 3], -1),
            (5, [4, 5, 3, 3, 1], -1),
            (3, [1, 1, 1], -1), 
            (5, [5, 4, 3, 2, 1], -1),
            (5, [10, 10, 10, 10, 10], 4)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = minimumDeflationsToStabilize(test.0, test.1)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\tE: \(test.expected)\tR: \(result)")
        }
    }
    
    func minimumDeflationsToStabilize(_ N: Int, _ R: [Int]) -> Int {
        var deflations = 0
        var nextDiscRadius = R[N - 1]
        var deflatedArray: [Int] = [nextDiscRadius]

        for i in stride(from: N - 2, through: 0, by: -1) {
            var current = R[i]

            if current >= nextDiscRadius {
                let newRadius = nextDiscRadius - 1
                if newRadius < 1 {
                    return -1
                }
                deflations += 1
                current = newRadius
            }
            
            nextDiscRadius = current
            deflatedArray.insert(current, at: 0)
        }       

        return deflations   
    }
    
}