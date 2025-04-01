//
//  Hops.swift
//  
//
//  Created by Justin Goulet on 3/31/25.
//

import Foundation

class Hops: NSObject {
    /**
     Hops
     
     Level 2
     
     A family of frogs in a pond are traveling towards dry land to hibernate. They hope to do so by hopping across a
     trail of N lily pads, numbered from 1 1 to N in order. There are F frogs, numbered from 1 1 to F. Frog i is
     currently perched atop lily pad P_i. No two frogs are currently on the same lily pad. Lily pad N is right next
     to the shore, and none of the frogs are initially on lily pad N. Each second, one frog may hop along the trail
     towards lily pad N. When a frog hops, it moves to the nearest lily pad after its current lily pad which is not c
     urrently occupied by another frog (hopping over any other frogs on intermediate lily pads along the way).
     
     If this causes it to reach lily pad N, it will immediately exit onto the shore. Multiple frogs may not
     simultaneously hop during the same second. Assuming the frogs work together optimally when deciding which
     frog should hop during each second, determine the minimum number of seconds required for all F of them to reach the shore.
     
     Constraints
     
     2≤N≤10 1≤F≤500,000 1≤P_i ≤N−1
     
     Sample test case #1
     
     N = 3 F = 1 P = [1] Expected Return Value = 2
     
     Sample test case #2
     
     N = 6 F = 3 P = [5, 2, 4] Expected Return Value = 4
     
     ---
     */
     
    func performTests() {
        typealias TestCase = (lilyPads: Int, frogCount: Int, positions: [Int], expected: Int)
        let tests: [TestCase] = [
            (3, 1, [1], 2),
            (6, 3, [5, 2, 4], 4),
            (15, 8, [3, 4, 6, 7, 9, 11, 2, 14], 13)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = getSecondsRequired(test.0, test.1, test.2)
            let isPassed = result == test.expected
            print("Test \(iter + 1): Passed: \(isPassed) - Result: \(result), Expected: \(test.expected)")
        }
    }
    /**
     Turns out, this one was easy.
     We know that each frog is already assigned a lily pad.
     We only really need to know the number of lily pads - the frogs position in last place (min)
     The seconds required is just the time it takes for the last place frog to get accross the line
     
     Steps to solve this:
     1. sort the array so that we can clearly see what the positions are. This can be optimized later
     2. Create a sample set to use:
        [3, 4, 6, 7, 9, 11, 2, 14], N = 15, F = 8
     3. Sort sample set
        [2, 3, 4, 6, 7, 9, 11, 14]
     4. Draw out the positions
        [ - , x , x , x , - , x , x , - , x , - , x , - , - , x , - ]
        Note: - = empty, x = taken
     5. Note that each frog needs at least one second to jump, so our solution can start at "F"
            Current Equation: `Result = F ...`
     6. Now that we have the frogs accounted for, we should consider the lily pads.
        Each lily pad should take at least 1 second to move accross, Let's pick a frog and put him on the board
        [ - , x , x , x , - , x , x , - , x , - , x , - , - , x , - ]
        [             F                                             ]
        This frog can move once forward before another frog needs to move, so we need to count the number of
        empty spaces to order to figure out how many frogs can actually move at any second
        We need to add: Lily Pad Count - Number of Frogs
        Note: The last lilly pad won't count as they are just hopping to shore:
            Current Equation: `Result = F + (N - F - 1) ...`
     7. Now that we have the total number of steps, this is assuming that there is even the possibility
        every single time that a frog is on the first pad. Since this is an assumption, we should
        actually consider the frog in the last place (remember zero index, too)
            Current Equation: `Result = F + (N - F - 1) - (P.min() - 1)`
     8. Now, normalize the quation
            Current Equation: `Result = N - P.min()
        Note: The "F"s cancel out and the 1s cancel out
     9. Convert to swift
            `return N - P.min()`
     10. min() is optional, so we should add some protections
            `return N - (P.min() ?? 0)
            Note: This allows the array to return the min element (which could be the first
                    And if the array is empty, return 0. More safety could be added, however
                    to check input validations
        
     Additonal Reasoning below
     
     */
    func getSecondsRequired(_ N: Int, _ F: Int, _ P: [Int]) -> Int {
        return N - (P.min() ?? 0)
    }
    
     
     /**
     Description:
     Turns out you can solve this with a simple one-liner (though it takes a little while to explain why). Ultimately the formula is deceptively simple: N - min(P). Working backwards from that, though, the original verbose formula is: F + (N - F - 1) - (min(P) - 1).
     
     The first part - F + - is because once you get all the frogs lined up at the end, each one takes one second to hop off.
     
     The second part - N - F - 1 - answers the question of "how many empty lily pads are there?" The best solution is that every second, a frog is hopping to an empty pad, so we need to find out how many empty pads will be hopped to at the end. That works out to the total number of pads (N), less the number of frogs occupying pads (F), less 1 (the final pad which is never really occupied anyway).
     
     The final part - min(P) - 1 makes more sense if you look at this in terms of an array. For example, you might have N = 7, F = 2, and P = [3, 5]. If you were to draw it out, your pond would look like this: [ . . A . B . . ] N-F-1 in this case is 4, telling us that there are four empty lily pads (excluding the final): [1, 2, 4, 6]. But no one's hopping backwards, so we can drop the first two empty pads by finding the minimum of P and subtracting 1 (in this example, 3 - 1 = 2 so we drop the first two pads, and our list of empty and eligible pads drops to [4, 6]).
     
     Putting it all together, it'll take two seconds to collapse the frogs to the right of the list (frog A moves from 3 to 4 in the 1st second, and then hops over frog B in the 2nd second, leaving you with [. . . . B A .], and then it takes two more seconds for both to jump to shore (frog B jumps over A, then frog A goes to shore). But don't get bogged down in which frog moves where because ultimately (and weirdly) it doesn't really matter how many frogs there are, only how many pads there are and where the farthest frog from shore is located. The actual math factors out the number of frogs from the equation, which feels odd to me...but on further reflection, if you don't think of which specific frog is on which specific pad and how the frog can jump, and look at it in terms of how long it takes to make the leftmost occupied lily pad to be the last one, it makes more sense (ie. don't think of it in terms of [. . A . B . ] but in terms of [. . x . x .] => [. . . x x .] => [. . . . x x] => [. . . . . x] => [. . . . . .])
     */
}
