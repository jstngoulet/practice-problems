import Foundation
import PlaygroundSupport

class DriverApplication: NSObject {
    override init() { super.init(); performTests() }
    
    /**
     Kaitenzushi
     
     There are N dishes in a row on a serving belt, with the ith dish being of type Di
     
     You're very hungry, but youd also like to keep things interesting. The N dishes will
     arrive in front of you, one after the other, and for each one, you'll eat it as long as
     it is not hte same type of any of the previous K dishes you've eaten. You eat very
     fast, so you can consume  dish before hte next one gets to you. Any dishes
     you choose not to eat will pass as they will be eaten by others.
     
     DEtermine how many dishes you will end up eating
     
     */
    func performTests() {
        typealias TestCase = (N: Int, D: [Int], K: Int, expected: Int)
        let tests: [TestCase] = [
            (6, [1, 2, 3, 3, 2, 1], 1, 5),
            (6, [1, 2, 3, 3, 2, 1], 2, 4),
//            (7, [1, 2, 1, 2, 1, 2, 1], 2, 2)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = getMaximumEatenDishCount(test.N, test.D, test.K)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \(isPassed)")
        }
    }
    
    func getMaximumEatenDishCount(_ N: Int, _ D: [Int], _ K: Int) -> Int {
        guard !D.isEmpty && N == D.count else { return 0 }
        
        //  Dish by indexes
        var dishesConsumed: [(id: Int, index: Int)] = []
        
        //  Nwo that we have a mapping of each dish and when it is eaten.
        for iter in 0..<N {
            let consumedHistory = dishesConsumed[max(0, iter-K)...]
            let nextDish = D[iter]
            
            print("Consumed Array: \(dishesConsumed) :: \(consumedHistory)")
            
            if nextDish == consumedHistory.last?.id {
                continue
            }
            
            if iter < K {
                print("Adding by default at: \(iter)")
                dishesConsumed.append((D[iter], iter))
            } else if let lastIndex = consumedHistory.lastIndex(where: { $0.id == nextDish }) {
                print("Recent eat:\(lastIndex)")
            }
            
            print("Count: \(dishesConsumed.count)")
           
        }
        print("Consumed: \(dishesConsumed)")
        return dishesConsumed.count
        
//        guard !D.isEmpty || N != D.count else { return 0 }
//        
//        var dishesEaten: Int = 1
//        var lastDishEaten: Int = D[0]
//        var dishesPassed: Int = 0
//        
//        for iter in 1..<N {
//            let nextDish = D[iter]
//            let previouslyEated = D[max(0, iter-K-dishesPassed)..<iter]
//            
//            if !previouslyEated.contains(nextDish) && lastDishEaten != nextDish {
//                lastDishEaten = nextDish
//                dishesEaten += 1
//                dishesPassed = 0
//            } else {
//                dishesPassed += 1
//            }
//            
//        }
//        
//        return dishesEaten
    }
}

DriverApplication()
PlaygroundPage.current.needsIndefiniteExecution = true
