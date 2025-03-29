//
//  DirectorOfPhotgraphy1.swift
//  
//
//  Created by Justin Goulet on 3/29/25.
//

import Foundation

class DirectorOfPhotgraphy1: NSObject {
    
    /**
     A photographer set consists of N cells in a row, numbered from 1 to N in order, and can be
     represented by a string C of length N. Each cell, i, is one of the following types: (indicated
     by Ci, the ith character of C):
     
     • If Ci = P, it is allowed to contain a photographer
     • If Ci = A, it is allowed to contain an actor
     • If Ci = B, it is allowed to contain a backdrop
     • If Ci = ., it is allowed to be empty
     
     A photograph consists of a photographer, an actor and a backdrop, such that each of them in placed in a valid cell,
     and such that the actor is between the photographer and the backdrop. Such a photograph is considered
     artistic if the distance between the photographer and the actor is between X and Y cells and the distance between the backdrop is
     also between X and Y cells (abs of the difference) The distance between cells i nd j is |i-j|
     
     Determine the number of different artistic photographs are considered different if they involove a
     different photographer cell, actor cell, and/or backdrop cell.
     
     Function defintion:
     ```swift
     func getArtisticPhotographCount(_ N: Int, _ C: String, _ X: Int, _ Y: Int) -> Int
     ```
     */
    
    func performTests() {
        typealias TestCase = (N: Int, C: String, X: Int, Y: Int, expected: Int)
        let tests: [TestCase] = [
            (5, "APABA", 1, 2, 1),
            (5, "APABA", 2, 3, 0),
            (8, ".PBAAP.B", 1, 3, 3)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = getArtisticPhotographCount(test.N, test.C, test.X, test.Y)
            let isPassed = result == test.expected
            print("Test \(iter + 1): s: \(test.C), count: \(result), expected: \(test.expected), passed: \(isPassed)")
        }
    }
    
    /**
     A:     Fail, Must be between P and B
     AP:    Fail. A must be between P and B
     APA:   Fail. A must be between P and B
     We have min count though, of 3, so we can shift since A fails as a start
     PAB:   Pass. A is between P and B
     Open window
     PABA:  Already counted. Do nothing
     end of string. Shift
     ABA:   Fail. A must be between P and B
     BA:    Fail. End of string. 3 are required
     
     // Now, for range
     A:     Fail, Must be between P and B
     AP:    Fail. A must be between P and B
     APA:   Fail. A must be between P and B
     We have min count though, of 3, so we can shift since A fails as a start
     PAB:   Fail. P and B must be between distance of X and Y ( 2, 3 ). It is only 1
     */
    
    //  Given string, C, we need to find cases where "A" (actor) is between the photographer "P" and the Backdrop "B"
    //  Can only be worth is at a maximum length pof X, the distacne between photographer
    func getArtisticPhotographCount(_ N: Int, _ C: String, _ X: Int, _ Y: Int) -> Int {
        // Must include PAB || BAP in some form. P.A.B is valid when 2 >= X-Y >= 1
        let minWindowSize: Int = 3
        let characterArray: [Character] = Array(C)
        
        //  Min length of 3
        guard N >= minWindowSize
        else { return 0 }
        
        /**
         Key:
         P :     Photographer
         A :     Actor
         B :     Backdrop
         . :     Empty
         */
        
        var photographCount: Int = 0
        
        for iter in 1..<N-1 where characterArray[iter] == "A" {
            //  A must be in middle, so we can actually start at 1 and end at N-1
            //  Now, for each A, count how many Ps and Bs are in the smaller windows
            let leftWindow = iter-Y...iter-X
            let rightWindow = iter+X...iter+Y
            
            if leftWindow.lowerBound < 0
                || rightWindow.upperBound > N-1
            { continue }
            
            var potentialMatches: [Character: Int] = [:]
            
            //  Loop through and find potential matches
            for j in leftWindow {
                potentialMatches[characterArray[j], default: 0] += 1
            }
            
            for j in rightWindow {
                potentialMatches[characterArray[j], default: 0] += 1
            }
            photographCount += min(potentialMatches["B"] ?? 0, potentialMatches["P"] ?? 0)
        }
        
        return photographCount
    }
    
    /**func getArtisticPhotographCount(_ N: Int, _ C: String, _ X: Int, _ Y: Int) -> Int {
     let chars = Array(C)
     var photographers: [Int] = []
     var actors: [Int] = []
     var backdrops: [Int] = []
     
     // Step 1: Store indices of 'P', 'A', and 'B'
     for (index, char) in chars.enumerated() {
     if char == "P" {
     photographers.append(index)
     } else if char == "A" {
     actors.append(index)
     } else if char == "B" {
     backdrops.append(index)
     }
     }
     
     var photographCount = 0
     
     // Step 2: For each actor, count the valid (P, A, B) and (B, A, P) triplets
     for a in actors {
     // Count P's to the left of actor 'a' and B's to the right of 'a'
     let leftPhotographers = photographers.filter { a - $0 >= X && a - $0 <= Y }.count
     let rightBackdrops = backdrops.filter { $0 - a >= X && $0 - a <= Y }.count
     photographCount += leftPhotographers * rightBackdrops
     
     // Count B's to the left of actor 'a' and P's to the right of 'a'
     let leftBackdrops = backdrops.filter { a - $0 >= X && a - $0 <= Y }.count
     let rightPhotographers = photographers.filter { $0 - a >= X && $0 - a <= Y }.count
     photographCount += leftBackdrops * rightPhotographers
     }
     
     return photographCount
     }*/
}
