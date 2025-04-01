//
//  BFSGrid.swift
//  
//
//  Created by Justin Goulet on 3/31/25.
//

import Foundation

class BFSGrid: NSObject {
    
    func performTests() {
        typealias TestCase = (rows: Int, columns: Int, grid: [[String]], expected: Int)
        let tests: [TestCase] = [
            (3, 3,
             [
                [".", "E", "."],
                [".", "#", "E"],
                [".", "S", "#"]
             ],
             4
            ),
            (
                4, 5,
                [
                    ["S", ".", "a", "#", "."],
                    [".", "#", ".", ".", "."],
                    ["#", ".", "#", "a", "."],
                    [".", ".", ".", "#", "E"]
                ],
                4
            ),
            (
                4, 4,
                [
                    ["S", "a", ".", "E"],
                    ["#", "#", "a", "#"],
                    [".", ".", ".", "#"],
                    ["E", ".", "#", "."]
                ],
                3
            )
        ]
        
        for (iter, test) in tests.enumerated() {
            let result = getSecondsRequired(test.rows, test.columns, test.grid)
            let isPassed = result == test.expected
            print("Test \(iter + 1): Passed: \(isPassed) Steps: \(result) (Expected: \(test.expected))")
        }
        
    }
    
    //  Build the map of coordinates
    struct Coordinate: Hashable {
        let row: Int
        let col: Int
        
        init(_ x: Int, _ y: Int) {
            self.row = x
            self.col = y
        }
    }
    
    func getSecondsRequired(_ R: Int, _ C: Int, _ G: [[String]]) -> Int {
        var coordinateMap: [String: [Coordinate]] = [:]
        var portalsMap: [String: [Coordinate]] = [:]
        
        var start: Coordinate?
        var endPositions: Set<Coordinate> = []
        
        // **Step 1: Build Coordinate and Portal Maps**
        for (row, line) in G.enumerated() {
            for (col, char) in line.enumerated() {
                let coord = Coordinate(row, col)
                coordinateMap[char, default: []].append(coord)
                
                if char == "S" { start = coord }
                if char == "E" { endPositions.insert(coord) }
                
                // Store portals (lowercase letters)
                if char != "#" && char != "S" && char != "E" && char == char.lowercased() {
                    portalsMap[char, default: []].append(coord)
                }
            }
        }
        
        // **Step 2: Ensure Start and End Exist**
        guard let start = start, !endPositions.isEmpty else { return -1 }
        
        // **Step 3: BFS for Shortest Path**
        let directions = [Coordinate(-1, 0), Coordinate(1, 0), Coordinate(0, -1), Coordinate(0, 1)]
        var queue: [(coord: Coordinate, steps: Int)] = [(start, 0)]
        var visited: Set<Coordinate> = [start]
        
        var localPortalMap = portalsMap  // Clone to avoid modifying global map
        
        while !queue.isEmpty {
            let (current, steps) = queue.removeFirst()
            
            // **Reached an Endpoint**
            if endPositions.contains(current) {
                return steps  // The first valid `"E"` reached is the shortest path
            }
            
            // **Explore Neighbors**
            for dir in directions {
                let newRow = current.row + dir.row
                let newCol = current.col + dir.col
                let newPos = Coordinate(newRow, newCol)
                
                if newRow >= 0, newRow < R, newCol >= 0, newCol < C,
                   !visited.contains(newPos), G[newRow][newCol] != "#" {
                    queue.append((newPos, steps + 1))
                    visited.insert(newPos)
                }
            }
            
            // **Use Portals Immediately**
            let cell = G[current.row][current.col]
            if let portals = localPortalMap[cell], cell == cell.lowercased() {
                for portalPos in portals where portalPos != current && !visited.contains(portalPos) {
                    queue.append((portalPos, steps + 1)) // Teleport instantly
                    visited.insert(portalPos)
                }
                localPortalMap[cell] = []  // Remove after use
            }
        }
        
        return -1 // If no path to `"E"` exists
    }
}
