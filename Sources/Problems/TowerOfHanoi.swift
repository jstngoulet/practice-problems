import Foundation

class TowerOfHanoi: Problem {
    
    /**
    Tower of Hanoi Problem
    The Tower of Hanoi is a classic problem in computer science and mathematics, 
    often used to teach recursion and problem-solving strategies. It involves moving 
    a set of disks from one rod to another, following certain rules.

    Problem Description:
    The Tower of Hanoi consists of:

    Three rods:
    Rod A (the source rod)
    Rod B (an auxiliary rod)
    Rod C (the destination rod)
    N disks: Each disk has a different size, and they are initially stacked in 
    decreasing size on Rod A, with the largest disk at the bottom and the smallest at the top.
    Objective:
    Move all the disks from Rod A to Rod C, subject to the following rules:

    Only one disk can be moved at a time.
    A disk can only be moved to the top of another rod if it is smaller than the disk 
    currently on that rod (i.e., no disk may be placed on top of a smaller disk).
    Disks can only be moved one at a time from one rod to another.
    Solution Strategy:
    The Tower of Hanoi problem is generally solved recursively. The idea is to break down the 
    problem into smaller subproblems:

    Move N-1 disks from the source rod to the auxiliary rod, using the destination rod as an auxiliary.
    Move the Nth disk (the largest disk) from the source rod to the destination rod.
    Move the N-1 disks from the auxiliary rod to the destination rod, using the source rod as an auxiliary.
    Recursive Algorithm:
    For a given number of disks n:

    Move n-1 disks from the source rod to the auxiliary rod.
    Move the nth disk (the largest disk) directly to the destination rod.
    Move the n-1 disks from the auxiliary rod to the destination rod.
    Base Case:
    When there is only one disk, the solution is trivial:

    Simply move the disk from the source rod to the destination rod.
    Example (N = 3):
    Assume we have 3 disks (labeled 1, 2, and 3, where 1 is the smallest disk and 3 is the largest):

    Initial configuration:
    Rod A: [3, 2, 1]
    Rod B: []
    Rod C: []
    Step 1: Move 2 disks from Rod A to Rod B using Rod C as auxiliary.
    Rod A: [3]
    Rod B: [2, 1]
    Rod C: []
    Step 2: Move disk 3 from Rod A to Rod C.
    Rod A: []
    Rod B: [2, 1]
    Rod C: [3]
    Step 3: Move 2 disks from Rod B to Rod C using Rod A as auxiliary.
    Rod A: []
    Rod B: []
    Rod C: [3, 2, 1]
    Final configuration:

    Rod A: []
    Rod B: []
    Rod C: [3, 2, 1] (All disks have been moved to Rod C)
    Time Complexity:
    The time complexity of the Tower of Hanoi problem is O(2^n), where n is the number of disks. 
    This is because for each disk, the solution involves solving two smaller subproblems 
    (moving n-1 disks). Thus, the total number of moves required to solve the problem is 
    exponential in the number of disks.

    Space Complexity:
    The space complexity is O(n) due to the recursive calls on the call stack.
    
    
    4, 3, 2, 1          _               _ 
    4, 3, 2             1               _ 
    4, 3                1               2
    4, 3                _               2, 1
    4                   3,              2, 1
    4, 1                3,              2
    
    
    
    */
    override func performTests() {
        typealias TestCase = (num: Int, expected: Int) 
        let tests: [TestCase] = [
                (1, 1),
                (2, 3),
                (3, 7),
                (4, 15),
                (5, 31),
                (6, 63),
                (7, 127),
                (8, 255),
                (9, 511),
                (10, 1023),
                (11, 2047),
                (12, 4095)
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = numberOfMovesInTower(of: test.num)
            let isPassed = result == test.expected
            print("Test \(iter + 1): \t\(isPassed ? "✅" : "❌")\t\(test.num) -> \(result)")
        }
    }
    
    func numberOfMovesInTower(of num: Int) -> Int {
        return towerOfHanoi(n: num, from: "A", to: "C", using: "B")
    }
    
    private func towerOfHanoi(n: Int, from source: String, to destination: String, using auxiliary: String) -> Int {
        
        if n == 1 {  return 1 } //Base Case
        
        // Total moves is the sum of the moves
        return towerOfHanoi(n: n - 1, from: source, to: auxiliary, using: destination) 
            + towerOfHanoi(n: n - 1, from: auxiliary, to: destination, using: source) 
            + 1
    }
    
}