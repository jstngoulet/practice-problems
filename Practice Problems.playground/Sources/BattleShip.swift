//
//  BattleShip.swift
//  
//
//  Created by Justin Goulet on 3/28/25.
//

class BattleShip {
    
    /**
     You're playing Battleship on a grid of cells with R rows and C columns. There are 0 or more battleships on the grid, each occupying a single distinct cell. The cell in the ith row from the top and jth column from the left either contains a battleship (
     G
     i
     ,
     j
     =
     1
     G
     i,j
     ​    
     =1) or doesn't (
     G
     i
     ,
     j
     =
     0
     G
     i,j
     ​    
     =0).
     You're going to fire a single shot at a random cell in the grid. You'll choose this cell uniformly at random from the
     R
     ∗
     C
     R∗C possible cells. You're interested in the probability that the cell hit by your shot contains a battleship.
     Your task is to implement the function getHitProbability(R, C, G) which returns this probability.
     Note: Your return value must have an absolute or relative error of at most 10^-6 to be considered correct.
     */
    func performTests() {
        typealias TestCase = (rows: Int, columns: Int, grid: [[Int]], result: Float)
        
        var tests: [TestCase] = [
            (
                2, 3,
                [
                    [0, 0, 1],
                    [1, 0, 1]
                ], 0.5
            ),
            (
                2, 2,
                [
                    [1, 1],
                    [1, 1]
                ], 1.0
            )
        ]
        
        for test in tests {
            let result = getHitProbability(test.rows, test.columns, test.grid)
            let isPassed = test.result == result
            print("Test: \(isPassed ? "Passed" : "Failed")")
        }
    }
    
    func getHitProbability(_ R: Int, _ C: Int, _ G: [[Int]]) -> Float {
        // Write your code here
        let gridSize = R * C
        var battleShipCount = 0
        
        for i in G {
            for n in i {
                battleShipCount += n
            }
        }
        
        //  Now, grid size over battleship count is prob
        return Float(battleShipCount) / Float(gridSize)
    }
}
