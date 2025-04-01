//
//  SushiBelt.swift
//  
//
//  Created by Justin Goulet on 3/29/25.
//

import Foundation

class SushiBelt: NSObject {
    
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
            (7, [1, 2, 1, 2, 1, 2, 1], 2, 2)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = getMaximumEatenDishCount(test.N, test.D, test.K)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \(isPassed)")
        }
    }
    
    func getMaximumEatenDishCount(_ N: Int, _ D: [Int], _ K: Int) -> Int {
        guard !D.isEmpty && N == D.count else { return 0 }
        var recentDishes = Set<Int>() // Stores last K unique dishes
        var recentQueue = [Int](repeating: 0, count: K) // Circular queue of size K
        var queueIndex = 0 // Tracks where to replace in the queue
        var totalEaten = 0
        
        for dish in D {
            if !recentDishes.contains(dish) {
                // Eat the dish
                totalEaten += 1
                recentDishes.insert(dish)
                
                // Remove the oldest dish from the queue if full
                let removedDish = recentQueue[queueIndex]
                recentDishes.remove(removedDish)
                
                // Add new dish to queue
                recentQueue[queueIndex] = dish
                queueIndex = (queueIndex + 1) % K // Move circularly
            }
        }
        return totalEaten
        //        guard !D.isEmpty && N == D.count else { return 0 }
        //
        //        //  Dish by indexes
        //        var dishesConsumed: [(id: Int, index: Int)] = []
        //        var currentCount: Int = 0
        //
        //        //  Nwo that we have a mapping of each dish and when it is eaten.
        //        for iter in 0..<N {
        //            let consumedHistory = dishesConsumed.suffix(K)
        //            let nextDish = D[iter]
        //
        //            if !consumedHistory.contains(where: { $0.id == nextDish }) {
        //                dishesConsumed.append((D[iter], iter))
        //            }
        //        }
        //        return dishesConsumed.count
    }
}
